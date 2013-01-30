From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 30 Jan 2013 10:33:55 +0100
Subject: [PATCH] ARM i.MX25: clk: parent per5_clk to AHB clock
Message-ID: <1359538435-21304-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc-timer on the imx25 needs to be derived from the AHB clock.
If a bootloader reparents this clock to the ipg_clk_highfreq, which according
to the datasheet is a valid operation, the system can/will produce lockups/
freezes after some time [1].

This can be forced with code like
	while(1)
                syscall(SYS_clock_gettime, CLOCK_REALTIME, &tp);

This was already fixed with the commit
	 "i.MX25 GPT clock fix: ensure correct the clock source" [2],
but it seems, that it got lost. So, re-add this to have a correct gpt.

[1]: http://lists.arm.linux.org.uk/lurker/message/20130129.161230.229bda17.en.html
[2]: 2012d9ca2a1381ae3e733330a7f0d1d2f1988bba

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/clk-imx25.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 5d34f67..0e6dde6 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -177,6 +177,9 @@ static int __init __mx25_clocks_init(unsigned long osc_rate)
 			pr_err("i.MX25 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
+	/* Clock source for gpt must be derived from AHB */
+	clk_set_parent(clk[per5_sel], clk[ahb]);
+
 	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 
-- 
1.7.10.4
