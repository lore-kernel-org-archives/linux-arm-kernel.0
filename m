From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Thu, 8 Aug 2013 11:46:03 +0530
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <51FFC490.5090907@codethink.co.uk>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <51FFC490.5090907@codethink.co.uk>
Message-ID: <CALicx6u4cOLCzia8oxKKCrC=d+pxJmWWvLH++ZXVkvNVWV65DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 5, 2013 at 8:58 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 05/08/13 13:12, Vijay Kilari wrote:
>>
>> Hi Will,
>>
>> I am trying to make kexec work on BE kernel on ARM VE TC2.
>>
>> First, to make KEXEC work with SMP on ARM VE TC2 board,
>> I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
>>
>> However, I made below changes to make KEXEC work for BE kernel.
>> my question is: why delay is required for board to reboot with kexec?.
>> Is it platform issue?.
>>
>> diff --git a/arch/arm/kernel /machine_kexec.c
>> b/arch/arm/kernel/machine_kexec.c
>> index 4fb074c..0fb0ff9 100644
>> --- a/arch/arm/kernel/machine_kexec.c
>> +++ b/arch/arm/kernel/machine_kexec.c
>> @@ -123,6 +123,18 @@ void machine_crash_shutdown(struct pt_regs *regs)
>>          printk(KERN_INFO "Loading crashdump kernel...\n");
>>   }
>>
>> +static void byte_copy_relocate_kernel(void *dst, const void *src, int
>> size)
>> +{
>> +        char *d, *s;
>> +        d = (char *) dst;
>> +        s = (char *) src;
>> +        while (size>  0)
>> +        {
>> +                *d++ = *s++;
>> +                size--;
>> +        }
>> +}
>> +
>>   /*
>>    * Function pointer to optional machine-specific reinitialization
>>    */
>> @@ -155,9 +167,8 @@ void machine_kexec(struct kimage *image)
>>
>>
>>          /* copy our kernel relocation code to the control code page */
>> -       memcpy(reboot_code_buffer,
>> -              relocate_new_kernel, relocate_new_kernel_size);
>> -
>> +       byte_copy_relocate_kernel(reboot_code_buffer,
>> +              relocate_new_kernel, relocate_new_kernel_size);
>
>
> you should be able to use memcpy() here, as it shouldn't change the
> endian-ness of the data being copied.
>

Yes, you are right. I see that memcpy() works. However I see strange issue
with  Kexec on BE kernel. If I put debug print in arch/arm/kernel/head.S code
before turning on MMU, KEXEC works. if I remove the debug print kexec
boot hangs.
So I could not relate how calling printascii is solving the problem

Any suggestion?

If printascii is called after turning on mmu, kexec hangs. Below is my
debug code

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 5b391a6..15d4504 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -175,6 +175,15 @@ __lookup_processor_type_data:
        .long   __proc_info_end
        .size   __lookup_processor_type_data, . - __lookup_processor_type_data

+__print_debug:
+       stmfd   sp!, {r0 - r6, r9, lr}
+       adr r0, str_p3
+       bl printascii
+       ldmfd   sp!, {r0 - r6, r9, pc}
+str_p3: .asciz "\nHere"
+       .align
+ENDPROC(__print_debug)
+
 __error_p:
 #ifdef CONFIG_DEBUG_LL
        adr     r0, str_p1
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index d509995..a19147c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -114,7 +114,7 @@ ENTRY(stext)
 #else
        ldr     r8, =PHYS_OFFSET                @ always constant in this case
 #endif
-
+       bl      __print_debug
        /*
         * r1 = machine no, r2 = atags or dtb,
         * r8 = phys_offset, r9 = cpuid, r10 = procinfo


> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
