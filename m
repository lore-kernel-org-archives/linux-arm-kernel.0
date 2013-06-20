From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 12:14:07 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <20130620095705.GA18536@arm.com>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
Message-ID: <51C2D5EF.3040803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 11:57 AM, Catalin Marinas wrote:
>>> :040000 040000 034899bdcbc9aa59b5455a85a9d78b646b4cf784 ecc23e33a4ca807d4153f87fbea85a9437ff2928 M      arch
>>
>> The problem can be reproduced on several mx28 and an at91sam9263 and
>> only occurs of CONFIG_PREEMPT (Preemptible Kernel (Low-Latency Desktop))
>> is enabled.
>>
>> I have the gut feeling that the "if (irqs_disabled())" check in the
>> above patch is not correct for CONFIG_PREEMPT.
> 
> The check is there to avoid long interrupt latencies (flushing the whole
> cache with interrupts disabled during context switch). You can drop the
> check and always call cpu_switch_mm() to confirm that it fixes the
> faults.
> 
> finish_task_switch() calls finish_arch_post_lock_switch() after the
> interrupts have been enabled so that the CPU can actually switch the mm.
> I wonder whether we could actually be preempted after
> finish_lock_switch() but before we actually switched the MMU.
> 
> Here's an untested patch (trying to keep it in the arch/arm code):

[...]

When stating userspace I get this reproducible:

init started: BusyBox v1.18.5 (2013-04-04 18:31:36 CEST)
starting pid 50, tty '/dev/console': '/etc/init.d/rcS'
[    7.000828] ------------[ cut here ]------------
[    7.005560] WARNING: at kernel/sched/core.c:2809 finish_task_switch.constprop.84+0xf8/0x164()
[    7.014650] DEBUG_LOCKS_WARN_ON(val > preempt_count())
[    7.019668] Modules linked in:
[    7.023152] CPU: 0 PID: 51 Comm: rcS Not tainted 3.10.0-rc6-00085-gf36ec4f #20
[    7.030923] [<c0013db4>] (unwind_backtrace+0x0/0xf0) from [<c0011b5c>] (show_stack+0x10/0x14)
[    7.039563] [<c0011b5c>] (show_stack+0x10/0x14) from [<c001bed4>] (warn_slowpath_common+0x4c/0x68)
[    7.048732] [<c001bed4>] (warn_slowpath_common+0x4c/0x68) from [<c001bf84>] (warn_slowpath_fmt+0x30/0x40)
[    7.058505] [<c001bf84>] (warn_slowpath_fmt+0x30/0x40) from [<c0047a3c>] (finish_task_switch.constprop.84+0xf8/0x164)
[    7.069303] [<c0047a3c>] (finish_task_switch.constprop.84+0xf8/0x164) from [<c0047d8c>] (schedule_tail+0xc/0x5c)
[    7.079659] [<c0047d8c>] (schedule_tail+0xc/0x5c) from [<c000ee10>] (ret_from_fork+0x4/0x34)
[    7.088240] ---[ end trace 8c7837ef19036347 ]---
mounting filesystems...[    7.222365] BUG: scheduling while atomic: ksoftirqd/0/3/0x00000002
[    7.229222] INFO: lockdep is turned off.
[    7.233361] Modules linked in:
[    7.236502] CPU: 0 PID: 3 Comm: ksoftirqd/0 Tainted: G        W    3.10.0-rc6-00085-gf36ec4f #20
[    7.245509] [<c0013db4>] (unwind_backtrace+0x0/0xf0) from [<c0011b5c>] (show_stack+0x10/0x14)
[    7.254260] [<c0011b5c>] (show_stack+0x10/0x14) from [<c044d908>] (__schedule_bug+0x60/0x78)
[    7.262910] [<c044d908>] (__schedule_bug+0x60/0x78) from [<c0453fec>] (__schedule+0x554/0x624)
[    7.271735] [<c0453fec>] (__schedule+0x554/0x624) from [<c0044cd8>] (smpboot_thread_fn+0x104/0x208)
[    7.280966] [<c0044cd8>] (smpboot_thread_fn+0x104/0x208) from [<c003d5bc>] (kthread+0xa4/0xb0)
[    7.289655] [<c003d5bc>] (kthread+0xa4/0xb0) from [<c000ee20>] (ret_from_fork+0x14/0x34)
[    7.310837] BUG: scheduling while atomic: ksoftirqd/0/3/0x00000002
[    7.317065] INFO: lockdep is turned off.
[    7.321124] Modules linked in:
[    7.324253] CPU: 0 PID: 3 Comm: ksoftirqd/0 Tainted: G        W    3.10.0-rc6-00085-gf36ec4f #20
[    7.333251] [<c0013db4>] (unwind_backtrace+0x0/0xf0) from [<c0011b5c>] (show_stack+0x10/0x14)
[    7.342011] [<c0011b5c>] (show_stack+0x10/0x14) from [<c044d908>] (__schedule_bug+0x60/0x78)
[    7.350539] [<c044d908>] (__schedule_bug+0x60/0x78) from [<c0453fec>] (__schedule+0x554/0x624)
[    7.359342] [<c0453fec>] (__schedule+0x554/0x624) from [<c0044cd8>] (smpboot_thread_fn+0x104/0x208)
[    7.368564] [<c0044cd8>] (smpboot_thread_fn+0x104/0x208) from [<c003d5bc>] (kthread+0xa4/0xb0)
[    7.377364] [<c003d5bc>] (kthread+0xa4/0xb0) from [<c000ee20>] (ret_from_fork+0x14/0x34)
[    7.403225] BUG: scheduling while atomic: ksoftirqd/0/3/0x00000002
[    7.409454] INFO: lockdep is turned off.

..keeps going with "BUG: scheduling while atomic"

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/ad1b0c54/attachment.sig>
