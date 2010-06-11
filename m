From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 11:46:59 +0200
Subject: [PATCH 01/11] USB: s3c_hsotg: Add support for external USB clock
In-Reply-To: <006a01cb0949$6c7e7300$457b5900$%szyprowski@samsung.com>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
	<1276244457-4072-2-git-send-email-ben-linux@fluff.org>
	<006a01cb0949$6c7e7300$457b5900$%szyprowski@samsung.com>
Message-ID: <4C120613.6000507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLL that drives the USB clock supports 3 input clocks: 12, 24 and 48Mhz.
This patch adds support to the USB driver for setting the correct register bit
according to the given clock.

This depends on the following patch:
[PATCH] ARM: S3C64XX: Add USB external clock definition

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---

v2: - fixes space issues
    - use MHZ define

---
 drivers/usb/gadget/s3c-hsotg.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 1f73b48..40ee63a 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/clk.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -2699,6 +2700,7 @@ static void __devinit s3c_hsotg_initep(struct s3c_hsotg *hsotg,
  */
 static void s3c_hsotg_otgreset(struct s3c_hsotg *hsotg)
 {
+	struct clk *xusbxti;
 	u32 osc;
 
 	writel(0, S3C_PHYPWR);
@@ -2706,6 +2708,23 @@ static void s3c_hsotg_otgreset(struct s3c_hsotg *hsotg)
 
 	osc = hsotg->plat->is_osc ? S3C_PHYCLK_EXT_OSC : 0;
 
+	xusbxti = clk_get(hsotg->dev, "xusbxti");
+	if (xusbxti && !IS_ERR(xusbxti)) {
+		switch (clk_get_rate(xusbxti)) {
+		case 12*MHZ:
+			osc |= S3C_PHYCLK_CLKSEL_12M;
+			break;
+		case 24*MHZ:
+			osc |= S3C_PHYCLK_CLKSEL_24M;
+			break;
+		default:
+		case 48*MHZ:
+			/* default reference clock */
+			break;
+		}
+		clk_put(xusbxti);
+	}
+
 	writel(osc | 0x10, S3C_PHYCLK);
 
 	/* issue a full set of resets to the otg and core */
-- 
1.7.1
