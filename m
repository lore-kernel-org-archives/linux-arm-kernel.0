From: p.paneri@samsung.com (p.paneri at samsung.com)
Date: Tue, 21 Jun 2011 12:33:43 +0530
Subject: [RFC][PATCH 1/5] USB: DWC OTG: Modification in DWC OTG driver for ARM
	based SoCs.
In-Reply-To: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1308639827-2121-2-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Praveen Paneri <p.paneri@samsung.com>

This patch modifies DWC OTG for ARM based SoCs. Currently it has
been tested for Samsung S5P6440. Can easily be built for others
as well.

Following features are tested for basic functions on SMDK6440
board after modifications:
OTG HOST: HID and mass-storage
OTG DEVICE: mass-storage and adb

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 drivers/usb/dwc/Makefile |    3 ++
 drivers/usb/dwc/apmppc.c |   36 +++++++++++++++++++++++++++-----
 drivers/usb/dwc/cil.h    |   50 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc/param.c  |   28 +++++++++++++++++++++++--
 4 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc/Makefile b/drivers/usb/dwc/Makefile
index 4102add..7f60caa 100644
--- a/drivers/usb/dwc/Makefile
+++ b/drivers/usb/dwc/Makefile
@@ -8,6 +8,9 @@ dwc-objs := cil.o cil_intr.o param.o
 ifeq ($(CONFIG_4xx_SOC),y)
 dwc-objs += apmppc.o
 endif
+ifeq ($(CONFIG_CPU_S5P6440),y)
+dwc-objs += apmppc.o
+endif
 
 ifneq ($(CONFIG_DWC_DEVICE_ONLY),y)
 dwc-objs += hcd.o hcd_intr.o \
diff --git a/drivers/usb/dwc/apmppc.c b/drivers/usb/dwc/apmppc.c
index ffbe6dd..b0dcae9 100644
--- a/drivers/usb/dwc/apmppc.c
+++ b/drivers/usb/dwc/apmppc.c
@@ -50,9 +50,6 @@
  * this file system to perform diagnostics on the driver components or the
  * device.
  */
-
-#include <linux/of_platform.h>
-
 #include "driver.h"
 
 #define DWC_DRIVER_VERSION		"1.05"
@@ -110,6 +107,9 @@ static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct dwc_otg_device *dwc_dev = dev_get_drvdata(dev);
+#ifdef CONFIG_CPU_S5P6440
+	struct s5p_otg_platdata *pdata = ofdev->dev.platform_data;
+#endif
 
 	/* Memory allocation for dwc_otg_device may have failed. */
 	if (!dwc_dev)
@@ -152,6 +152,11 @@ static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev)
 
 	/* Clear the drvdata pointer. */
 	dev_set_drvdata(dev, NULL);
+#ifdef CONFIG_CPU_S5P6440
+	/* OTG Phy off */
+	if (pdata && pdata->phy_exit)
+		pdata->phy_exit(ofdev, S5P_USB_PHY_DEVICE);
+#endif
 	return 0;
 }
 
@@ -169,12 +174,14 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
 	int retval;
 	struct dwc_otg_device *dwc_dev;
 	struct device *dev = &ofdev->dev;
+#ifdef CONFIG_CPU_S5P6440
+	struct s5p_otg_platdata *pdata = ofdev->dev.platform_data;
+#endif
 	struct resource res;
 	ulong gusbcfg_addr;
 	u32 usbcfg = 0;
 
 	dev_dbg(dev, "dwc_otg_driver_probe(%p)\n", dev);
-
 	dwc_dev = kzalloc(sizeof(*dwc_dev), GFP_KERNEL);
 	if (!dwc_dev) {
 		dev_err(dev, "kmalloc of dwc_otg_device failed\n");
@@ -182,15 +189,24 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
 		goto fail_dwc_dev;
 	}
 
+#ifdef CONFIG_CPU_S5P6440
+	/* OTG Phy init */
+	if (pdata && pdata->phy_init)
+		pdata->phy_init(ofdev, S5P_USB_PHY_DEVICE);
+#endif
 	/* Retrieve the memory and IRQ resources. */
+#ifdef CONFIG_ARM
+	dwc_dev->irq = ofdev->resource[1].start;
+#else
 	dwc_dev->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+#endif
 	if (dwc_dev->irq == NO_IRQ) {
 		dev_err(dev, "no device irq\n");
 		retval = -ENODEV;
 		goto fail_of_irq;
 	}
 	dev_dbg(dev, "OTG - device irq: %d\n", dwc_dev->irq);
-
+#ifndef CONFIG_ARM
 	if (of_address_to_resource(ofdev->dev.of_node, 0, &res)) {
 		dev_err(dev, "%s: Can't get USB-OTG register address\n",
 			__func__);
@@ -200,8 +216,14 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
 	dev_dbg(dev, "OTG - ioresource_mem start0x%llx: end:0x%llx\n",
 		(unsigned long long)res.start, (unsigned long long)res.end);
 
+
 	dwc_dev->phys_addr = res.start;
 	dwc_dev->base_len = res.end - res.start + 1;
+#else
+	dwc_dev->phys_addr = ofdev->resource[0].start;
+	dwc_dev->base_len = ofdev->resource[0].end -
+				ofdev->resource[0].start + 1;
+#endif
 	if (!request_mem_region(dwc_dev->phys_addr,
 				dwc_dev->base_len, dwc_driver_name)) {
 		dev_err(dev, "request_mem_region failed\n");
@@ -235,7 +257,7 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
 	/*
 	 * Validate parameter values after dwc_otg_cil_init.
 	 */
-	if (check_parameters(dwc_dev->core_if)) {
+	if (check_parameters(dwc_dev->core_if, ofdev)) {
 		retval = -EINVAL;
 		goto fail_check_param;
 	}
@@ -296,6 +318,7 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
 			dwc_dev->hcd = NULL;
 			goto fail_hcd;
 		}
+#ifndef CONFIG_ARM
 		/* configure chargepump interrupt */
 		dwc_dev->hcd->cp_irq = irq_of_parse_and_map(ofdev->dev.of_node,
 							    3);
@@ -316,6 +339,7 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
 				dwc_dev->hcd->cp_irq_installed = 1;
 			}
 		}
+#endif
 	}
 	/*
 	 * Enable the global interrupt after all the interrupt
diff --git a/drivers/usb/dwc/cil.h b/drivers/usb/dwc/cil.h
index 80b7da5..c1a11f1 100644
--- a/drivers/usb/dwc/cil.h
+++ b/drivers/usb/dwc/cil.h
@@ -37,6 +37,15 @@
 #if !defined(__DWC_CIL_H__)
 #define __DWC_CIL_H__
 #include <linux/io.h>
+#ifdef CONFIG_ARM
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <plat/otg.h>
+#include <plat/usb-phy.h>
+#else
+#include <linux/of_platform.h>
+#endif
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/interrupt.h>
@@ -50,6 +59,7 @@
 #define DEBUG
 #endif
 
+#ifndef CONFIG_ARM
 /**
  * Reads the content of a register.
  */
@@ -108,6 +118,43 @@ static inline u32 dwc_read_fifo32(ulong _reg)
 	return in_be32((unsigned __iomem *) _reg);
 #endif
 };
+#else
+/**
+ * Reads the content of a register.
+ */
+static inline u32 dwc_read32(u32 reg)
+{
+	return readl(reg);
+};
+
+/**
+ * Writes a register with a 32 bit value.
+ */
+static inline void dwc_write32(u32 reg, const u32 value)
+{
+	writel(value, reg);
+};
+
+/**
+ * This function modifies bit values in a register.  Using the
+ * algorithm: (reg_contents & ~clear_mask) | set_mask.
+ */
+static inline
+	void dwc_modify32(u32 reg, const u32 _clear_mask, const u32 _set_mask)
+{
+	dwc_write32(reg, (dwc_read32(reg) & ~_clear_mask) | _set_mask);
+};
+
+static inline void dwc_write_fifo32(u32 reg, const u32 _value)
+{
+	writel(_value, reg);
+};
+
+static inline u32 dwc_read_fifo32(u32 _reg)
+{
+	return readl(_reg);
+};
+#endif /* CONFIG_ARM */
 
 /*
  * Debugging support vanishes in non-debug builds.
@@ -1173,5 +1220,6 @@ static inline int dwc_has_feature(struct core_if *core_if,
 	return core_if->features & feature;
 }
 extern struct core_params dwc_otg_module_params;
-extern int __devinit check_parameters(struct core_if *core_if);
+extern int __devinit check_parameters(struct core_if *core_if,
+						struct platform_device *ofdev);
 #endif
diff --git a/drivers/usb/dwc/param.c b/drivers/usb/dwc/param.c
index 523f0db..b48c510 100644
--- a/drivers/usb/dwc/param.c
+++ b/drivers/usb/dwc/param.c
@@ -116,8 +116,12 @@ static int set_valid_tx_fifo_sizes(struct core_if *core_if)
  * This function is called during module intialization to verify that
  * the module parameters are in a valid state.
  */
-int __devinit check_parameters(struct core_if *core_if)
+int __devinit check_parameters(struct core_if *core_if,
+						struct platform_device *ofdev)
 {
+#ifdef CONFIG_CPU_S5P6440
+	struct s5p_otg_platdata *pdata = ofdev->dev.platform_data;
+#endif
 	/* Default values */
 	dwc_otg_module_params.otg_cap = dwc_param_otg_cap_default;
 	dwc_otg_module_params.dma_enable = dwc_param_dma_enable_default;
@@ -145,6 +149,23 @@ int __devinit check_parameters(struct core_if *core_if)
 	 */
 	dwc_otg_module_params.enable_dynamic_fifo =
 	    DWC_HWCFG2_DYN_FIFO_RD(core_if->hwcfg2);
+#ifdef CONFIG_CPU_S5P6440
+	if (pdata && pdata->dev_rx_fifo_size)
+		dwc_otg_module_params.dev_rx_fifo_size =
+						pdata->dev_rx_fifo_size;
+	if (pdata && pdata->dev_nptx_fifo_size)
+		dwc_otg_module_params.dev_nperio_tx_fifo_size =
+						pdata->dev_nptx_fifo_size;
+
+	if (pdata && pdata->host_rx_fifo_size)
+		dwc_otg_module_params.host_rx_fifo_size =
+						pdata->host_rx_fifo_size;
+	if (pdata && pdata->host_nptx_fifo_size)
+		dwc_otg_module_params.host_nperio_tx_fifo_size =
+						pdata->host_nptx_fifo_size;
+	if (pdata && pdata->host_ch_num)
+		dwc_otg_module_params.host_channels = pdata->host_ch_num;
+#else
 	dwc_otg_module_params.dev_rx_fifo_size =
 	    dwc_read32(core_if->core_global_regs + DWC_GRXFSIZ);
 	dwc_otg_module_params.dev_nperio_tx_fifo_size =
@@ -154,6 +175,9 @@ int __devinit check_parameters(struct core_if *core_if)
 	    dwc_read32(core_if->core_global_regs + DWC_GRXFSIZ);
 	dwc_otg_module_params.host_nperio_tx_fifo_size =
 	    dwc_read32(core_if->core_global_regs + DWC_GNPTXFSIZ) >> 16;
+	dwc_otg_module_params.host_channels =
+	    DWC_HWCFG2_NO_HST_CHAN_RD(core_if->hwcfg2) + 1;
+#endif
 	dwc_otg_module_params.host_perio_tx_fifo_size =
 	    dwc_read32(core_if->core_global_regs + DWC_HPTXFSIZ) >> 16;
 	dwc_otg_module_params.max_transfer_size =
@@ -163,8 +187,6 @@ int __devinit check_parameters(struct core_if *core_if)
 	    (1 << (DWC_HWCFG3_PKTSIZE_CTR_WIDTH_RD(core_if->hwcfg3) + 4))
 	    - 1;
 
-	dwc_otg_module_params.host_channels =
-	    DWC_HWCFG2_NO_HST_CHAN_RD(core_if->hwcfg2) + 1;
 	dwc_otg_module_params.dev_endpoints =
 	    DWC_HWCFG2_NO_DEV_EP_RD(core_if->hwcfg2);
 	dwc_otg_module_params.en_multiple_tx_fifo =
-- 
1.7.0.4
