From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 1 Jul 2014 07:09:46 -0700
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping,
 and synchronization
In-Reply-To: <53B2BF2A.4070407@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <53B2BF2A.4070407@mentor.com>
Message-ID: <CALCETrV=m1v=YuAYVBdRroGWY+nYEfWQbFYKD+su-n_xDBeGKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 7:01 AM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 06/30/2014 04:37 PM, Andy Lutomirski wrote:
>> On 06/22/2014 08:11 PM, Nathan Lynch wrote:
>>> +void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
>>> +{
>>> +    int ret;
>>> +
>>> +    mm->context.vdso = ~0UL;
>>> +
>>> +    if (vdso_pagelist == NULL)
>>> +            return;
>>> +
>>> +    /*
>>> +     * Put vDSO base into mm struct before calling
>>> +     * install_special_mapping so the perf counter mmap tracking
>>> +     * code will recognise it as a vDSO.
>>> +     */
>>> +    mm->context.vdso = addr;
>>> +
>>> +    ret = install_special_mapping(mm, addr, vdso_mapping_len,
>>> +                                  VM_READ|VM_EXEC|
>>> +                                  VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>>> +                                  vdso_pagelist);
>>
>> Eek.  You're mapping the shared data VM_MAYWRITE.  This will cause
>> bizarre and confusing failures if ptrace pokes at it.
>
> I'm aware of that.  One could argue (as does the author of the
> equivalent code in powerpc) that this is a "well, don't do that"
> situation.  But I tend to agree that it would be nicer to prevent this
> failure mode.
>
>
>> You also seem to
>> be sticking it *before* the vdso in the same vma.  This will severely
>> piss off all the tools that assume that "[vdso]" points to an ELF object.
>
> Hmm, which tools?  Shouldn't they be consulting AT_SYSINFO_EHDR in the
> auxiliary vector instead?
>

There were a bunch of random things written before getauxvec(3) was
introduced that look for "[vdso]"

gdb is also a bit weird.  I think it's changed a couple times, but
IIRC it looks for a vma that has a start address that matches
AT_SYSINFO_EDHR, and then it parses the ELF header and *section*
headers (sigh) in that vma.  So if I'm remembering correctly, it just
won't notice the vdso at all of AT_SYSINFO_EHDR and the vma start
aren't the same.

>
>> x86 calls this thing "[vvar]" and sticks it after the vdso.  You might
>> not want to have the complexity of sticking it after the vdso (it's
>> distinctly nontrivial), but I see nothing wrong with giving it its own
>> vma just before the vdso.  The new _install_special_mapping function
>> makes it considerably easier to do.
>
> I'll give this a shot, thanks.
>

--Andy
