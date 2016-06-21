From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 21 Jun 2016 09:32:44 +0800
Subject: [PATCH v4] usb: ohci-at91: Forcibly suspend ports while USB suspend
Message-ID: <1466472764-29114-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to save power consumption, as a workaround, forcibly suspend
the USB PORTA/B/C via setting the SUSPEND_A/B/C bits of OHCI Interrupt
Configuration Register in the SFR while OHCI USB suspend.

This suspend operation must be done before the USB clock is disabled,
resume after the USB clock is enabled.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v4:
 - To check whether the SFR node with "atmel,sama5d2-sfr" compatible
   is present or not to decide if this feature is applied or not
   when USB OHCI suspend/resume, instead of new compatible.
 - Drop the compatible "atmel,sama5d2-ohci".
 - Drop [PATCH 2/2] ARM: at91/dt: sama5d2: Use new compatible for
   ohci node.
 - Drop include/soc/at91/at91_sfr.h, move the macro definitions to
   atmel-sfr.h which already exists.
 - Change the defines to align the exists.

Changes in v3:
 - Change the compatible description for more precise.

Changes in v2:
 - Add compatible to support forcibly suspend the ports.
 - Add soc/at91/at91_sfr.h to accommodate the defines.
 - Add error checking for .sfr_regmap.
 - Remove unnecessary regmap_read() statement.

 drivers/usb/host/ohci-at91.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 include/soc/at91/atmel-sfr.h | 13 +++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index d177372..f07c398 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -21,8 +21,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <soc/at91/atmel-sfr.h>
 
 #include "ohci.h"
 
@@ -51,6 +54,7 @@ struct ohci_at91_priv {
 	struct clk *hclk;
 	bool clocked;
 	bool wakeup;		/* Saved wake-up state for resume */
+	struct regmap *sfr_regmap;
 };
 /* interface and function clocks; sometimes also an AHB clock */
 
@@ -132,6 +136,17 @@ static void at91_stop_hc(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
+struct regmap *at91_dt_syscon_sfr(void)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap))
+		regmap = NULL;
+
+	return regmap;
+}
+
 static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
 
 /* configure so an HC device and id are always provided */
@@ -197,6 +212,10 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err;
 	}
 
+	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
+	if (!ohci_at91->sfr_regmap)
+		dev_warn(dev, "failed to find sfr node\n");
+
 	board = hcd->self.controller->platform_data;
 	ohci = hcd_to_ohci(hcd);
 	ohci->num_ports = board->ports;
@@ -581,6 +600,38 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ohci_at91_port_ctrl(struct regmap *regmap, bool enable)
+{
+	u32 regval;
+	int ret;
+
+	if (!regmap)
+		return 0;
+
+	ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
+	if (ret)
+		return ret;
+
+	if (enable)
+		regval &= ~AT91_OHCIICR_USB_SUSPEND;
+	else
+		regval |= AT91_OHCIICR_USB_SUSPEND;
+
+	regmap_write(regmap, AT91_SFR_OHCIICR, regval);
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
@@ -618,6 +669,8 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 		ohci_writel(ohci, ohci->hc_control, &ohci->regs->control);
 		ohci->rh_state = OHCI_RH_HALTED;
 
+		ohci_at91_port_suspend(ohci_at91->sfr_regmap);
+
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
 		at91_stop_clock(ohci_at91);
@@ -637,6 +690,8 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 
 	at91_start_clock(ohci_at91);
 
+	ohci_at91_port_resume(ohci_at91->sfr_regmap);
+
 	ohci_resume(hcd, false);
 	return 0;
 }
diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
index 2f9bb98..cca28d4 100644
--- a/include/soc/at91/atmel-sfr.h
+++ b/include/soc/at91/atmel-sfr.h
@@ -13,6 +13,19 @@
 #ifndef _LINUX_MFD_SYSCON_ATMEL_SFR_H
 #define _LINUX_MFD_SYSCON_ATMEL_SFR_H
 
+#define AT91_SFR_DDRCFG		0x04	/* DDR Configuration Register */
+/* 0x08 ~ 0x0c: Reserved */
+#define AT91_SFR_OHCIICR	0x10	/* OHCI Interrupt Configuration Register */
+#define AT91_SFR_OHCIISR	0x14	/* OHCI Interrupt Status Register */
 #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
 
+/* Field definitions */
+#define AT91_OHCIICR_SUSPEND_A	BIT(8)
+#define AT91_OHCIICR_SUSPEND_B	BIT(9)
+#define AT91_OHCIICR_SUSPEND_C	BIT(10)
+
+#define AT91_OHCIICR_USB_SUSPEND	(AT91_OHCIICR_SUSPEND_A | \
+					 AT91_OHCIICR_SUSPEND_B | \
+					 AT91_OHCIICR_SUSPEND_C)
+
 #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
-- 
2.7.4
