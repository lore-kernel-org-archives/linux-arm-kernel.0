From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 27 Dec 2010 21:37:46 +0100
Subject: bug in PL011 console
In-Reply-To: <20101227115719.GA27995@freescale.com>
References: <20101223150234.GW14221@pengutronix.de>
	<20101227115719.GA27995@freescale.com>
Message-ID: <20101227203746.GJ14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Dec 27, 2010 at 07:57:19PM +0800, Shawn Guo wrote:
> On Thu, Dec 23, 2010 at 04:02:34PM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > since mxs switched to amba-pl011 I often hit warnings like this:
> > 
> > 	[    9.280000] udevd (74): /proc/74/oom_adj is deprecated, please use /proc/74/oom_score_adj instead.
> > 	[    9.280000] BUG: sleeping function called from invalid context at /ptx/work/octopus/WORK_2_A/ukl/backup/gsrc/linux-2.6/kernel/mutex.c:278
> > 	[    9.280000] in_atomic(): 0, irqs_disabled(): 128, pid: 74, name: udevd
> > 	[    9.280000] 2 locks held by udevd/74:
> > 	[    9.280000]  #0:  (&(&p->alloc_lock)->rlock){+.+...}, at: [<c0132ff8>] oom_adjust_write+0xf8/0x290
> > 	[    9.280000]  #1:  (&(&sighand->siglock)->rlock){......}, at: [<c005d1ec>] __lock_task_sighand+0x64/0xac
> > 	[    9.280000] irq event stamp: 673
> > 	[    9.280000] hardirqs last  enabled at (672): [<c0033fdc>] vector_swi+0x3c/0x90
> > 	[    9.280000] hardirqs last disabled at (673): [<c02882e0>] _raw_spin_lock_irqsave+0x30/0x64
> > 	[    9.280000] softirqs last  enabled at (0): [<c004a000>] copy_process+0x3a8/0xf90
> > 	[    9.280000] softirqs last disabled at (0): [<  (null)>]   (null)
> > 	[    9.280000] Backtrace: 
> > 	[    9.280000] [<c0037b54>] (dump_backtrace+0x0/0x110) from [<c02853a4>] (dump_stack+0x1c/0x20)
> > 	[    9.280000]  r7:c79f0000 r6:c003dd00 r5:c030ce72 r4:c79f0000
> > 	[    9.280000] [<c0285388>] (dump_stack+0x0/0x20) from [<c0046a58>] (__might_sleep+0x100/0x120)
> > 	[    9.280000] [<c0046958>] (__might_sleep+0x0/0x120) from [<c0287054>] (mutex_lock_nested+0x3c/0x2b4)
> > 	[    9.280000]  r5:00000000 r4:00000000
> > 	[    9.280000] [<c0287018>] (mutex_lock_nested+0x0/0x2b4) from [<c003dd00>] (clk_enable+0x30/0x58)
> > 	[    9.280000] [<c003dcd0>] (clk_enable+0x0/0x58) from [<c01d9888>] (pl011_console_write+0x30/0x8c)
> > 	[    9.280000]  r4:00000066
> > 	[    9.280000] [<c01d9858>] (pl011_console_write+0x0/0x8c) from [<c004b9a4>] (__call_console_drivers+0x68/0x84)
> > 	[    9.280000]  r6:00000066 r5:00007401 r4:c0372950
> > 	[    9.280000] [<c004b93c>] (__call_console_drivers+0x0/0x84) from [<c004ba48>] (_call_console_drivers+0x88/0x9c)
> > 	[    9.280000]  r8:ffff8b99 r7:60000093 r6:c0352c24 r5:c0352ba0 r4:00007467
> > 	[    9.280000] [<c004b9c0>] (_call_console_drivers+0x0/0x9c) from [<c004c040>] (release_console_sem+0x158/0x244)
> > 	[    9.280000]  r5:00007467 r4:00007467
> > 	[    9.280000] [<c004bee8>] (release_console_sem+0x0/0x244) from [<c004c7fc>] (vprintk+0x388/0x404)
> > 	[    9.280000] [<c004c474>] (vprintk+0x0/0x404) from [<c0285560>] (printk+0x20/0x28)
> > 	[    9.280000] [<c0285540>] (printk+0x0/0x28) from [<c01330f0>] (oom_adjust_write+0x1f0/0x290)
> > 	[    9.280000]  r3:0000004a r2:0000004a r1:c795595c r0:c031998c
> > 	[    9.280000] [<c0132f00>] (oom_adjust_write+0x0/0x290) from [<c00eb008>] (vfs_write+0xb8/0x18c)
> > 	[    9.280000]  r8:0001a4ac r7:c79f1f70 r6:0001a4ac r5:00000003 r4:c79dbc00
> > 	[    9.280000] [<c00eaf50>] (vfs_write+0x0/0x18c) from [<c00eb1a8>] (sys_write+0x48/0x74)
> > 	[    9.280000]  r8:0001a4ac r7:00000003 r6:c79dbc00 r5:00000000 r4:00000000
> > 	[    9.280000] [<c00eb160>] (sys_write+0x0/0x74) from [<c0033e80>] (ret_fast_syscall+0x0/0x38)
> > 	[    9.280000]  r8:c0034088 r7:00000004 r6:00000000 r5:00000003 r4:00000003
> > 
> It looks like a real problem. But the strange thing to me is that
> it's never been hit on my side.
Try enabling CONFIG_DEBUG_SPINLOCK_SLEEP.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
