From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Jan 2018 13:18:51 +0000
Subject: arm64: Unimplemented syscall kernel message
In-Reply-To: <20180121174401.GA44039@dinsnail.net>
References: <20180121174401.GA44039@dinsnail.net>
Message-ID: <20180122131851.GA28638@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sun, Jan 21, 2018 at 06:44:01PM +0100, Michael Weiser wrote:
> I'd like ask your opinion as arm64 Linux port maintainers and initial
> authors of the code in question regarding kernel messages on
> unimplemented system calls. I apologise in advance if that isn't the
> right approach (and Cc: linux-arm :).
> 
> Currently, a programm doing an unimplemented syscall triggers a rather
> scary looking kernel message:
> 
> [  189.143682] glibc-test[2118]: syscall 1000
> [  189.143728] Code: aa0503e4 aa0603e5 aa0703e6 d4000001 (b13ffc1f) 
> [  189.143750] CPU: 1 PID: 2118 Comm: glibc-test Not tainted 4.15.0-rc7-00232-g2c1cfa499018 #3
> [  189.143755] Hardware name: SoPine with baseboard (DT)
> [  189.143762] pstate: 80000000 (Nzcv daif -PAN -UAO)
> [  189.143774] pc : 0xffffb8fb0104
> [  189.143779] lr : 0xaaaab43c563c
> [  189.143781] sp : 0000ffffd4fa1180
> [  189.143786] x29: 0000ffffd4fa1190 x28: 0000000000000000 
> [  189.143795] x27: 0000000000000000 x26: 0000000000000000 
> [  189.143802] x25: 0000000000000000 x24: 0000000000000000 
> [  189.143809] x23: 0000000000000000 x22: 0000000000000000 
> [  189.143816] x21: 0000aaaab43c564c x20: 0000000000000000 
> [  189.143823] x19: 0000aaaab43c5770 x18: 0000000000000a03 
> [  189.143829] x17: 0000aaaab43d6020 x16: 0000ffffb8fb00e0 
> [  189.143837] x15: 0000ffffb8ed4000 x14: 0000ffffb8ed7540 
> [  189.143844] x13: 0000ffffb8ee45d8 x12: 0000000000000000 
> [  189.143851] x11: 0000000000000020 x10: 0000000000000000 
> [  189.143857] x9 : 00000000000000ff x8 : 00000000000003e8 
> [  189.143864] x7 : e607cc2262a01600 x6 : e607cc2262a01600 
> [  189.143872] x5 : 0000ffffd4fa12c0 x4 : 0000000000000000 
> [  189.143879] x3 : 0000000000000000 x2 : 0000aaaab43c5630 
> [  189.143886] x1 : 0000ffffd4fa12d8 x0 : 0000ffffd4fa12c8 
> 
> It requires some digging to find that this basically is a
> debugging/warning message and can be disabled using
> /proc/sys/debug/exception-trace
> (arm64/kernel/traps.c:do_ni_syscall,show_unhandled_signals_ratelimited).
> 
> Other platforms do not seem to do this, even with exception-trace
> enabled - x86_64 and arm for sure. Instead they silently return -ENOSYS.
> 
> There are a number of other kernel messages governed by the same sysctl
> (fault.c:__do_user_fault,do_sp_pc_abort, traps.c:force_signal_inject,
> signal.c:sys_rt_sigreturn).
> 
> Can I in good conscience disable exception-trace on the affected
> (production) systems or would this mask other, more critical
> misbehaviour?
> 
> Is it actually considered misbehaviour for arm64 userland to even
> attempt such a call? Or is the message maybe just a left-over development
> aid?
> 
> Can it perhaps be removed or disabled by default, considering that with
> future addition of syscalls userland will likely start triggering this
> message a lot when run on older kernels?

I agree that printing this stuff is bogus. We should instead just return
-ENOSYS via a redirect to sys_ni_syscall. The only corner case is for the
compat private syscalls, where we should match 32-bit and dispatch SIGILL
for that range (and then probably print the warning based on
show_unhandled_signals_ratelimited because there's a signal involved).

Will
