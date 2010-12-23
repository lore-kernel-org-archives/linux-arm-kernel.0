From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 23 Dec 2010 16:21:22 +0100
Subject: [PATCH] serial/amba-pl011: enable uart clk in setup for console
In-Reply-To: <20101223150234.GW14221@pengutronix.de>
References: <20101223150234.GW14221@pengutronix.de>
Message-ID: <1293117682-18505-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .write callback for console drivers must not sleep.  So
pl011_console_write must call clk_enable that is allowed to sleep (and
does sleep on mxs).

So enable the clock in the .setup callback instead of .write.

This fixes bugs like:

	udevd (74): /proc/74/oom_adj is deprecated, please use /proc/74/oom_score_adj instead.
	BUG: sleeping function called from invalid context at /ptx/work/octopus/WORK_2_A/ukl/backup/gsrc/linux-2.6/kernel/mutex.c:278
	in_atomic(): 0, irqs_disabled(): 128, pid: 74, name: udevd
	2 locks held by udevd/74:
	 #0:  (&(&p->alloc_lock)->rlock){+.+...}, at: [<c0132ff8>] oom_adjust_write+0xf8/0x290
	 #1:  (&(&sighand->siglock)->rlock){......}, at: [<c005d1ec>] __lock_task_sighand+0x64/0xac
	irq event stamp: 673
	hardirqs last  enabled at (672): [<c0033fdc>] vector_swi+0x3c/0x90
	hardirqs last disabled at (673): [<c02882e0>] _raw_spin_lock_irqsave+0x30/0x64
	softirqs last  enabled at (0): [<c004a000>] copy_process+0x3a8/0xf90
	softirqs last disabled at (0): [<  (null)>]   (null)
	Backtrace:
	[<c0037b54>] (dump_backtrace+0x0/0x110) from [<c02853a4>] (dump_stack+0x1c/0x20)
	 r7:c79f0000 r6:c003dd00 r5:c030ce72 r4:c79f0000
	[<c0285388>] (dump_stack+0x0/0x20) from [<c0046a58>] (__might_sleep+0x100/0x120)
	[<c0046958>] (__might_sleep+0x0/0x120) from [<c0287054>] (mutex_lock_nested+0x3c/0x2b4)
	 r5:00000000 r4:00000000
	[<c0287018>] (mutex_lock_nested+0x0/0x2b4) from [<c003dd00>] (clk_enable+0x30/0x58)
	[<c003dcd0>] (clk_enable+0x0/0x58) from [<c01d9888>] (pl011_console_write+0x30/0x8c)
	 r4:00000066
	[<c01d9858>] (pl011_console_write+0x0/0x8c) from [<c004b9a4>] (__call_console_drivers+0x68/0x84)
	 r6:00000066 r5:00007401 r4:c0372950
	[<c004b93c>] (__call_console_drivers+0x0/0x84) from [<c004ba48>] (_call_console_drivers+0x88/0x9c)
	 r8:ffff8b99 r7:60000093 r6:c0352c24 r5:c0352ba0 r4:00007467
	[<c004b9c0>] (_call_console_drivers+0x0/0x9c) from [<c004c040>] (release_console_sem+0x158/0x244)
	 r5:00007467 r4:00007467
	[<c004bee8>] (release_console_sem+0x0/0x244) from [<c004c7fc>] (vprintk+0x388/0x404)
	[<c004c474>] (vprintk+0x0/0x404) from [<c0285560>] (printk+0x20/0x28)
	[<c0285540>] (printk+0x0/0x28) from [<c01330f0>] (oom_adjust_write+0x1f0/0x290)
	 r3:0000004a r2:0000004a r1:c795595c r0:c031998c
	[<c0132f00>] (oom_adjust_write+0x0/0x290) from [<c00eb008>] (vfs_write+0xb8/0x18c)
	 r8:0001a4ac r7:c79f1f70 r6:0001a4ac r5:00000003 r4:c79dbc00
	[<c00eaf50>] (vfs_write+0x0/0x18c) from [<c00eb1a8>] (sys_write+0x48/0x74)
	 r8:0001a4ac r7:00000003 r6:c79dbc00 r5:00000000 r4:00000000
	[<c00eb160>] (sys_write+0x0/0x74) from [<c0033e80>] (ret_fast_syscall+0x0/0x38)
	 r8:c0034088 r7:00000004 r6:00000000 r5:00000003 r4:00000003

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/serial/amba-pl011.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 6ca7a44..e890ae8 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -710,8 +710,6 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr, new_cr;
 
-	clk_enable(uap->clk);
-
 	/*
 	 *	First save the CR then disable the interrupts
 	 */
@@ -730,8 +728,6 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 		status = readw(uap->port.membase + UART01x_FR);
 	} while (status & UART01x_FR_BUSY);
 	writew(old_cr, uap->port.membase + UART011_CR);
-
-	clk_disable(uap->clk);
 }
 
 static void __init
@@ -776,6 +772,7 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -788,6 +785,10 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	if (!uap)
 		return -ENODEV;
 
+	ret = clk_enable(uap->clk);
+	if (ret)
+		return ret;
+
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
 	if (options)
-- 
1.7.2.3
