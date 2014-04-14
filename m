From: keescook@google.com (Kees Cook)
Date: Mon, 14 Apr 2014 15:05:26 -0700
Subject: [PATCH v5] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <53470616.9020502@mentor.com>
References: <1395695873-12807-1-git-send-email-nathan_lynch@mentor.com>
 <CAGXu5jKojxJyhKSpPtLDT8Cw4wwUiKauoFUP5xuSJnKioDXGrQ@mail.gmail.com>
 <5334C04C.2050802@mentor.com>
 <CAGXu5jK01s1L=rF=gHKnks8scBvLY6uC_s7RO2+ecvp1Gw7wNg@mail.gmail.com>
 <53470616.9020502@mentor.com>
Message-ID: <CAGXu5jL+ZiFdympLGz6GBTVq0gOqvDAeUnhfAZFjj6FO5GEqHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 1:59 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> Hi Kees,
>
> On 03/28/2014 01:42 PM, Kees Cook wrote:
>> On Thu, Mar 27, 2014 at 5:20 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
>>> On 03/27/2014 06:06 PM, Kees Cook wrote:
>>>> On Mon, Mar 24, 2014 at 2:17 PM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
>>>>> +
>>>>> +/* assumes mmap_sem is write-locked */
>>>>> +void arm_install_vdso(struct mm_struct *mm)
>>>>> +{
>>>>> +       unsigned long vdso_base;
>>>>> +       int ret;
>>>>> +
>>>>> +       mm->context.vdso = ~0UL;
>>>>> +
>>>>> +       if (vdso_pagelist == NULL)
>>>>> +               return;
>>>>> +
>>>>> +       vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
>>>>
>>>> While get_unmapped_area() should be returning an address that has been
>>>> base-offset randomized, I notice that x86 actually moves its vdso to a
>>>> random location near the stack instead (see vdso_addr() in
>>>> arch/x86/vdso/vma.c), in theory to avoid a hole in memory and to
>>>> separately randomize the vdso separately from heap and stack. I think
>>>> a similar thing be a benefit on ARM too.
>>>
>>> OK, I'll look into this.  Perhaps a similar treatment for the sigpage?
>>
>> Oh, yeah. Unless there's a reason not too, it would be nice, yes.
>
> So I've checked into this, and it appears that get_unmapped_area already
> returns addresses that are randomized with respect to the stack.

Right, they're already randomized with respect to the stack, but not
with respect to other mmap regions. (As in, on x86 there are 3
separately randomized base addresses: stack, mmap, vdso.) The comment
about stack was that it is randomized _near_ the stack, so it's out of
the way of further mmap allocations.

> Using the instrumentation below on 3.14 without vdso patches:
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 92f7b15dd221..672ad588e8d0 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -480,28 +480,35 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>  static struct page *signal_page;
>  extern struct page *get_signal_page(void);
>
>  int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  {
>         struct mm_struct *mm = current->mm;
>         unsigned long addr;
> +       long offset;
>         int ret;
>
>         if (!signal_page)
>                 signal_page = get_signal_page();
>         if (!signal_page)
>                 return -ENOMEM;
>
>         down_write(&mm->mmap_sem);
>         addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
>         if (IS_ERR_VALUE(addr)) {
>                 ret = addr;
>                 goto up_fail;
>         }
>
> +       offset = addr - PAGE_ALIGN(mm->start_stack);
> +
> +       pr_info("pgoffset sigpage (%p) vs. start_stack (%p): %ld\n",
> +               (void *)addr, (void *)PAGE_ALIGN(mm->start_stack),
> +               offset >> PAGE_SHIFT);
> +
>         ret = install_special_mapping(mm, addr, PAGE_SIZE,
>                 VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
>                 &signal_page);
>
>         if (ret == 0)
>                 mm->context.sigpage = addr;
>
>
> I observe a reasonable distribution of offsets, doing something like:
> # dmesg -c >/dev/null
> # i=0; while ((i++<1000)); do /bin/true ; done
> # dmesg | cut -d' ' -f 7 | sort -n | uniq -c
>
> Likely I'm just misunderstanding something, but if not, I'm left
> wondering what benefit the x86 vdso_addr algorithm (or something like
> it) would provide.

The benefit is that leaks of base addresses don't leak into the other
randomized regions. e.g. learning the vdso base offset doesn't help an
attacker learn were shared libraries are loaded, etc.

-Kees

-- 
Kees Cook
Chrome OS Security
