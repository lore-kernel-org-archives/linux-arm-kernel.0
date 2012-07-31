From: jouhaapa@gmail.com (Jouko Haapaluoma)
Date: Tue, 31 Jul 2012 09:00:50 +0300
Subject: Child process might hang inside kernel with 2.6.33.15-rt31
Message-ID: <50177492.3070402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone

I know that the kernel 2.6.33 is very old, but since RT_PREEMPT was 
unavailable to newer versions when we were choosing the kernel, we had 
to choose this one and currently it is not possible to start converting 
our board to a newer kernel.

We have run into a problem where a pthreaded application executes shell 
commands with the system() function which runs fork/clone+execve and 
sometimes the thread that is calling the system() might hang forever. I 
attached a simple test program that reproduces the problem within 
minutes. I also tried to implement the system() function by doing a 
manual syscall(SYS_fork) call but the same problem remains.

Our boards are using the AT91SAM9260 or AT91SAM9263 ARM SoCs, glibc v2.9 
and gcc v4.3.3. We also tried with eglibc v2.12 and gcc v4.5.4. Kernel 
configuration is attached.

At first the test programs were also crashing (plus the other thread 
locking) and we encountered the problems also with the vanilla 2.6.33 
kernel with CONFIG_PREEMPT. However, I was reading the linux-arm-kernel 
archives and found the thread "cache aliasing in dup_mmap" (2009-03-07) 
where was indicated that this problem is caused by VIVT cache aliasing. 
Russell King posted a patch in that thread that fixed all the crashing 
and hanging problems on a vanilla 2.6.33 kernel. I found out that the 
patch was applied to the 2.6.34 release 
(http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2725898fc9bb2121ac0fb1b5e4faf4fc09014729). 


The patch fixed the crashing also with the RT_PREEMPT but we still 
encounter those weird hangs. I made some tracing with sysrq-t and I 
pasted the backtrace of the locked task (the child process) in this mail 
[1]. It always seems to hang to the same place 
"get_page_from_freelist+0x31c" when running sys_execve(). It looks like 
the parent hangs because it sits on waitpid() which is called for the 
child process and the child process hangs forever inside the kernel at 
"get_page_from_freelist+0x31c". I noticed that the hung task might 
actually continue running normally for a bit after some time but that is 
very rare.

I also found that running "ps" when the task is hung might lock the 
whole system for a while. Kernel printed the hung task backtrace which 
is also pasted to this mail [2]. This could be related to the same 
problem. I have not gotten any more info about the hang with 
DETECT_SOFTLOCKUP, DEBUG_LOCKDEP and DEBUG_SPINLOCK_SLEEP options.

Could this problem still be related to VIVT cache aliasing since similar 
hanging was present with vanilla 2.6.33 without the patch or is it a 
general RT_PREEMPT problem? Jamie Lokier had some doubts if there were 
some holes left: 
http://article.gmane.org/gmane.linux.ports.arm.kernel/69927/

Has anyone else encountered this on any platform?

BR,
Jouko Haapaluoma


********[1] sysrq-t backtrace ***********
[ 1666.230000] system_hang_e R running 0 10745 743 0x00000000
[ 1666.250000] [<c0251c64>] (__schedule+0x304/0x380) from [<c0251dbc>] 
(preempt_schedule+0x64/0x90)
[ 1666.270000] [<c0251dbc>] (preempt_schedule+0x64/0x90) from 
[<c006ce98>] (get_page_from_freelist+0x31c/0x478)
[ 1666.290000] [<c006ce98>] (get_page_from_freelist+0x31c/0x478) from 
[<c006d238>] (__alloc_pages_nodemask+0x100/0x568)
[ 1666.310000] [<c006d238>] (__alloc_pages_nodemask+0x100/0x568) from 
[<c006d6b4>] (__get_free_pages+0x14/0x44)
[ 1666.330000] [<c006d6b4>] (__get_free_pages+0x14/0x44) from 
[<c002c95c>] (get_pgd_slow+0x18/0xe8)
[ 1666.350000] [<c002c95c>] (get_pgd_slow+0x18/0xe8) from [<c00363c0>] 
(mm_init+0xac/0xfc)
[ 1666.370000] [<c00363c0>] (mm_init+0xac/0xfc) from [<c0091584>] 
(bprm_mm_init+0x10/0x174)
[ 1666.370000] [<c0091584>] (bprm_mm_init+0x10/0x174) from [<c0091b58>] 
(do_execve+0xa0/0x26c)
[ 1666.390000] [<c0091b58>] (do_execve+0xa0/0x26c) from [<c00281dc>] 
(sys_execve+0x38/0x5c)
[ 1666.410000] [<c00281dc>] (sys_execve+0x38/0x5c) from [<c0024f40>] 
(ret_fast_syscall+0x0/0x28)

(gdb) list *(get_page_from_freelist+0x31c)
0xc006ce98 is in get_page_from_freelist (mm/page_alloc.c:193).
188 }
189
190 static inline void unlock_cpu_pcp(unsigned long flags, int this_cpu)
191 {
192 #ifdef CONFIG_PREEMPT_RT
193 put_cpu_var_locked(pcp_locks, this_cpu);
194 #else
195 local_irq_restore(flags);
196 #endif
197 }
(gdb)


********[2] ps hangs ***********
root at at91sam9263ek:/# ps
PID USER VSZ STAT COMMAND
1 root 1572 S init [5]
2 root 0 SW [kthreadd]
3 root 0 SW [sirq-high/0]
4 root 0 SW [sirq-timer/0]
5 root 0 SW [sirq-net-tx/0]
6 root 0 SW [sirq-net-rx/0]
7 root 0 SW [sirq-block/0]
8 root 0 SW [sirq-block-iopo]
9 root 0 SW [sirq-tasklet/0]
10 root 0 SW [sirq-sched/0]
11 root 0 SW [sirq-hrtimer/0]
12 root 0 SW [sirq-rcu/0]
13 root 0 SW [posixcputmr/0]
14 root 0 SW [watchdog/0]
15 root 0 SW< [desched/0]
16 root 0 SW< [events/0]
17 root 0 SW [khelper]
20 root 0 SW [async/mgr]
95 root 0 SW [sync_supers]
97 root 0 SW [bdi-default]
99 root 0 SW [kblockd/0]
108 root 0 SW [khubd]
111 root 0 SW [kseriod]
119 root 0 SW [cfg80211]
136 root 0 SW [khungtaskd]
137 root 0 SW [kswapd0]
138 root 0 SW [aio/0]
223 root 0 SW [mtdblockd]
256 root 0 SW [ubi_bgt0d]
259 root 0 SW [ubi_bgt1d]
260 root 0 SW [irq/14-atmel_sp]
267 root 0 SW [irq/15-atmel_sp]
274 root 0 SW [irq/29-ohci_hcd]
285 root 0 SW [irq/1-rtc0]
323 root 0 SW [usbhid_resumer]
330 root 0 SW [ubifs_bgt0_1]
354 root 1932 S < /sbin/udevd -d
459 root 1928 S < /sbin/udevd -d
460 root 1928 S < /sbin/udevd -d
614 root 0 SW [ubifs_bgt1_1]
727 root 2900 S /sbin/syslogd -n -C64 -m 20
729 root 2836 S /sbin/klogd -n
740 root 3016 S -sh
742 root 18060 R ./system_hang_echo
4170 root 3016 R ps
4175 root 0 []
[ 1560.600000] INFO: task ps:4170 blocked for more than 120 seconds.
[ 1560.600000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1560.630000] ps D c0251c64 0 4170 740 0x00000000
[ 1560.660000] [<c0251c64>] (__schedule+0x304/0x380) from [<c0251e10>] 
(schedule+0x28/0x44)
[ 1560.660000] [<c0251e10>] (schedule+0x28/0x44) from [<c0252ca4>] 
(__rt_mutex_slowlock+0xa0/0xc8)
[ 1560.690000] [<c0252ca4>] (__rt_mutex_slowlock+0xa0/0xc8) from 
[<c02532d0>] (rt_mutex_slowlock+0x1dc/0x2b0)
[ 1560.720000] [<c02532d0>] (rt_mutex_slowlock+0x1dc/0x2b0) from 
[<c005c870>] (rt_down_read+0x28/0x38)
[ 1560.760000] [<c005c870>] (rt_down_read+0x28/0x38) from [<c007b7ec>] 
(access_process_vm+0x34/0x180)
[ 1560.790000] [<c007b7ec>] (access_process_vm+0x34/0x180) from 
[<c00c8320>] (proc_pid_cmdline+0x58/0xd4)
[ 1560.820000] [<c00c8320>] (proc_pid_cmdline+0x58/0xd4) from 
[<c00c986c>] (proc_info_read+0x5c/0xd8)
[ 1560.850000] [<c00c986c>] (proc_info_read+0x5c/0xd8) from [<c008c3d0>] 
(vfs_read+0xac/0x158)
[ 1560.880000] [<c008c3d0>] (vfs_read+0xac/0x158) from [<c008c534>] 
(sys_read+0x40/0x6c)
[ 1560.910000] [<c008c534>] (sys_read+0x40/0x6c) from [<c0024f40>] 
(ret_fast_syscall+0x0/0x28)
17759 root 2836 R sh -c echo HANG! > /dev/null
root at at91sam9263ek:/#
-------------- next part --------------
A non-text attachment was scrubbed...
Name: at91sam9263ek.config
Type: application/xml
Size: 7311 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120731/3d866139/attachment.wsdl>
-------------- next part --------------
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *print_message_function( void *ptr )
{
    pthread_t num = pthread_self();
    while(1)
    {
        printf("Thread %d doing a system() call\n", num);
        system("echo HANG! > /dev/null");
        printf("Thread %d call finished\n", num);
    }
}

int main(int argc, char *argv[])
{
    pthread_t thread1;
    pthread_t thread2;

    pthread_create( &thread1, NULL, print_message_function, NULL);
    pthread_create( &thread2, NULL, print_message_function, NULL);

    while(1)
    {
    }
}
