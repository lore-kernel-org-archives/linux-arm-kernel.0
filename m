From: rusko.peter@prolan.hu (Peter Rusko)
Date: Wed, 23 Nov 2011 12:36:02 +0100
Subject: BUG: sleeping function called from invalid context
Message-ID: <4ECCDAA2.4070502@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

While trying to use the LRADC and touchscreen functionality on imx28,
I've run into this problem:

udevd[523]: starting version 171
BUG: sleeping function called from invalid context at kernel/mutex.c:271
in_atomic(): 1, irqs_disabled(): 128, pid: 523, name: udevd
no locks held by udevd/523.
irq event stamp: 956
hardirqs last  enabled at (956): [<c032e56c>] 
_raw_write_unlock_irqrestore+0x3c/0x68
hardirqs last disabled at (955): [<c032e6ec>] 
_raw_write_lock_irqsave+0x1c/0x58
softirqs last  enabled at (843): [<c0025c78>] irq_exit+0x54/0xb0
softirqs last disabled at (792): [<c0025c78>] irq_exit+0x54/0xb0
[<c0013238>] (unwind_backtrace+0x0/0xe0) from [<c032d198>] 
(mutex_lock_nested+0x24/0x31c)
[<c032d198>] (mutex_lock_nested+0x24/0x31c) from [<c0017570>] 
(clk_enable+0x20/0x48)
[<c0017570>] (clk_enable+0x20/0x48) from [<c023173c>] 
(pl011_console_write+0x20/0x78)
[<c023173c>] (pl011_console_write+0x20/0x78) from [<c0020780>] 
(__call_console_drivers+0x84/0x9c)
[<c0020780>] (__call_console_drivers+0x84/0x9c) from [<c0020ba0>] 
(console_unlock+0xfc/0x1ec)
[<c0020ba0>] (console_unlock+0xfc/0x1ec) from [<c0021150>] 
(vprintk+0x3b0/0x440)
[<c0021150>] (vprintk+0x3b0/0x440) from [<c032b4d4>] (printk+0x18/0x24)
[<c032b4d4>] (printk+0x18/0x24) from [<c0233a5c>] (kmsg_writev+0xd8/0xfc)
[<c0233a5c>] (kmsg_writev+0xd8/0xfc) from [<c008f58c>] 
(do_sync_write+0x98/0xd4)
[<c008f58c>] (do_sync_write+0x98/0xd4) from [<c008fe98>] 
(vfs_write+0xc8/0x138)
[<c008fe98>] (vfs_write+0xc8/0x138) from [<c00900e0>] (sys_write+0x3c/0x68)
[<c00900e0>] (sys_write+0x3c/0x68) from [<c000e180>] 
(ret_fast_syscall+0x0/0x38)

It seems that the printk calls cause the problem (it's not just with 
udev, seems to have the problem with all printk calls). The touchscreen
works perfectly and I'd like to submit a patch which supports it, but I
keep getting the same messages. What can cause the problem, why is it an
atomic context within the udevd?

Regards,
-- 
Rusk? P?ter
Fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET
