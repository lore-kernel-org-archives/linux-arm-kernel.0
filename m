From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 02 Jun 2010 12:55:36 +1200
Subject: [PATCH] at91: Fix uhpck clock rate in upll case
Message-ID: <4C05AC08.9030705@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uhpck clock should be divided from the utmi clock, not its parent
(main). This change is mostly cosmetic as the uhpck rate value is not
used anywhere except for the debugfs clock output.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 7f7da43..57fc6d4 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -657,7 +657,7 @@ static void __init at91_upll_usbfs_clock_init(unsigned long main_clock)
 	/* Now set uhpck values */
 	uhpck.parent = &utmi_clk;
 	uhpck.pmc_mask = AT91SAM926x_PMC_UHP;
-	uhpck.rate_hz = utmi_clk.parent->rate_hz;
+	uhpck.rate_hz = utmi_clk.rate_hz;
 	uhpck.rate_hz /= 1 + ((at91_sys_read(AT91_PMC_USB) & AT91_PMC_OHCIUSBDIV) >> 8);
 }
 
