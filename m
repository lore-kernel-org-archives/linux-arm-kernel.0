From: keescook@google.com (Kees Cook)
Date: Fri, 28 Mar 2014 11:42:10 -0700
Subject: [PATCH v5] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <5334C04C.2050802@mentor.com>
References: <1395695873-12807-1-git-send-email-nathan_lynch@mentor.com>
 <CAGXu5jKojxJyhKSpPtLDT8Cw4wwUiKauoFUP5xuSJnKioDXGrQ@mail.gmail.com>
 <5334C04C.2050802@mentor.com>
Message-ID: <CAGXu5jK01s1L=rF=gHKnks8scBvLY6uC_s7RO2+ecvp1Gw7wNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 5:20 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 03/27/2014 06:06 PM, Kees Cook wrote:
>> On Mon, Mar 24, 2014 at 2:17 PM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
>>> +
>>> +/* assumes mmap_sem is write-locked */
>>> +void arm_install_vdso(struct mm_struct *mm)
>>> +{
>>> +       unsigned long vdso_base;
>>> +       int ret;
>>> +
>>> +       mm->context.vdso = ~0UL;
>>> +
>>> +       if (vdso_pagelist == NULL)
>>> +               return;
>>> +
>>> +       vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
>>
>> While get_unmapped_area() should be returning an address that has been
>> base-offset randomized, I notice that x86 actually moves its vdso to a
>> random location near the stack instead (see vdso_addr() in
>> arch/x86/vdso/vma.c), in theory to avoid a hole in memory and to
>> separately randomize the vdso separately from heap and stack. I think
>> a similar thing be a benefit on ARM too.
>
> OK, I'll look into this.  Perhaps a similar treatment for the sigpage?

Oh, yeah. Unless there's a reason not too, it would be nice, yes.

> I notice on my systems (OMAP5 and i.MX6) that vdso, sigpage, and ld.so
> are always mapped consecutively:
>
> # grep -A2 vdso /proc/self/maps
> b6f44000-b6f46000 r-xp 00000000 00:00 0          [vdso]
> b6f46000-b6f47000 r-xp 00000000 00:00 0          [sigpage]
> b6f47000-b6f48000 r--p 00016000 00:01 1254       /lib/ld-2.19.90.so
>
> but I wonder if that's due to starved entropy pools, or is the VM
> already trying to prevent holes?

Right, this is because (I think) they're all using un-hinted
get_unmapped_area(), which allocates consecutively. The base address
is randomized, so each process should have a different starting
address for the start of the range used to fulfill get_unmapped_area()
calls.

>
>
>>> +       if (IS_ERR_VALUE(vdso_base)) {
>>> +               pr_notice_once("%s: get_unapped_area failed (%ld)\n",
>>> +                              __func__, (long)vdso_base);
>>> +               return;
>>> +       }
>>> +
>>> +       /*
>>> +        * Put vDSO base into mm struct before calling
>>> +        * install_special_mapping so the perf counter mmap tracking
>>> +        * code will recognise it as a vDSO.
>>> +        */
>>> +       mm->context.vdso = vdso_base;
>>> +
>>> +       ret = install_special_mapping(mm, vdso_base, vdso_mapping_len,
>>> +                                     VM_READ|VM_EXEC|
>>> +                                     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>>> +                                     vdso_pagelist);
>>
>> Why is this given VM_MAYWRITE? (I would ask the same about x86's
>> implementation too.)
>
> For setting breakpoints in the text area.  FWIW powerpc's
> arch_setup_additional_pages has this comment:
>
> /*
>  * our vma flags don't have VM_WRITE so by default, the process isn't
>  * allowed to write those pages.
>  * gdb can break that with ptrace interface, and thus trigger COW on
>  * those pages but it's then your responsibility to never do that on
>  * the "data" page of the vDSO or you'll stop getting kernel updates
>  * and your nice userland gettimeofday will be totally dead.
>  * It's fine to use that for setting breakpoints in the vDSO code
>  * pages though.
>  */
> rc = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
>                              VM_READ|VM_EXEC|
>                              VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>                              vdso_pagelist);

Ah-ha, thanks. As long as I'm asking dumb questions about vm
internals... where is the COW flag for these pages stored? Nothing
jumped out at me when I was reading install_special_mapping.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
