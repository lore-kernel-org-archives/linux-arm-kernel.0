From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Sep 2018 17:57:26 +0100
Subject: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and
 PTRACE_SYSEMU_SINGLESTEP support
In-Reply-To: <102400624.EOB2phcGqB@blindfold>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903163103.GC6954@arm.com> <102400624.EOB2phcGqB@blindfold>
Message-ID: <20180903165726.GJ6954@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
> > >  arch/arm64/include/uapi/asm/ptrace.h |  2 ++
> > >  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > What is PTRACE_SYSEMU and what is its semantics? Why isn't it done in the
> > core ptrace code?
> 
> It is an optimization added for UserModeLinux many years ago.
> PTRACE_SYSEMU basically allows you to handle system calls in user space
> without the kernel seeing them.
> Before that UML had to render every system call into a no-op, e.h. getpid().
> This was complicated and slow.

Ok, thanks for the insight!

> The ptrace() manpage has a section on PTRACE_SYSEMU, more documentation on the
> semantics is not available.

:( We already have tracehook, seccomp, tracepoint and audit fighting with
each other on syscall entry, so I'm really not keen to add another player to
the game unless we really have to.

Has anybody tried implementing this using tracehook?

> And yes, I think this should also done in the core. Like many other ptrace() areas
> this needs a cleanup. ;-)
> 
> I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> Are you porting UML or gvisor to arm64?

That's a good question. Haibo?

Will
