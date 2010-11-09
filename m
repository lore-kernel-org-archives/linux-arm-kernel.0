From: mattias@vmlinux.org (Mattias Walstrom)
Date: Tue, 09 Nov 2010 20:37:12 +0100
Subject: imx27: I2C clock frequency
Message-ID: <4CD9A2E8.2040002@vmlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
When investigating the i2c clock frequency on our custom imx27-board (running 2.6.32) we discovered that it was not correct, instead of 100khz we got 40khz. When looking at the code we noticed a possible problem with get_rate_ipg. With the following patch we get an i2c clock at 100khz (as expected).

Is this the right way to solve the problem? I am unsure if I can use the AHB divider directly for the ipgclock-rate.

--- linux-2.6.32.23.orig/arch/arm/mach-mx2/clock_imx27.c
+++ linux-2.6.32.23/arch/arm/mach-mx2/clock_imx27.c
@@ -401,7 +401,7 @@ static unsigned long get_rate_ipg(struct
 	unsigned long rate, ipg_pdf;
 
 	if (mx27_revision() >= CHIP_REV_2_0)
-		return clk_get_rate(clk->parent);
+		ipg_pdf = (__raw_readl(CCM_CSCR) >> 8) & 3;
 	else
 		ipg_pdf = (__raw_readl(CCM_CSCR) >> 8) & 1;

Best regards

Mattias Walstr?m
