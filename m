From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2017 16:40:33 +0000
Subject: Kernel 4.6.7-rt14 kernel workqueue lockup - rtnl deadlock plus
 syscall endless loop
In-Reply-To: <AM5PR0701MB187319ED63BCB767DA438C0CA07C0@AM5PR0701MB1873.eurprd07.prod.outlook.com>
References: <AM5PR0701MB187319ED63BCB767DA438C0CA07C0@AM5PR0701MB1873.eurprd07.prod.outlook.com>
Message-ID: <20170117164033.GC27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 04:20:00PM +0000, Elad Nachman wrote:
> Hi,
> 
> I am experiencing sporadic work queue lockups on kernel 4.6.7-rt14 (mach-socfpga).
> 
> Using a HW debugger I got the following information:
> 
> A process containing a network namespace is terminating itself (SIGKILL),
> which causes cleanup_net() to be scheduled to kworker/u4:2 to clean up
> the network namespace running on the process.
> 
> Kworker/u4:2 got preempted (plus there are a lot of other work queue
> items, like vmstat_shepherd, wakeup_dirtytime_writeback, phy_state_machine,
> neigh_periodic_work, check_lifetime plus another one by a LKM) while
> holding the rtnl lock.
> 
> A processing running waitpid() on the terminated process starts a new
> process, which forks busybox to run sysctl -w net.ipv6.conf.all.forwarding
> = 1 .
> This in turn starts making a write syscall, calling in turn vfs_write,
> proc_sys_call_handler, addrconf_sysctl_forward, and finally
> addrconf_fixup_forwarding().
> 
> addrconf_fixup_forwarding() runs the following code:
> 
> if (!rtnl_trylock())
>                  return restart_syscall();
> 
> This fails and restart_syscall() does the following:
> 
> set_tsk_thread_flag(current, TIF_SIGPENDING);
>          return -ERESTARTNOINTR;
> 
> Now the system call goes back to ret_fast_syscall (arch/arm/kernel/entry-common.S)
> Testing the flags in the task_struct (which contain TIF_SIGPENDING) the code branches to fast_work_pending, then falls through to slow_work_pending, which
> Calls do_work_pending(), and in turn calls do_signal(), get_signal(), dequeuer_signal(), which find no signals, and clears the TIF_SIGPENDING bit when recalc_sigpending() is called, then returns zero.
> 
> This causes do_signal() to examine r0 and return 1 (-ERESTARTNOINTR), which is propogated to the assembly code by do_work_pending().
> Having r0 equal zero causes a branch to local_restart, which restarts the very same write system call in an endless loop.
> No scheduling is possible, so the cleanup_net() cannot finish and release rtnl, which in turn causes the endless restarting of the write system call.
> 
> Going over the x86 assembly code and does not look like system calls are restarted within the assembly syscall handler without returning to user-space.
> 
> There could be several remedies:
> 
> 1.Adopt the X86 handling (avoid restarting system calls within the handler, but rather return to user-space).

We used to do that, but it became infeasible.

commit 81783786d5cf4aa0d3e15bb0fac856aa8ebf1a76
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jul 19 17:48:21 2012 +0100

    ARM: 7473/1: deal with handlerless restarts without leaving the kernel

However, I think your analysis is slightly off.  Yes, we call into
do_work_pending().  As long as _TIF_NEED_RESCHED is not set, then
you are correct.

However, _TIF_NEED_RESCHED will be set at the end of the thread's
quantum, or when a higher priority thread needs to run on the current
CPU.

Now, that's the exact same path which gets used when a thread needs to
be preempted, so returning back to userspace and re-entering to the
restart syscall doesn't achieve anything as long as _TIF_NEED_RESCHED
is clear.  We just end up executing more instructions uselessly.

I think the problem is that:

        if (!rtnl_trylock())
                return restart_syscall();

which, if it didn't do a trylock, it would put this thread to sleep
and allow other threads to run (potentially allowing the holder of
the lock to release it.)

What's more odd about this is that it's very unusual and strange for
a kernel function to invoke the restart mechanism because a lock is
being held - the point of the restart mechanism is to allow userspace
signal handlers to run, so it should only be used when there's a
signal pending.  I think this is a hack in the IPv6 code to work
around some other issue.

This isn't really -rt kernel specific, I'd expect exactly the same
behaviour from a non-rt kernel.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
