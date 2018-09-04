From: Haibo.Xu@arm.com (Haibo Xu (Arm Technology China))
Date: Tue, 4 Sep 2018 02:11:07 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0L3B0cmFjZTogYWRkIFBUUkFDRV9TWVNF?=
 =?utf-8?B?TVUgYW5kIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCBzdXBwb3J0?=
In-Reply-To: <20180903165726.GJ6954@arm.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903163103.GC6954@arm.com> <102400624.EOB2phcGqB@blindfold>
 <20180903165726.GJ6954@arm.com>
Message-ID: <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> On Mon, Sep 03, 2018 at 06:40:51PM +0200, Richard Weinberger wrote:
> > Am Montag, 3. September 2018, 18:31:03 CEST schrieb Will Deacon:
> > > On Mon, Sep 03, 2018 at 02:23:17PM +0800, Haibo.Xu wrote:
> > > > Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on ARM64.
> > > > This copies the x86 semantics for invoking ptrace hooks, and have
> > > > been verified on ARM64 machine.
> > > >
> > > > Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
> > > > Signed-off-by: Bin.Lu <bin.lu@arm.com>
> > > > ---
> > > >  arch/arm64/include/asm/thread_info.h |  5 ++++-
> > > > arch/arm64/include/uapi/asm/ptrace.h |  2 ++
> > > >  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
> > > >  3 files changed, 23 insertions(+), 1 deletion(-)
> > >
> > > What is PTRACE_SYSEMU and what is its semantics? Why isn't it done
> > > in the core ptrace code?
> >
> > It is an optimization added for UserModeLinux many years ago.
> > PTRACE_SYSEMU basically allows you to handle system calls in user
> > space without the kernel seeing them.
> > Before that UML had to render every system call into a no-op, e.h. getpid().
> > This was complicated and slow.
>
> Ok, thanks for the insight!
>

Thanks for Richard's comments!

> > The ptrace() manpage has a section on PTRACE_SYSEMU, more
> > documentation on the semantics is not available.
>
> :( We already have tracehook, seccomp, tracepoint and audit fighting with each other on syscall entry, so I'm really not keen to add another player to the game unless we really have to.
>
> Has anybody tried implementing this using tracehook?
>

Currently, it seems nobody has tried it.

> > And yes, I think this should also done in the core. Like many other
> > ptrace() areas this needs a cleanup. ;-)
> >

Hi Richard,

What do you mean by done it in the core? moving macro definition to include/uapi/linux/ptrace.h?
The patch is strictly follow x86's sematic on PTRACE_SYSEMU/SINGLESTEP support.

> > I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> > Are you porting UML or gvisor to arm64?
>
> That's a good question. Haibo?

The story is we are working on a container runtime(Google Gvisor) support on ARM64 platform,
and the Gvisor depend on Linux kernel PTRACE_SYSEMU/SINGLESTEP support.

Haibo
-----????-----
???: Will Deacon <will.deacon@arm.com>
????: 2018?9?4? 0:57
???: Richard Weinberger <richard@nod.at>
??: Haibo Xu (Arm Technology China) <Haibo.Xu@arm.com>; Catalin Marinas <Catalin.Marinas@arm.com>; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; nd <nd@arm.com>; jdike at addtoit.com
??: Re: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support

Hi Richard,

On Mon, Sep 03, 2018 at 06:40:51PM +0200, Richard Weinberger wrote:
> Am Montag, 3. September 2018, 18:31:03 CEST schrieb Will Deacon:
> > On Mon, Sep 03, 2018 at 02:23:17PM +0800, Haibo.Xu wrote:
> > > Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on ARM64.
> > > This copies the x86 semantics for invoking ptrace hooks, and have
> > > been verified on ARM64 machine.
> > >
> > > Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
> > > Signed-off-by: Bin.Lu <bin.lu@arm.com>
> > > ---
> > >  arch/arm64/include/asm/thread_info.h |  5 ++++-
> > > arch/arm64/include/uapi/asm/ptrace.h |  2 ++
> > >  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
> >
> > What is PTRACE_SYSEMU and what is its semantics? Why isn't it done
> > in the core ptrace code?
>
> It is an optimization added for UserModeLinux many years ago.
> PTRACE_SYSEMU basically allows you to handle system calls in user
> space without the kernel seeing them.
> Before that UML had to render every system call into a no-op, e.h. getpid().
> This was complicated and slow.

Ok, thanks for the insight!

> The ptrace() manpage has a section on PTRACE_SYSEMU, more
> documentation on the semantics is not available.

:( We already have tracehook, seccomp, tracepoint and audit fighting with each other on syscall entry, so I'm really not keen to add another player to the game unless we really have to.

Has anybody tried implementing this using tracehook?

> And yes, I think this should also done in the core. Like many other
> ptrace() areas this needs a cleanup. ;-)
>
> I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> Are you porting UML or gvisor to arm64?

That's a good question. Haibo?

Will
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
