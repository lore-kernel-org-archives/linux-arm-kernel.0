From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Feb 2013 10:59:44 +0100
Subject: [PATCH] ARM: i.MX35: enable MAX clock
Message-ID: <1361872784-1348-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX35 has two bits per clock gate which are decoded as follows:
      0b00 -> clock off
      0b01 -> clock is on in run mode, off in wait/doze
      0b10 -> clock is on in run/wait mode, off in doze
      0b11 -> clock is always on

The reset value for the MAX clock is 0b10.

The MAX clock is needed by the SoC, yet unused in the Kernel, so the
common clock framework will disable it during late init time. It will
only disable clocks though which it detects as being turned on. This
detection is made depending on the lower bit of the gate. If the reset
value has been altered by the bootloader to 0b11 the clock framework
will detect the clock as turned on, yet unused, hence it will turn it
off and the system locks up.

This patch turns the MAX clock on unconditionally making the Kernel
independent of the bootloader.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx35.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index f0727e8..f310aa4 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -264,6 +264,7 @@ int __init mx35_clocks_init()
 	clk_prepare_enable(clk[gpio3_gate]);
 	clk_prepare_enable(clk[iim_gate]);
 	clk_prepare_enable(clk[emi_gate]);
+	clk_prepare_enable(clk[max_gate]);
 
 	/*
 	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
-- 
1.7.10.4
