From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 May 2016 09:05:34 +0800
Subject: [PATCH] usb: ohci-at91: Suspend the ports while USB suspending
Message-ID: <1463015134-32364-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to get lower consumption, as a workaround, suspend
the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI Interrupt
Configuration Register while OHCI USB suspending.

This suspend operation must be done before stopping the USB clock,
resume after the USB clock enabled.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 drivers/usb/host/ohci-at91.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index d177372..ce898e0 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
@@ -51,6 +53,7 @@ struct ohci_at91_priv {
 	struct clk *hclk;
 	bool clocked;
 	bool wakeup;		/* Saved wake-up state for resume */
+	struct regmap *sfr_regmap;
 };
 /* interface and function clocks; sometimes also an AHB clock */
 
@@ -132,6 +135,17 @@ static void at91_stop_hc(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
+struct regmap *at91_dt_syscon_sfr(void)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap))
+		return NULL;
+
+	return regmap;
+}
+
 static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
 
 /* configure so an HC device and id are always provided */
@@ -197,6 +211,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err;
 	}
 
+	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
+
 	board = hcd->self.controller->platform_data;
 	ohci = hcd_to_ohci(hcd);
 	ohci->num_ports = board->ports;
@@ -581,6 +597,49 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#define SFR_OHCIICR		0x10
+#define SFR_OHCIICR_SUSPEND_A	BIT(8)
+#define SFR_OHCIICR_SUSPEND_B	BIT(9)
+#define SFR_OHCIICR_SUSPEND_C	BIT(10)
+
+#define SFR_OHCIICR_USB_SUSPEND	(SFR_OHCIICR_SUSPEND_A | \
+				 SFR_OHCIICR_SUSPEND_B | \
+				 SFR_OHCIICR_SUSPEND_C)
+
+static int ohci_at91_port_ctrl(struct regmap *regmap, bool enable)
+{
+	u32 regval;
+	int ret;
+
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, SFR_OHCIICR, &regval);
+	if (ret)
+		return ret;
+
+	if (enable)
+		regval &= ~SFR_OHCIICR_USB_SUSPEND;
+	else
+		regval |= SFR_OHCIICR_USB_SUSPEND;
+
+	regmap_write(regmap, SFR_OHCIICR, regval);
+
+	regmap_read(regmap, SFR_OHCIICR, &regval);
+
+	return 0;
+}
+
+static int ohci_at91_port_suspend(struct regmap *regmap)
+{
+	return ohci_at91_port_ctrl(regmap, false);
+}
+
+static int ohci_at91_port_resume(struct regmap *regmap)
+{
+	return ohci_at91_port_ctrl(regmap, true);
+}
+
 static int __maybe_unused
 ohci_hcd_at91_drv_suspend(struct device *dev)
 {
@@ -618,6 +677,8 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
 		ohci->rh_state = OHCI_RH_HALTED;
 
+		ohci_at91_port_suspend(ohci_at91->sfr_regmap);
+
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
 		at91_stop_clock(ohci_at91);
@@ -637,6 +698,8 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 
 	at91_start_clock(ohci_at91);
 
+	ohci_at91_port_resume(ohci_at91->sfr_regmap);
+
 	ohci_resume(hcd, false);
 	return 0;
 }
-- 
2.7.4
