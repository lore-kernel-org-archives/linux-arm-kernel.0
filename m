From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 16 Jul 2013 17:25:10 +0200
Subject: [PATCH v3 7/7] usb: gadget: at91_udc: add usb_clk for transition to
 common clk framework
In-Reply-To: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1373988310-24734-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91 PMC (Power Management Controller) provides an USB clock used by
USB Full Speed host (ohci) and USB Full Speed device (udc).
The usb drivers (ohci and udc) must configure this clock to 48Mhz.
This configuration was formely done in mach-at91/clock.c, but this
implementation will be removed when moving to common clk framework.

This patch add support for usb clock retrieval and configuration, and is
backward compatible with the current at91 clk implementation (if usb clk
is not found, it does not configure/enable the usb clk).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/usb/gadget/at91_udc.c |   12 ++++++++++++
 drivers/usb/gadget/at91_udc.h |    2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index fce8e4e..1306a02 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -870,6 +870,10 @@ static void clk_on(struct at91_udc *udc)
 	if (udc->clocked)
 		return;
 	udc->clocked = 1;
+	if (udc->uclk) {
+		clk_set_rate(udc->uclk, 48000000);
+		clk_prepare_enable(udc->uclk);
+	}
 	clk_prepare_enable(udc->iclk);
 	clk_prepare_enable(udc->fclk);
 }
@@ -882,6 +886,8 @@ static void clk_off(struct at91_udc *udc)
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	clk_disable_unprepare(udc->fclk);
 	clk_disable_unprepare(udc->iclk);
+	if (udc->uclk)
+		clk_disable_unprepare(udc->uclk);
 }
 
 /*
@@ -1781,6 +1787,10 @@ static int at91udc_probe(struct platform_device *pdev)
 		goto fail1;
 	}
 
+	udc->uclk = clk_get(dev, "usb_clk");
+	if (IS_ERR(udc->uclk))
+		udc->uclk = NULL;
+
 	/* don't do anything until we have both gadget driver and VBUS */
 	retval = clk_prepare_enable(udc->iclk);
 	if (retval)
@@ -1894,6 +1904,8 @@ static int __exit at91udc_remove(struct platform_device *pdev)
 
 	clk_put(udc->iclk);
 	clk_put(udc->fclk);
+	if (udc->uclk)
+		clk_put(udc->uclk);
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/at91_udc.h b/drivers/usb/gadget/at91_udc.h
index e647d1c..0175246 100644
--- a/drivers/usb/gadget/at91_udc.h
+++ b/drivers/usb/gadget/at91_udc.h
@@ -126,7 +126,7 @@ struct at91_udc {
 	unsigned			active_suspend:1;
 	u8				addr;
 	struct at91_udc_data		board;
-	struct clk			*iclk, *fclk;
+	struct clk			*iclk, *fclk, *uclk;
 	struct platform_device		*pdev;
 	struct proc_dir_entry		*pde;
 	void __iomem			*udp_baseaddr;
-- 
1.7.9.5
