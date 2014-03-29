From: steve.capper@linaro.org (Steve Capper)
Date: Sat, 29 Mar 2014 12:18:59 +0000
Subject: [PATCH v5] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <CAGXu5jK01s1L=rF=gHKnks8scBvLY6uC_s7RO2+ecvp1Gw7wNg@mail.gmail.com>
References: <1395695873-12807-1-git-send-email-nathan_lynch@mentor.com>
 <CAGXu5jKojxJyhKSpPtLDT8Cw4wwUiKauoFUP5xuSJnKioDXGrQ@mail.gmail.com>
 <5334C04C.2050802@mentor.com>
 <CAGXu5jK01s1L=rF=gHKnks8scBvLY6uC_s7RO2+ecvp1Gw7wNg@mail.gmail.com>
Message-ID: <CAPvkgC2oKP025LZCrN5KOvY8Sz3znUM0w6cf5vQ5zFsLntidFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2014 18:42, Kees Cook <keescook@google.com> wrote:
> On Thu, Mar 27, 2014 at 5:20 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
>> On 03/27/2014 06:06 PM, Kees Cook wrote:
>>> On Mon, Mar 24, 2014 at 2:17 PM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
[ ... ]
>>
>> For setting breakpoints in the text area.  FWIW powerpc's
>> arch_setup_additional_pages has this comment:
>>
>> /*
>>  * our vma flags don't have VM_WRITE so by default, the process isn't
>>  * allowed to write those pages.
>>  * gdb can break that with ptrace interface, and thus trigger COW on
>>  * those pages but it's then your responsibility to never do that on
>>  * the "data" page of the vDSO or you'll stop getting kernel updates
>>  * and your nice userland gettimeofday will be totally dead.
>>  * It's fine to use that for setting breakpoints in the vDSO code
>>  * pages though.
>>  */
>> rc = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
>>                              VM_READ|VM_EXEC|
>>                              VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>>                              vdso_pagelist);
>
> Ah-ha, thanks. As long as I'm asking dumb questions about vm
> internals... where is the COW flag for these pages stored? Nothing
> jumped out at me when I was reading install_special_mapping.
>

>From what I can see:

VM_MAYWRITE is placed into the VMA representing the VDSO by
install_special_mapping. A read only, executable pte will then be
placed down later on fault.

The debugger will at some point call ptrace with PTRACE_POKETEXT to
set a breakpoint in the VDSO. This will lead to a call to
generic_ptrace_pokedata which will call access_process_vm which will
call get_user_pages with the force and write flags set. As force is
set, get_user_pages uses VM_MAYWRITE to determine whether or not
writes are supported. A call to handle_mm_fault with FAULT_FLAG_WRITE
is then issued and that results in a COW taking place (as the
userspace pte is not writeable). The new COWed page will still not be
writeable (as the VMA does not have the VM_WRITE flag), but it will be
a separate copy. access_process_vm will then kmap the COWed page and
write data to it. So at the end we have modified .text that will still
not be writeable by userspace.

Subsequent ptraces with PTRACE_POKETEXT will lead to do_wp_page
re-using the COW'ed page as it will be anonymous with only one
reference (unless a fork took place).

Cheers,
-- 
Steve
