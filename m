From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  1 Aug 2013 08:16:40 +0200
Subject: [PATCH] USB: ohci-at91: add usb_clk for transition to common clk
 framework
Message-ID: <1375337800-2605-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91 PMC (Power Management Controller) provides an USB clock used by
USB Full Speed host (ohci) and USB Full Speed device (udc).
The usb drivers (ohci and udc) must configure this clock to 48Mhz.
This configuration was formely done in mach-at91/clock.c, but this
implementation will be removed when moving to common clk framework.

This patch adds support for usb clock retrieval and configuration, and is
backward compatible with the current at91 clk implementation (if usb clk
is not found, it does not configure/enable it).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/usb/host/ohci-at91.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 9677f68..913d293 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -31,8 +31,8 @@
 #define at91_for_each_port(index)	\
 		for ((index) = 0; (index) < AT91_MAX_USBH_PORTS; (index)++)
 
-/* interface and function clocks; sometimes also an AHB clock */
-static struct clk *iclk, *fclk, *hclk;
+/* interface, function and usb clocks; sometimes also an AHB clock */
+static struct clk *iclk, *fclk, *uclk, *hclk;
 static int clocked;
 
 extern int usb_disabled(void);
@@ -41,6 +41,10 @@ extern int usb_disabled(void);
 
 static void at91_start_clock(void)
 {
+	if (!IS_ERR(uclk)) {
+		clk_set_rate(uclk, 48000000);
+		clk_prepare_enable(uclk);
+	}
 	clk_prepare_enable(hclk);
 	clk_prepare_enable(iclk);
 	clk_prepare_enable(fclk);
@@ -52,6 +56,8 @@ static void at91_stop_clock(void)
 	clk_disable_unprepare(fclk);
 	clk_disable_unprepare(iclk);
 	clk_disable_unprepare(hclk);
+	if (!IS_ERR(uclk))
+		clk_disable_unprepare(uclk);
 	clocked = 0;
 }
 
@@ -163,6 +169,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err5;
 	}
 
+	uclk = clk_get(&pdev->dev, "usb_clk");
+
 	at91_start_hc(pdev);
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
@@ -173,6 +181,9 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	/* Error handling */
 	at91_stop_hc(pdev);
 
+	if (!IS_ERR(uclk))
+		clk_put(uclk);
+
 	clk_put(hclk);
  err5:
 	clk_put(fclk);
@@ -212,6 +223,8 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 
+	if (!IS_ERR(uclk))
+		clk_put(uclk);
 	clk_put(hclk);
 	clk_put(fclk);
 	clk_put(iclk);
-- 
1.7.9.5
