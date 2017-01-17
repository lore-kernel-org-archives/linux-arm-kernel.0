From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 17 Jan 2017 14:12:33 -0200
Subject: [PATCH v3 1/5] usb: dwc2: Add support for STM32F429/439/469 USB OTG
 HS/FS in FS mode (internal PHY)
In-Reply-To: <20170117161237.3802-1-bruherrera@gmail.com>
References: <20170117161237.3802-1-bruherrera@gmail.com>
Message-ID: <20170117161237.3802-2-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a new parameter to activate USB OTG HS/FS core embedded
phy transceiver. The STM32F4x9 SoC uses the GGPIO register to enable the transceiver.
Also add the dwc2_core_params structure for stm32f4 otg fs.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 drivers/usb/dwc2/core.h   |  4 ++++
 drivers/usb/dwc2/hcd.c    | 13 +++++++++++-
 drivers/usb/dwc2/hw.h     |  2 ++
 drivers/usb/dwc2/params.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 9548d3e..e3199c5 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -430,6 +430,9 @@ enum dwc2_ep0_state {
  *			needed.
  *			0 - No (default)
  *			1 - Yes
+ * @activate_transceiver: Activate internal transceiver using GGPIO register.
+ *			0 - Deactivate the transceiver (default)
+ *			1 - Activate the transceiver
  * @g_dma:              Enables gadget dma usage (default: autodetect).
  * @g_dma_desc:         Enables gadget descriptor DMA (default: autodetect).
  * @g_rx_fifo_size:	The periodic rx fifo size for the device, in
@@ -501,6 +504,7 @@ struct dwc2_core_params {
 	int uframe_sched;
 	int external_id_pin_ctl;
 	int hibernation;
+	int activate_transceiver;
 
 	/*
 	 * The following parameters are *only* set via device
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 911c3b3..6bee529 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -118,7 +118,7 @@ static void dwc2_init_fs_ls_pclk_sel(struct dwc2_hsotg *hsotg)
 
 static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 {
-	u32 usbcfg, i2cctl;
+	u32 usbcfg, ggpio, i2cctl;
 	int retval = 0;
 
 	/*
@@ -142,6 +142,17 @@ static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 				return retval;
 			}
 		}
+
+		ggpio = dwc2_readl(hsotg->regs + GGPIO);
+		if (!(ggpio & GGPIO_STM32_OTG_GCCFG_PWRDWN) &&
+		    (hsotg->params.activate_transceiver > 0)) {
+			dev_dbg(hsotg->dev, "Activating transceiver\n");
+			/* STM32F4xx uses the GGPIO register as general core
+			 * configuration register.
+			 */
+			ggpio |= GGPIO_STM32_OTG_GCCFG_PWRDWN;
+			dwc2_writel(ggpio, hsotg->regs + GGPIO);
+		}
 	}
 
 	/*
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index 5be056b..a84e93b 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -225,6 +225,8 @@
 
 #define GPVNDCTL			HSOTG_REG(0x0034)
 #define GGPIO				HSOTG_REG(0x0038)
+#define GGPIO_STM32_OTG_GCCFG_PWRDWN	(1 << 16)
+
 #define GUID				HSOTG_REG(0x003c)
 #define GSNPSID				HSOTG_REG(0x0040)
 #define GHWCFG1				HSOTG_REG(0x0044)
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 11fe68a..dbb054d 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -192,6 +192,37 @@ static const struct dwc2_core_params params_amlogic = {
 	.hibernation			= -1,
 };
 
+static const struct dwc2_core_params params_stm32f4_otgfs = {
+	.otg_cap			= DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE,
+	.otg_ver			= -1,
+	.dma_desc_enable		= 0,
+	.dma_desc_fs_enable		= 0,
+	.speed				= DWC2_SPEED_PARAM_FULL,
+	.enable_dynamic_fifo		= -1,
+	.en_multiple_tx_fifo		= -1,
+	.host_rx_fifo_size		= 128,	/* 128 DWORDs */
+	.host_nperio_tx_fifo_size	= 96,	/* 96 DWORDs */
+	.host_perio_tx_fifo_size	= 96,	/* 96 DWORDs */
+	.max_transfer_size		= -1,
+	.max_packet_count		= 256,
+	.host_channels			= -1,
+	.phy_type			= DWC2_PHY_TYPE_PARAM_FS,
+	.phy_utmi_width			= -1,
+	.phy_ulpi_ddr			= -1,
+	.phy_ulpi_ext_vbus		= -1,
+	.i2c_enable			= 0,
+	.ulpi_fs_ls			= -1,
+	.host_support_fs_ls_low_power	= -1,
+	.host_ls_low_power_phy_clk	= -1,
+	.ts_dline			= -1,
+	.reload_ctl			= -1,
+	.ahbcfg				= -1,
+	.uframe_sched			= 0,
+	.external_id_pin_ctl		= -1,
+	.hibernation			= -1,
+	.activate_transceiver		= 1,
+};
+
 static const struct dwc2_core_params params_default = {
 	.otg_cap			= -1,
 	.otg_ver			= -1,
@@ -240,6 +271,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "amlogic,meson8b-usb", .data = &params_amlogic },
 	{ .compatible = "amlogic,meson-gxbb-usb", .data = &params_amlogic },
 	{ .compatible = "amcc,dwc-otg", .data = NULL },
+	{ .compatible = "st,stm32f4xx-fsotg", .data = &params_stm32f4_otgfs },
+	{ .compatible = "st,stm32f4xx-hsotg", .data = NULL },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
@@ -1044,6 +1077,23 @@ static void dwc2_set_param_hibernation(struct dwc2_hsotg *hsotg,
 	hsotg->params.hibernation = val;
 }
 
+static void dwc2_set_param_activate_transceiver(struct dwc2_hsotg *hsotg,
+		int val)
+{
+	if (DWC2_OUT_OF_BOUNDS(val, 0, 1)) {
+		if (val >= 0) {
+			dev_err(hsotg->dev,
+				"'%d' invalid for parameter activate transceiver\n",
+				val);
+			dev_err(hsotg->dev, "activate transceiver must be 0 or 1\n");
+		}
+		val = 0;
+		dev_dbg(hsotg->dev, "Setting activate transceiver to %d\n", val);
+	}
+
+	hsotg->params.activate_transceiver = val;
+}
+
 static void dwc2_set_param_tx_fifo_sizes(struct dwc2_hsotg *hsotg)
 {
 	int i;
@@ -1158,6 +1208,7 @@ static void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
 	dwc2_set_param_uframe_sched(hsotg, params->uframe_sched);
 	dwc2_set_param_external_id_pin_ctl(hsotg, params->external_id_pin_ctl);
 	dwc2_set_param_hibernation(hsotg, params->hibernation);
+	dwc2_set_param_activate_transceiver(hsotg, params->activate_transceiver);
 
 	/*
 	 * Set devicetree-only parameters. These parameters do not
-- 
2.10.1 (Apple Git-78)
