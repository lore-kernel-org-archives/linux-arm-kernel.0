From: keescook@chromium.org (Kees Cook)
Date: Mon, 21 Apr 2014 17:16:44 -0700
Subject: [RFC PATCH 1/3] ARM: kexec: Make kexec work with read-only kernel
 .text section
In-Reply-To: <CAGXu5jK9ZKPj1mQ23OTt05EwaGZy2-JL9ZX=jaQcdE=S=pjYpA@mail.gmail.com>
References: <1397062238-10515-1-git-send-email-Nikolay.Borisov@arm.com>
 <1397062238-10515-2-git-send-email-Nikolay.Borisov@arm.com>
 <CAGXu5jK9ZKPj1mQ23OTt05EwaGZy2-JL9ZX=jaQcdE=S=pjYpA@mail.gmail.com>
Message-ID: <CAGXu5j+Z7xvGrx-nBjwjaucjbosG9mFnji9cbxbf3sbxUMQEpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 11:13 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Apr 9, 2014 at 9:50 AM, Nikolay Borisov <Nikolay.Borisov@arm.com> wrote:
>> Currently, as part of preparing the machine to boot a new kernel, Arm's kexec
>> backend will patch some memory location which are allocated in the kernel's
>> .text section. This will work only if the aforementioned section is not set
>> to read-only, otherwise an OOPS will be produced  and kexec won't work.
>>
>> This patch modifies the way those memory location are being patched by first
>> copying them from the .text section (the template) to a special buffer and
>> then patching the values in the already-copied buffer, thus obviating the
>> need to touch the kernel's code section.
>>
>> Finally, given the fact that code now works irrespective whether the kexec stub
>> is RO or not just move it to .rodata
>>
>> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
>
> Thanks for working on this!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

...and now that I've actually got a kexec setup working, I've tested this too.

Tested-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

>
> -Kees
>
>> ---
>>  arch/arm/kernel/machine_kexec.c   | 58 +++++++++++++++++++++++++++++----------
>>  arch/arm/kernel/relocate_kernel.S |  3 ++
>>  2 files changed, 46 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
>> index f0d180d..ee55e2e 100644
>> --- a/arch/arm/kernel/machine_kexec.c
>> +++ b/arch/arm/kernel/machine_kexec.c
>> @@ -22,13 +22,15 @@
>>  extern void relocate_new_kernel(void);
>>  extern const unsigned int relocate_new_kernel_size;
>>
>> -extern unsigned long kexec_start_address;
>> -extern unsigned long kexec_indirection_page;
>> -extern unsigned long kexec_mach_type;
>> -extern unsigned long kexec_boot_atags;
>> +extern const unsigned long kexec_start_address;
>> +extern const unsigned long kexec_indirection_page;
>> +extern const unsigned long kexec_mach_type;
>> +extern const unsigned long kexec_boot_atags;
>>
>>  static atomic_t waiting_for_crash_ipi;
>>
>> +static unsigned long dt_mem;
>> +
>>  /*
>>   * Provide a dummy crash_notes definition while crash dump arrives to arm.
>>   * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
>> @@ -63,8 +65,13 @@ int machine_kexec_prepare(struct kimage *image)
>>                 if (err)
>>                         return err;
>>
>> +               /*
>> +                * We used to write directly to kexec_atag_boots
>> +                * this is forbidden when .text section is RO, cache it
>> +                * in a static var instead
>> +                */
>>                 if (be32_to_cpu(header) == OF_DT_HEADER)
>> -                       kexec_boot_atags = current_segment->mem;
>> +                       dt_mem = current_segment->mem;
>>         }
>>         return 0;
>>  }
>> @@ -139,9 +146,36 @@ void machine_crash_shutdown(struct pt_regs *regs)
>>   */
>>  void (*kexec_reinit)(void);
>>
>> +/*
>> + * Instead of patching the kernel .text (which might be Read-only by
>> + * CONFIG_DEBUG_RODATA), patch the already-copied template.
>> + */
>> +static void patch_boot_parameters(char *copied_template, struct kimage *image) {
>> +
>> +       unsigned long page_list = image->head & PAGE_MASK;
>> +       uintptr_t base = (uintptr_t)relocate_new_kernel & ~(uintptr_t)1;
>> +       uintptr_t start_addr_offset = (uintptr_t)&kexec_start_address - base;
>> +       uintptr_t indir_page_offset = (uintptr_t)&kexec_indirection_page - base;
>> +       uintptr_t mach_type_offset = (uintptr_t)&kexec_mach_type - base;
>> +       uintptr_t boot_atags_offset = (uintptr_t)&kexec_boot_atags - base;
>> +
>> +#define patch_value(offset,res) \
>> +       *(unsigned long *)(copied_template + (offset)) = (res)
>> +
>> +       patch_value(start_addr_offset, image->start);
>> +       patch_value(indir_page_offset, page_list);
>> +       patch_value(mach_type_offset, machine_arch_type);
>> +
>> +       if (!dt_mem)
>> +               patch_value(boot_atags_offset, image->start -
>> +                                KEXEC_ARM_ZIMAGE_OFFSET +
>> +                                KEXEC_ARM_ATAGS_OFFSET);
>> +       else
>> +               patch_value(boot_atags_offset, dt_mem);
>> +}
>> +
>>  void machine_kexec(struct kimage *image)
>>  {
>> -       unsigned long page_list;
>>         unsigned long reboot_code_buffer_phys;
>>         unsigned long reboot_entry = (unsigned long)relocate_new_kernel;
>>         unsigned long reboot_entry_phys;
>> @@ -155,21 +189,12 @@ void machine_kexec(struct kimage *image)
>>          */
>>         BUG_ON(num_online_cpus() > 1);
>>
>> -       page_list = image->head & PAGE_MASK;
>>
>>         /* we need both effective and real address here */
>>         reboot_code_buffer_phys =
>>             page_to_pfn(image->control_code_page) << PAGE_SHIFT;
>>         reboot_code_buffer = page_address(image->control_code_page);
>>
>> -       /* Prepare parameters for reboot_code_buffer*/
>> -       kexec_start_address = image->start;
>> -       kexec_indirection_page = page_list;
>> -       kexec_mach_type = machine_arch_type;
>> -       if (!kexec_boot_atags)
>> -               kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
>> -
>> -
>>         /* copy our kernel relocation code to the control code page */
>>         reboot_entry = fncpy(reboot_code_buffer,
>>                              reboot_entry,
>> @@ -177,6 +202,9 @@ void machine_kexec(struct kimage *image)
>>         reboot_entry_phys = (unsigned long)reboot_entry +
>>                 (reboot_code_buffer_phys - (unsigned long)reboot_code_buffer);
>>
>> +       /* Prepare parameters for reboot_code_buffer*/
>> +       patch_boot_parameters(reboot_code_buffer, image);
>> +
>>         printk(KERN_INFO "Bye!\n");
>>
>>         if (kexec_reinit)
>> diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
>> index 9585896..a8eb0e0 100644
>> --- a/arch/arm/kernel/relocate_kernel.S
>> +++ b/arch/arm/kernel/relocate_kernel.S
>> @@ -5,6 +5,9 @@
>>  #include <linux/linkage.h>
>>  #include <asm/kexec.h>
>>
>> +/* Exectution of this template in place is a bug: make it non-executable: */
>> +       .section .rodata, "a"
>> +
>>         .align  3       /* not needed for this code, but keeps fncpy() happy */
>>
>>  ENTRY(relocate_new_kernel)
>> --
>> 1.8.1.5
>>
>>
>
>
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security
