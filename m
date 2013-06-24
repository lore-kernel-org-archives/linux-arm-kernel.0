From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 18:38:54 +0200
Subject: [PATCH 2/2] ARM: at91/PMC: use at91_usb_rate() for UTMI PLL
Message-ID: <1372091934-28512-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are using this function, now that we have introduced
the support for UTMI clock for computing the USB host rate.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 661111f..6b2630a 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -742,8 +742,7 @@ static void __init at91_upll_usbfs_clock_init(unsigned long main_clock)
 	/* Now set uhpck values */
 	uhpck.parent = &utmi_clk;
 	uhpck.pmc_mask = AT91SAM926x_PMC_UHP;
-	uhpck.rate_hz = utmi_clk.rate_hz;
-	uhpck.rate_hz /= 1 + ((at91_pmc_read(AT91_PMC_USB) & AT91_PMC_OHCIUSBDIV) >> 8);
+	uhpck.rate_hz = at91_usb_rate(&utmi_clk, utmi_clk.rate_hz, usbr);
 }
 
 static int __init at91_pmc_init(unsigned long main_clock)
-- 
1.8.2.2
