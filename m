From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 4 Nov 2014 09:03:53 +0100
Subject: [PATCH] ARM: make kuser helpers depend on MMU
In-Reply-To: <1415045178-4673-1-git-send-email-nathan_lynch@mentor.com>
References: <1415045178-4673-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20141104080353.GX8316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 02:06:18PM -0600, Nathan Lynch wrote:
> The kuser helpers page is not set up on non-MMU systems, so it does
> not make sense to allow CONFIG_KUSER_HELPERS to be enabled when
> CONFIG_MMU=n.  Allowing it to be set on !MMU results in an oops in
> set_tls (used in execve and the arm_syscall trap handler):
> 
> Unhandled exception: IPSR = 00000005 LR = fffffff1
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc1-00041-ga30465a #216
> task: 8b838000 ti: 8b82a000 task.ti: 8b82a000
> PC is at flush_thread+0x32/0x40
> LR is at flush_thread+0x21/0x40
> pc : [<8f00157a>]    lr : [<8f001569>]    psr: 4100000b
> sp : 8b82be20  ip : 00000000  fp : 8b83c000
> r10: 00000001  r9 : 88018c84  r8 : 8bb85000
> r7 : 8b838000  r6 : 00000000  r5 : 8bb77400  r4 : 8b82a000
> r3 : ffff0ff0  r2 : 8b82a000  r1 : 00000000  r0 : 88020354
> xPSR: 4100000b
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc1-00041-ga30465a #216
> [<8f002bc1>] (unwind_backtrace) from [<8f002033>] (show_stack+0xb/0xc)
> [<8f002033>] (show_stack) from [<8f00265b>] (__invalid_entry+0x4b/0x4c)
> 
> As best I can tell this issue existed for the set_tls ARM syscall
> before commit fbfb872f5f41 "ARM: 8148/1: flush TLS and thumbee
> register state during exec" consolidated the TLS manipulation code
> into the set_tls helper function, but now that we're using it to flush
> register state during execve, !MMU users encounter the oops at the
> first exec.
> 
> Prevent CONFIG_MMU=n configurations from enabling
> CONFIG_KUSER_HELPERS.
> 
> Fixes: fbfb872f5f41 ARM: 8148/1: flush TLS and thumbee register state during exec
minor nit: Usual syntax here is:

	Fixes: fbfb872f5f41 ("ARM: 8148/1: flush ...")

> 
and it's part of the s-o-b area, so no empty line

> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> Reported-by: Stefan Agner <stefan@agner.ch>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
