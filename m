From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:22 -0700
Subject: [PATCH v5 09/23] usb: chipidea: Add support for ULPI PHY bus
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-10-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some phys for the chipidea controller are controlled via the ULPI
viewport. Add support for the ULPI bus so that these sorts of
phys can be probed and read/written automatically without having
to duplicate the viewport logic in each phy driver.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/Kconfig  |   7 +++
 drivers/usb/chipidea/Makefile |   1 +
 drivers/usb/chipidea/ci.h     |  21 ++++++++
 drivers/usb/chipidea/core.c   |  31 +++++++++---
 drivers/usb/chipidea/ulpi.c   | 113 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 6 deletions(-)
 create mode 100644 drivers/usb/chipidea/ulpi.c

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 5e5b9eb7ebf6..19c20eaa23f2 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -38,4 +38,11 @@ config USB_CHIPIDEA_HOST
 	  Say Y here to enable host controller functionality of the
 	  ChipIdea driver.
 
+config USB_CHIPIDEA_ULPI
+	bool "ChipIdea ULPI PHY support"
+	depends on USB_ULPI_BUS=y || USB_ULPI_BUS=USB_CHIPIDEA
+	help
+	  Say Y here if you have a ULPI PHY attached to your ChipIdea
+	  controller.
+
 endif
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 518e445476c3..39fca5715ed3 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -4,6 +4,7 @@ ci_hdrc-y				:= core.o otg.o debug.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_UDC)	+= udc.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_HOST)	+= host.o
 ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
+ci_hdrc-$(CONFIG_USB_CHIPIDEA_ULPI)	+= ulpi.o
 
 # Glue/Bridge layers go here
 
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 05bc4d631cb9..59e22389c10b 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -18,6 +18,8 @@
 #include <linux/usb.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg-fsm.h>
+#include <linux/usb/otg.h>
+#include <linux/ulpi/interface.h>
 
 /******************************************************************************
  * DEFINE
@@ -52,6 +54,7 @@ enum ci_hw_regs {
 	OP_ENDPTLISTADDR,
 	OP_TTCTRL,
 	OP_BURSTSIZE,
+	OP_ULPI_VIEWPORT,
 	OP_PORTSC,
 	OP_DEVLC,
 	OP_OTGSC,
@@ -187,6 +190,8 @@ struct hw_bank {
  * @test_mode: the selected test mode
  * @platdata: platform specific information supplied by parent device
  * @vbus_active: is VBUS active
+ * @ulpi: pointer to ULPI device, if any
+ * @ulpi_ops: ULPI read/write ops for this device
  * @phy: pointer to PHY, if any
  * @usb_phy: pointer to USB PHY, if any and if using the USB PHY framework
  * @hcd: pointer to usb_hcd for ehci host driver
@@ -236,6 +241,10 @@ struct ci_hdrc {
 
 	struct ci_hdrc_platform_data	*platdata;
 	int				vbus_active;
+#ifdef CONFIG_USB_CHIPIDEA_ULPI
+	struct ulpi			*ulpi;
+	struct ulpi_ops 		ulpi_ops;
+#endif
 	struct phy			*phy;
 	/* old usb_phy interface */
 	struct usb_phy			*usb_phy;
@@ -418,6 +427,16 @@ static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
 #endif
 }
 
+#if IS_ENABLED(CONFIG_USB_CHIPIDEA_ULPI)
+int ci_ulpi_init(struct ci_hdrc *ci);
+void ci_ulpi_exit(struct ci_hdrc *ci);
+int ci_ulpi_resume(struct ci_hdrc *ci);
+#else
+static inline int ci_ulpi_init(struct ci_hdrc *ci) { return 0; }
+static inline void ci_ulpi_exit(struct ci_hdrc *ci) { }
+static inline int ci_ulpi_resume(struct ci_hdrc *ci) { return 0; }
+#endif
+
 u32 hw_read_intr_enable(struct ci_hdrc *ci);
 
 u32 hw_read_intr_status(struct ci_hdrc *ci);
@@ -428,6 +447,8 @@ int hw_port_test_set(struct ci_hdrc *ci, u8 mode);
 
 u8 hw_port_test_get(struct ci_hdrc *ci);
 
+void hw_phymode_configure(struct ci_hdrc *ci);
+
 void ci_platform_configure(struct ci_hdrc *ci);
 
 int dbg_create_files(struct ci_hdrc *ci);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 532085a096d9..f144e1bbcc82 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -86,6 +86,7 @@ static const u8 ci_regs_nolpm[] = {
 	[OP_ENDPTLISTADDR]	= 0x18U,
 	[OP_TTCTRL]		= 0x1CU,
 	[OP_BURSTSIZE]		= 0x20U,
+	[OP_ULPI_VIEWPORT]	= 0x30U,
 	[OP_PORTSC]		= 0x44U,
 	[OP_DEVLC]		= 0x84U,
 	[OP_OTGSC]		= 0x64U,
@@ -110,6 +111,7 @@ static const u8 ci_regs_lpm[] = {
 	[OP_ENDPTLISTADDR]	= 0x18U,
 	[OP_TTCTRL]		= 0x1CU,
 	[OP_BURSTSIZE]		= 0x20U,
+	[OP_ULPI_VIEWPORT]	= 0x30U,
 	[OP_PORTSC]		= 0x44U,
 	[OP_DEVLC]		= 0x84U,
 	[OP_OTGSC]		= 0xC4U,
@@ -285,7 +287,7 @@ static int hw_device_init(struct ci_hdrc *ci, void __iomem *base)
 	return 0;
 }
 
-static void hw_phymode_configure(struct ci_hdrc *ci)
+void hw_phymode_configure(struct ci_hdrc *ci)
 {
 	u32 portsc, lpm, sts = 0;
 
@@ -894,6 +896,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		CI_HDRC_IMX28_WRITE_FIX);
 	ci->supports_runtime_pm = !!(ci->platdata->flags &
 		CI_HDRC_SUPPORTS_RUNTIME_PM);
+	platform_set_drvdata(pdev, ci);
 
 	ret = hw_device_init(ci, base);
 	if (ret < 0) {
@@ -901,6 +904,10 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = ci_ulpi_init(ci);
+	if (ret)
+		return ret;
+
 	if (ci->platdata->phy) {
 		ci->phy = ci->platdata->phy;
 	} else if (ci->platdata->usb_phy) {
@@ -911,11 +918,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 		/* if both generic PHY and USB PHY layers aren't enabled */
 		if (PTR_ERR(ci->phy) == -ENOSYS &&
-				PTR_ERR(ci->usb_phy) == -ENXIO)
-			return -ENXIO;
+				PTR_ERR(ci->usb_phy) == -ENXIO) {
+			ret = -ENXIO;
+			goto ulpi_exit;
+		}
 
-		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy))
-			return -EPROBE_DEFER;
+		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy)) {
+			ret = -EPROBE_DEFER;
+			goto ulpi_exit;
+		}
 
 		if (IS_ERR(ci->phy))
 			ci->phy = NULL;
@@ -1000,7 +1011,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, ci);
 	ret = devm_request_irq(dev, ci->irq, ci_irq, IRQF_SHARED,
 			ci->platdata->name, ci);
 	if (ret)
@@ -1032,6 +1042,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ci_role_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
+ulpi_exit:
+	ci_ulpi_exit(ci);
 
 	return ret;
 }
@@ -1051,6 +1063,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	ci_role_destroy(ci);
 	ci_hdrc_enter_lpm(ci, true);
 	ci_usb_phy_exit(ci);
+	ci_ulpi_exit(ci);
 
 	return 0;
 }
@@ -1098,6 +1111,7 @@ static void ci_controller_suspend(struct ci_hdrc *ci)
 static int ci_controller_resume(struct device *dev)
 {
 	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	int ret;
 
 	dev_dbg(dev, "at %s\n", __func__);
 
@@ -1107,6 +1121,11 @@ static int ci_controller_resume(struct device *dev)
 	}
 
 	ci_hdrc_enter_lpm(ci, false);
+
+	ret = ci_ulpi_resume(ci);
+	if (ret)
+		return ret;
+
 	if (ci->usb_phy) {
 		usb_phy_set_suspend(ci->usb_phy, 0);
 		usb_phy_set_wakeup(ci->usb_phy, false);
diff --git a/drivers/usb/chipidea/ulpi.c b/drivers/usb/chipidea/ulpi.c
new file mode 100644
index 000000000000..1219583dc1b2
--- /dev/null
+++ b/drivers/usb/chipidea/ulpi.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright (c) 2016 Linaro Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/usb/chipidea.h>
+#include <linux/ulpi/interface.h>
+
+#include "ci.h"
+
+#define ULPI_WAKEUP		BIT(31)
+#define ULPI_RUN		BIT(30)
+#define ULPI_WRITE		BIT(29)
+#define ULPI_SYNC_STATE		BIT(27)
+#define ULPI_ADDR(n)		((n) << 16)
+#define ULPI_DATA(n)		(n)
+
+static int ci_ulpi_wait(struct ci_hdrc *ci, u32 mask)
+{
+	unsigned long usec = 10000;
+
+	while (usec--) {
+		if (!hw_read(ci, OP_ULPI_VIEWPORT, mask))
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int ci_ulpi_read(struct device *dev, u8 addr)
+{
+	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	int ret;
+
+	hw_write(ci, OP_ULPI_VIEWPORT, 0xffffffff, ULPI_WRITE | ULPI_WAKEUP);
+	ret = ci_ulpi_wait(ci, ULPI_WAKEUP);
+	if (ret)
+		return ret;
+
+	hw_write(ci, OP_ULPI_VIEWPORT, 0xffffffff, ULPI_RUN | ULPI_ADDR(addr));
+	ret = ci_ulpi_wait(ci, ULPI_RUN);
+	if (ret)
+		return ret;
+
+	return hw_read(ci, OP_ULPI_VIEWPORT, GENMASK(15, 8)) >> 8;
+}
+
+static int ci_ulpi_write(struct device *dev, u8 addr, u8 val)
+{
+	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	int ret;
+
+	hw_write(ci, OP_ULPI_VIEWPORT, 0xffffffff, ULPI_WRITE | ULPI_WAKEUP);
+	ret = ci_ulpi_wait(ci, ULPI_WAKEUP);
+	if (ret)
+		return ret;
+
+	hw_write(ci, OP_ULPI_VIEWPORT, 0xffffffff,
+		 ULPI_RUN | ULPI_WRITE | ULPI_ADDR(addr) | val);
+	return ci_ulpi_wait(ci, ULPI_RUN);
+}
+
+int ci_ulpi_init(struct ci_hdrc *ci)
+{
+	if (ci->platdata->phy_mode != USBPHY_INTERFACE_MODE_ULPI)
+		return 0;
+
+	/*
+	 * Set PORTSC correctly so we can read/write ULPI registers for
+	 * identification purposes
+	 */
+	hw_phymode_configure(ci);
+
+	ci->ulpi_ops.read = ci_ulpi_read;
+	ci->ulpi_ops.write = ci_ulpi_write;
+	ci->ulpi = ulpi_register_interface(ci->dev, &ci->ulpi_ops);
+	if (IS_ERR(ci->ulpi))
+		dev_err(ci->dev, "failed to register ULPI interface");
+
+	return PTR_ERR_OR_ZERO(ci->ulpi);
+}
+
+void ci_ulpi_exit(struct ci_hdrc *ci)
+{
+	if (ci->ulpi) {
+		ulpi_unregister_interface(ci->ulpi);
+		ci->ulpi = NULL;
+	}
+}
+
+int ci_ulpi_resume(struct ci_hdrc *ci)
+{
+	int cnt = 100000;
+
+	while (cnt-- > 0) {
+		if (hw_read(ci, OP_ULPI_VIEWPORT, ULPI_SYNC_STATE))
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
-- 
2.10.0.297.gf6727b0
