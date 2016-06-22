From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 21 Jun 2016 23:25:47 -0300
Subject: [PATCH 1/3] usb: dwc2: Add support for STM32F429/439/469 USB OTG in
 FS mode with internal PHY
Message-ID: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 drivers/usb/dwc2/core.c     | 18 ++++++++++++++++++
 drivers/usb/dwc2/core.h     |  5 +++++
 drivers/usb/dwc2/hcd.c      | 12 +++++++++++-
 drivers/usb/dwc2/hw.h       |  2 ++
 drivers/usb/dwc2/platform.c | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 4135a5f..83fbed6 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -1276,6 +1276,23 @@ static void dwc2_set_param_hibernation(struct dwc2_hsotg *hsotg,
 	hsotg->core_params->hibernation = val;
 }
 
+static void dwc2_set_param_stm32_powerdown(struct dwc2_hsotg *hsotg,
+		int val)
+{
+	if (DWC2_OUT_OF_BOUNDS(val, 0, 1)) {
+		if (val >= 0) {
+			dev_err(hsotg->dev,
+				"'%d' invalid for parameter power down\n",
+				val);
+			dev_err(hsotg->dev, "power down must be 0 or 1\n");
+		}
+		val = 0;
+		dev_dbg(hsotg->dev, "Setting power down to %d\n", val);
+	}
+
+	hsotg->core_params->stm32_powerdown = val;
+}
+
 /*
  * This function is called during module intialization to pass module parameters
  * for the DWC_otg core.
@@ -1323,6 +1340,7 @@ void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
 	dwc2_set_param_uframe_sched(hsotg, params->uframe_sched);
 	dwc2_set_param_external_id_pin_ctl(hsotg, params->external_id_pin_ctl);
 	dwc2_set_param_hibernation(hsotg, params->hibernation);
+	dwc2_set_param_stm32_powerdown(hsotg, params->stm32_powerdown);
 }
 
 /*
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 3c58d63..d3e4fcb 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -386,6 +386,10 @@ enum dwc2_ep0_state {
  *			needed.
  *			0 - No (default)
  *			1 - Yes
+ * @stm32_powerdown:	Enable STM32 specific USB FS transceiver power down
+ *			control.
+ *			0 = USB FS transceiver disabled (default)
+ *			1 = USB FS transceiver enabled
  *
  * The following parameters may be specified when starting the module. These
  * parameters define how the DWC_otg controller should be configured. A
@@ -426,6 +430,7 @@ struct dwc2_core_params {
 	int uframe_sched;
 	int external_id_pin_ctl;
 	int hibernation;
+	int stm32_powerdown;
 };
 
 /**
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2df3d04..4f9bb93 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -118,7 +118,7 @@ static void dwc2_init_fs_ls_pclk_sel(struct dwc2_hsotg *hsotg)
 
 static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 {
-	u32 usbcfg, i2cctl;
+	u32 usbcfg, usbgpio, i2cctl;
 	int retval = 0;
 
 	/*
@@ -142,6 +142,16 @@ static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 				return retval;
 			}
 		}
+
+		if (hsotg->core_params->stm32_powerdown > 0) {
+			dev_dbg(hsotg->dev, "STM32 FS PHY enabling transceiver\n");
+			/* STM32 uses the GGPIO register as general core
+			 * configuration register.
+			 */
+			usbgpio = dwc2_readl(hsotg->regs + GGPIO);
+			usbgpio |= STM32_OTG_GCCFG_PWRDWN;
+			dwc2_writel(usbgpio, hsotg->regs + GGPIO);
+		}
 	}
 
 	/*
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index 281b57b..d5f9294 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -224,6 +224,8 @@
 
 #define GPVNDCTL			HSOTG_REG(0x0034)
 #define GGPIO				HSOTG_REG(0x0038)
+#define STM32_OTG_GCCFG_PWRDWN		(1 << 16)
+
 #define GUID				HSOTG_REG(0x003c)
 #define GSNPSID				HSOTG_REG(0x0040)
 #define GHWCFG1				HSOTG_REG(0x0044)
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index fc6f525..d806b94 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -84,6 +84,7 @@ static const struct dwc2_core_params params_hi6220 = {
 	.uframe_sched			= 0,
 	.external_id_pin_ctl		= -1,
 	.hibernation			= -1,
+	.stm32_powerdown		= 0,
 };
 
 static const struct dwc2_core_params params_bcm2835 = {
@@ -115,6 +116,7 @@ static const struct dwc2_core_params params_bcm2835 = {
 	.uframe_sched			= 0,
 	.external_id_pin_ctl		= -1,
 	.hibernation			= -1,
+	.stm32_powerdown		= 0,
 };
 
 static const struct dwc2_core_params params_rk3066 = {
@@ -147,6 +149,7 @@ static const struct dwc2_core_params params_rk3066 = {
 	.uframe_sched			= -1,
 	.external_id_pin_ctl		= -1,
 	.hibernation			= -1,
+	.stm32_powerdown		= 0,
 };
 
 static const struct dwc2_core_params params_ltq = {
@@ -179,6 +182,39 @@ static const struct dwc2_core_params params_ltq = {
 	.uframe_sched			= -1,
 	.external_id_pin_ctl		= -1,
 	.hibernation			= -1,
+	.stm32_powerdown		= 0,
+};
+
+static const struct dwc2_core_params params_stm32fs = {
+	.otg_cap			= 2,	/* non-HNP/non-SRP */
+	.otg_ver			= -1,
+	.dma_enable			= 0,
+	.dma_desc_enable		= 0,
+	.dma_desc_fs_enable		= 0,
+	.speed				= 1,	/* Full Speed */
+	.enable_dynamic_fifo		= -1,
+	.en_multiple_tx_fifo		= -1,
+	.host_rx_fifo_size		= 128,	/* 128 DWORDs */
+	.host_nperio_tx_fifo_size	= 96,	/* 96 DWORDs */
+	.host_perio_tx_fifo_size	= 96,	/* 96 DWORDs */
+	.max_transfer_size		= -1,
+	.max_packet_count		= 256,
+	.host_channels			= -1,
+	.phy_type			= 0,	/* Full Speed PHY */
+	.phy_utmi_width			= 0,
+	.phy_ulpi_ddr			= 0,
+	.phy_ulpi_ext_vbus		= 0,
+	.i2c_enable			= 0,
+	.ulpi_fs_ls			= 0,
+	.host_support_fs_ls_low_power	= 0,
+	.host_ls_low_power_phy_clk	= 0,
+	.ts_dline			= 0,
+	.reload_ctl			= 1,
+	.ahbcfg				= 0,
+	.uframe_sched			= 0,
+	.external_id_pin_ctl		= 0,
+	.hibernation			= 0,
+	.stm32_powerdown		= 1,
 };
 
 /*
@@ -464,6 +500,7 @@ static const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "lantiq,xrx200-usb", .data = &params_ltq },
 	{ .compatible = "snps,dwc2", .data = NULL },
 	{ .compatible = "samsung,s3c6400-hsotg", .data = NULL},
+	{ .compatible = "st,stm32-fsotg", .data = &params_stm32fs},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
-- 
2.7.4 (Apple Git-66)
