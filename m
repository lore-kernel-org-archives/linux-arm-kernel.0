From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 24 Oct 2017 12:38:05 +0100
Subject: [RFC PATCH] arm64/sve: ABI change: Zero SVE regs on syscall entry
In-Reply-To: <87tvypiyg8.fsf@linaro.org>
References: <1508758664-24186-1-git-send-email-Dave.Martin@arm.com>
 <1508758664-24186-2-git-send-email-Dave.Martin@arm.com>
 <87tvypiyg8.fsf@linaro.org>
Message-ID: <20171024113805.GF19485@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Richard, can you comment below on likely code generation choices in the
compiler?]

On Mon, Oct 23, 2017 at 06:08:39PM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > As currently documented, no guarantee is made about what a user
> > task sees in the SVE registers after a syscall, except that V0-V31
> > (corresponding to Z0-Z31 bits [127:0]) are preserved.
> >
> > The actual kernel behaviour currently implemented is that the SVE
> > registers are zeroed if a context switch or signal delivery occurs
> > during a syscall.  After a fork() or clone(), the SVE registers
> > of the child task are zeroed also.  The SVE registers are otherwise
> > preserved.  Flexibility is retained in the ABI about the exact
> > criteria for the decision.
> >
> > There are some potential problems with this approach.
> >
> > Syscall impact
> > --------------
> >
> > Will, Catalin and Mark have expressed concerns about the risk of
> > creating de facto ABI here: in scenarios or workloads where a
> > context switch never occurs or is very unlikely, userspace may
> > learn to rely on preservation of the SVE registers across certain
> > syscalls.
> 
> I think this is a reasonable concern but are there any equivalent cases
> in the rest of the kernel? Is this new territory for Linux as these
> super large registers are introduced?

Not that I know of.

My implementation is influenced by the SVE register set size (which is
up to > 4 times the size of any other in mainline that I know of), and
the lack of architectural commitment to now growing the size further
in the future.

> > It is difficult to assess the impact of this: the syscall ABI is
> > not a general-purpose interface, since it is usually hidden behind
> > libc wrappers: direct invocation of SVC is discouraged.  However,
> > specialised runtimes, statically linked programs and binary blobs
> > may bake in direct syscalls that make bad assumptions.
> >
> > Conversely, the relative cost of zeroing the SVE regs to mitigate
> > against this also cannot be well characterised until SVE hardware
> > exists.
> >
> > ptrace impact
> > -------------
> >
> > The current implementation can discard and zero the SVE registers
> > at any point during a syscall, including before, after or between
> > ptrace traps inside a single syscall.  This means that setting the
> > SVE registers through PTRACE_SETREGSET will often not do what the
> > user expects: the new register values are only guaranteed to
> > survive as far as userspace if set from an asynchronous
> > signal-delivery-stop (e.g., breakpoint, SEGV or asynchronous signal
> > delivered outside syscall context).
> >
> > This is consistent with the currently documented SVE user ABI, but
> > likely to be surprising for a debugger user, since setting most
> > registers of a tracee doesn't behave in this way.
> >
> > This patch
> > ----------
> >
> > The common syscall entry path is modified to forcibly discard SVE,
> > and the discard logic elsewhere is removed.
> >
> > This means that there is a mandatory additional trap to the kernel
> > when a user task tries to use SVE again after a syscall.  This can
> > be expensive for programs that use SVE heavily around syscalls, but
> > can be optimised later.
> 
> Won't it impact every restart from syscall? It's a shame you have to

Only if SVE is used.

The average extra cost is going to be proportional to rate of execution
of syscall...syscall intervals where SVE is used, so

	for (;;) {
		syscall();
		crunch_huge_data()
	}

might cause up to 20 extra SVE traps per second if crunch_huge_data()
takes 50ms say; whereas

	for (;;) {
		syscall();
		crunch_trivial_data();
	}

would cause up to 100000 extra SVE traps per second if
crunch_trivial_data() takes 10us.  That's much worse.


I think the worst realistic case here is use of gcc -mfpu=sve (or
whatever the option would be called).  In that case though, the
compiler _should_ consider the caller-saveness of the SVE regs when
computing cost tradeoffs for code generation around external function
calls -- this may hide much of the penalty in practice.


It's easy to write a worst-case microbenchmark though, and people will
inevitably do that sooner or later...

> trap when I suspect most first accesses after a syscall are likely to be
> either restoring the caller-saved values which assume the value is
> trashed anyway.

So, this was may main argument: in practice the SVE regs will never be
live at syscall entry.  If they were, the caller would have needed to
save them off anyway.

> Adding gettimeofday() or write(stdout) while debugging
> is going to kill performance.

Sure, but adding a syscall inside your core loop is going to kill
performance anyway.  (gettimeofday() calls the vdso, so that won't
hit this issue).


Note, we don't really need to take a trap after every syscall: that's my
current implementation, but I will optimise later zero the regs in-place
and avoid the extra trap for this situation.  This should be much
cheaper than the current do_sve_acc() path.

Cheers
---Dave
