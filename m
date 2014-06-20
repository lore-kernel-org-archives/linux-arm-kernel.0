From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 11:22:59 +0100
Subject: [PATCH] arm: ptrace: fix syscall modification under
 PTRACE_O_TRACESECCOMP
In-Reply-To: <20140618202748.GA9022@www.outflux.net>
References: <20140618202748.GA9022@www.outflux.net>
Message-ID: <20140620102258.GA26626@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

I'm struggling to see the bug in the current code, so apologies if my
questions aren't helpful.

On Wed, Jun 18, 2014 at 09:27:48PM +0100, Kees Cook wrote:
> An x86 tracer wanting to change the syscall uses PTRACE_SETREGS
> (stored to regs->orig_ax), and an ARM tracer uses PTRACE_SET_SYSCALL
> (stored to current_thread_info()->syscall). When this happens, the
> syscall can change across the call to secure_computing(), since it may
> block on tracer notification, and the tracer can then make changes
> to the process, before we return from secure_computing(). This
> means the code must respect the changed syscall after the
> secure_computing() call in syscall_trace_enter(). The same is true
> for tracehook_report_syscall_entry() which may also block and change
> the syscall.

I don't think I understand what you mean by `the code must respect the
changed syscall'. The current code does indeed issue the new syscall, so are
you more concerned with secure_computing changing ->syscall, then the
debugger can't see the new syscall when it sees the trap from tracehook?
Are these even supposed to inter-operate?

> The x86 code handles this (it expects orig_ax to always be the
> desired syscall). In the ARM case, this means we should not be touching
> current_thread_info()->syscall after its initial assignment. All failures
> should result in a -1 syscall, though.

The only time we explicitly touch ->syscall is when we're aborting the call
(i.e. writing -1), which I think is fine.

Will
