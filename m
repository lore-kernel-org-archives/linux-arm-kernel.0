From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Mon, 23 Oct 2017 18:08:39 +0100
Subject: [RFC PATCH] arm64/sve: ABI change: Zero SVE regs on syscall entry
In-Reply-To: <1508758664-24186-2-git-send-email-Dave.Martin@arm.com>
References: <1508758664-24186-1-git-send-email-Dave.Martin@arm.com>
 <1508758664-24186-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <87tvypiyg8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> As currently documented, no guarantee is made about what a user
> task sees in the SVE registers after a syscall, except that V0-V31
> (corresponding to Z0-Z31 bits [127:0]) are preserved.
>
> The actual kernel behaviour currently implemented is that the SVE
> registers are zeroed if a context switch or signal delivery occurs
> during a syscall.  After a fork() or clone(), the SVE registers
> of the child task are zeroed also.  The SVE registers are otherwise
> preserved.  Flexibility is retained in the ABI about the exact
> criteria for the decision.
>
> There are some potential problems with this approach.
>
> Syscall impact
> --------------
>
> Will, Catalin and Mark have expressed concerns about the risk of
> creating de facto ABI here: in scenarios or workloads where a
> context switch never occurs or is very unlikely, userspace may
> learn to rely on preservation of the SVE registers across certain
> syscalls.

I think this is a reasonable concern but are there any equivalent cases
in the rest of the kernel? Is this new territory for Linux as these
super large registers are introduced?

> It is difficult to assess the impact of this: the syscall ABI is
> not a general-purpose interface, since it is usually hidden behind
> libc wrappers: direct invocation of SVC is discouraged.  However,
> specialised runtimes, statically linked programs and binary blobs
> may bake in direct syscalls that make bad assumptions.
>
> Conversely, the relative cost of zeroing the SVE regs to mitigate
> against this also cannot be well characterised until SVE hardware
> exists.
>
> ptrace impact
> -------------
>
> The current implementation can discard and zero the SVE registers
> at any point during a syscall, including before, after or between
> ptrace traps inside a single syscall.  This means that setting the
> SVE registers through PTRACE_SETREGSET will often not do what the
> user expects: the new register values are only guaranteed to
> survive as far as userspace if set from an asynchronous
> signal-delivery-stop (e.g., breakpoint, SEGV or asynchronous signal
> delivered outside syscall context).
>
> This is consistent with the currently documented SVE user ABI, but
> likely to be surprising for a debugger user, since setting most
> registers of a tracee doesn't behave in this way.
>
> This patch
> ----------
>
> The common syscall entry path is modified to forcibly discard SVE,
> and the discard logic elsewhere is removed.
>
> This means that there is a mandatory additional trap to the kernel
> when a user task tries to use SVE again after a syscall.  This can
> be expensive for programs that use SVE heavily around syscalls, but
> can be optimised later.

Won't it impact every restart from syscall? It's a shame you have to
trap when I suspect most first accesses after a syscall are likely to be
either restoring the caller-saved values which assume the value is
trashed anyway. Adding gettimeofday() or write(stdout) while debugging
is going to kill performance.

--
Alex Benn?e
