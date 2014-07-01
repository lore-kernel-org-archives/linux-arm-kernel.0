From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 1 Jul 2014 07:17:23 -0700
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping,
 and synchronization
In-Reply-To: <20140701141541.GP28164@arm.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <20140701090309.GC28164@arm.com>
 <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
Message-ID: <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 7:15 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 01, 2014 at 03:11:04PM +0100, Nathan Lynch wrote:
>> On 07/01/2014 04:03 AM, Will Deacon wrote:
>> > On Mon, Jun 30, 2014 at 10:37:48PM +0100, Andy Lutomirski wrote:
>> >> On 06/22/2014 08:11 PM, Nathan Lynch wrote:
>> >>> Initialize the vdso page list at boot, install the vdso mapping at
>> >>> exec time, and update the data page during timer ticks.  This code is
>> >>> not built if CONFIG_VDSO is not enabled.
>> >>>
>> >>> Account for the vdso length when randomizing the offset from the
>> >>> stack.  The vdso is placed immediately following the sigpage with a
>> >>> separate install_special_mapping call in arm_install_vdso.
>> >
>> > [...]
>> >
>> >>> +/* assumes mmap_sem is write-locked */
>> >>> +void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
>> >>> +{
>> >>> + int ret;
>> >>> +
>> >>> + mm->context.vdso = ~0UL;
>> >>> +
>> >>> + if (vdso_pagelist == NULL)
>> >>> +         return;
>> >>> +
>> >>> + /*
>> >>> +  * Put vDSO base into mm struct before calling
>> >>> +  * install_special_mapping so the perf counter mmap tracking
>> >>> +  * code will recognise it as a vDSO.
>> >>> +  */
>> >>> + mm->context.vdso = addr;
>> >>> +
>> >>> + ret = install_special_mapping(mm, addr, vdso_mapping_len,
>> >>> +                               VM_READ|VM_EXEC|
>> >>> +                               VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>> >>> +                               vdso_pagelist);
>> >>
>> >> Eek.  You're mapping the shared data VM_MAYWRITE.  This will cause
>> >> bizarre and confusing failures if ptrace pokes at it.
>> >
>> > Hmm, but how else can we support software breakpoints on the vdso?
>>
>> I believe Andy is suggesting separate VMAs (with different VM flags) for
>> the VDSO's data and code.  So, breakpoints in code would work, but
>> attempts to modify the data page via ptrace() would fail outright
>> instead of silently COWing.
>
> Ah, yes. That makes a lot of sense for the data page -- we should do
> something similar on arm64 too, since the CoW will break everything for the
> task being debugged. We could also drop the EXEC flags too.

If you do this, I have a slight preference for the new vma being
called "[vvar]" to match x86.  It'll make the CRIU people happy if and
when they port it to ARM.

--Andy
