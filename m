From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 17:19:07 +0100
Subject: [PATCH 6/9] usb: chipidea: add PTW and PTS handling
In-Reply-To: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352909950-32555-7-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to configure the PTW and PTS bits inside
the portsc register for host and device mode before the driver starts
and the phy can be addressed as hardware implementation is designed.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/bits.h        |    3 +++
 drivers/usb/chipidea/ci.h          |    2 ++
 drivers/usb/chipidea/ci13xxx_imx.c |    1 +
 drivers/usb/chipidea/core.c        |   47 ++++++++++++++++++++++++++++++++++++
 drivers/usb/chipidea/host.c        |    4 +++
 include/linux/usb/chipidea.h       |    9 +++++++
 6 files changed, 66 insertions(+)

diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 4b6ae3e..3cded5f 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -48,6 +48,9 @@
 #define PORTSC_SUSP           BIT(7)
 #define PORTSC_HSP            BIT(9)
 #define PORTSC_PTC            (0x0FUL << 16)
+#define PORTSC_PTS            (BIT(31) | BIT(30))
+#define PORTSC_PTW            BIT(28)
+#define PORTSC_STS            BIT(29)
 
 /* DEVLC */
 #define DEVLC_PSPD            (0x03UL << 25)
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index cd42b59..1439e51 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -314,6 +314,8 @@ static inline u32 hw_test_and_write(struct ci13xxx *ci, enum ci13xxx_regs reg,
 	return (val & mask) >> ffs_nr(mask);
 }
 
+void hw_portsc_configure(struct ci13xxx *ci);
+
 int hw_device_reset(struct ci13xxx *ci, u32 mode);
 
 int hw_port_test_set(struct ci13xxx *ci, u8 mode);
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index ee4dab0..a8257b8 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -133,6 +133,7 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		       CI13XXX_PULLUP_ON_VBUS |
 		       CI13XXX_DISABLE_STREAMING |
 		       CI13XXX_REGS_SHARED,
+	ci13xxx_get_dr_flags(pdev->dev.of_node, pdata);
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3e3e159..7e80f1b 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -68,6 +68,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/chipidea.h>
+#include <linux/of_usbphy.h>
+#include <linux/phy.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -213,6 +215,23 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 	return 0;
 }
 
+void hw_portsc_configure(struct ci13xxx *ci)
+{
+	if (ci->platdata->flags & CI13XXX_PORTSC_PTW_16BIT)
+		hw_write(ci, OP_PORTSC, PORTSC_PTW, 0x1 << ffs_nr(PORTSC_PTW));
+
+	if (ci->platdata->flags & CI13XXX_PORTSC_PTS_UTMI) {
+		hw_write(ci, OP_PORTSC, PORTSC_PTS, 0x0 << ffs_nr(PORTSC_PTS));
+		hw_write(ci, OP_PORTSC, PORTSC_STS, 0x0 << ffs_nr(PORTSC_STS));
+	} else if (ci->platdata->flags & CI13XXX_PORTSC_PTS_ULPI) {
+		hw_write(ci, OP_PORTSC, PORTSC_PTS, 0x2 << ffs_nr(PORTSC_PTS));
+		hw_write(ci, OP_PORTSC, PORTSC_STS, 0x0 << ffs_nr(PORTSC_STS));
+	} else if (ci->platdata->flags & CI13XXX_PORTSC_PTS_FSLS) {
+		hw_write(ci, OP_PORTSC, PORTSC_PTS, 0x3 << ffs_nr(PORTSC_PTS));
+		hw_write(ci, OP_PORTSC, PORTSC_STS, 0x1 << ffs_nr(PORTSC_STS));
+	}
+}
+
 /**
  * hw_device_reset: resets chip (execute without interruption)
  * @ci: the controller
@@ -237,6 +256,8 @@ int hw_device_reset(struct ci13xxx *ci, u32 mode)
 	if (ci->platdata->flags & CI13XXX_DISABLE_STREAMING)
 		hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS, USBMODE_CI_SDIS);
 
+	hw_portsc_configure(ci);
+
 	/* USBMODE should be configured step by step */
 	hw_write(ci, OP_USBMODE, USBMODE_CM, USBMODE_CM_IDLE);
 	hw_write(ci, OP_USBMODE, USBMODE_CM, mode);
@@ -522,6 +543,32 @@ void ci13xxx_remove_device(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
 
+void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
+{
+	int interface = of_get_usbphy_mode(of_node);
+
+	switch (interface) {
+	case USBPHY_INTERFACE_MODE_UTMI:
+		pdata->flags |= CI13XXX_PORTSC_PTS_UTMI;
+		break;
+	case USBPHY_INTERFACE_MODE_UTMIW:
+		pdata->flags |= CI13XXX_PORTSC_PTS_UTMI |
+			CI13XXX_PORTSC_PTW_16BIT;
+		break;
+	case USBPHY_INTERFACE_MODE_ULPI:
+		pdata->flags |= CI13XXX_PORTSC_PTS_ULPI;
+		break;
+	case USBPHY_INTERFACE_MODE_SERIAL:
+		pdata->flags |= CI13XXX_PORTSC_PTS_FSLS;
+		break;
+	case USBPHY_INTERFACE_MODE_NA:
+	default:
+		pr_err("no phy interface defined\n");
+	}
+
+}
+EXPORT_SYMBOL_GPL(ci13xxx_get_dr_flags);
+
 void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
 {
 	const unsigned char *dr_mode;
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index ebff9f4..b23ee1d 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -106,6 +106,10 @@ static int host_start(struct ci13xxx *ci)
 	if (usb_disabled())
 		return -ENODEV;
 
+	hw_portsc_configure(ci);
+
+	mdelay(10);
+
 	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
 	if (!hcd)
 		return -ENOMEM;
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 906d259..cafca23 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -21,6 +21,12 @@ struct ci13xxx_platform_data {
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
 #define CI13XXX_DR_MODE_HOST		BIT(4)
 #define CI13XXX_DR_MODE_PERIPHERAL	BIT(5)
+#define CI13XXX_PORTSC_PTW_8BIT		BIT(6)
+#define CI13XXX_PORTSC_PTW_16BIT	BIT(7)
+#define CI13XXX_PORTSC_PTS_UTMI		BIT(8)
+#define CI13XXX_PORTSC_PTS_ULPI		BIT(9)
+#define CI13XXX_PORTSC_PTS_FSLS		BIT(10)
+
 #define CI13XXX_DR_MODE_MASK \
 	(CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL)
 
@@ -42,4 +48,7 @@ void ci13xxx_remove_device(struct platform_device *pdev);
 /* Parse of-tree "dr_mode" property */
 void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
 
+/* Parse of-tree "flags" */
+void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
+
 #endif
-- 
1.7.10.4
