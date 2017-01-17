From: EladN@gilat.com (Elad Nachman)
Date: Tue, 17 Jan 2017 16:20:00 +0000
Subject: Kernel 4.6.7-rt14 kernel workqueue lockup - rtnl deadlock plus
 syscall endless loop
Message-ID: <AM5PR0701MB187319ED63BCB767DA438C0CA07C0@AM5PR0701MB1873.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am experiencing sporadic work queue lockups on kernel 4.6.7-rt14 (mach-socfpga).

Using a HW debugger I got the following information:

A process containing a network namespace is terminating itself (SIGKILL), which causes cleanup_net() to be scheduled to kworker/u4:2 to clean up the network namespace running on the process.

Kworker/u4:2 got preempted (plus there are a lot of other work queue items, like vmstat_shepherd, wakeup_dirtytime_writeback, phy_state_machine, neigh_periodic_work, check_lifetime plus another one by a LKM) while holding the rtnl lock.

A processing running waitpid() on the terminated process starts a new process, which forks busybox to run sysctl -w net.ipv6.conf.all.forwarding = 1 .
This in turn starts making a write syscall, calling in turn vfs_write, proc_sys_call_handler, addrconf_sysctl_forward, and finally addrconf_fixup_forwarding().

addrconf_fixup_forwarding() runs the following code:

if (!rtnl_trylock())
                 return restart_syscall();

This fails and restart_syscall() does the following:

set_tsk_thread_flag(current, TIF_SIGPENDING);
         return -ERESTARTNOINTR;

Now the system call goes back to ret_fast_syscall (arch/arm/kernel/entry-common.S)
Testing the flags in the task_struct (which contain TIF_SIGPENDING) the code branches to fast_work_pending, then falls through to slow_work_pending, which
Calls do_work_pending(), and in turn calls do_signal(), get_signal(), dequeuer_signal(), which find no signals, and clears the TIF_SIGPENDING bit when recalc_sigpending() is called, then returns zero.

This causes do_signal() to examine r0 and return 1 (-ERESTARTNOINTR), which is propogated to the assembly code by do_work_pending().
Having r0 equal zero causes a branch to local_restart, which restarts the very same write system call in an endless loop.
No scheduling is possible, so the cleanup_net() cannot finish and release rtnl, which in turn causes the endless restarting of the write system call.

Going over the x86 assembly code and does not look like system calls are restarted within the assembly syscall handler without returning to user-space.

There could be several remedies:

1.Adopt the X86 handling (avoid restarting system calls within the handler, but rather return to user-space).
2.Count the number of retries. Above a set threshold (1? 2? 3? retries) force a return to user-space.
3.Count the number of retries. Above a set threshold (1? 2? 3? retries) force a reschedule() in do_work_pending() (as if _TIF_NEED_RESCHED) was set.

What do you think is the best solution for this issue?

Thanks,

Elad.



IMPORTANT - This email and any attachments is intended for the above named addressee(s), and may contain information which is confidential or privileged. If you are not the intended recipient, please inform the sender immediately and delete this email: you should not copy or use this e-mail for any purpose nor disclose its contents to any person.
