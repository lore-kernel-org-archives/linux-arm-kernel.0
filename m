From: jerry.huang@nxp.com (Changming Huang)
Date: Mon, 19 Dec 2016 17:25:54 +0800
Subject: [PATCH v3 3/3] USB3/DWC3: Enable undefined length INCR burst type
In-Reply-To: <1482139554-13618-1-git-send-email-jerry.huang@nxp.com>
References: <1482139554-13618-1-git-send-email-jerry.huang@nxp.com>
Message-ID: <1482139554-13618-3-git-send-email-jerry.huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the undefined length INCR burst type and set INCRx.
Different platform may has the different burst size type.
In order to get best performance, we need to tune the burst size to
one special value, instead of the default value.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
---
Changes in v3:
  - add new property for INCR burst in usb node to reset GSBUSCFG0.
Changes in v2:
  - split patch
  - create one new function to handle soc bus configuration register.

 drivers/usb/dwc3/core.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |    7 +++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 369bab1..404d7e9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -650,6 +650,55 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
+/* set global soc bus configuration registers */
+static void dwc3_set_soc_bus_cfg(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	u32 cfg;
+	int ret;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	/* Get INCR burst type, if return !NULL, not to change this type */
+	ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment",
+			dwc->incr_burst_type, 2);
+	if (!ret) {
+		/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
+		cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
+		if (*dwc->incr_burst_type)
+			cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
+		switch (*(dwc->incr_burst_type + 1)) {
+		case 256:
+			cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
+			break;
+		case 128:
+			cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
+			break;
+		case 64:
+			cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
+			break;
+		case 32:
+			cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
+			break;
+		case 16:
+			cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
+			break;
+		case 8:
+			cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
+			break;
+		case 4:
+			cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
+			break;
+		default:
+			dev_err(dev, "Invalid property\n");
+			break;
+		}
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -698,6 +747,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	dwc3_set_soc_bus_cfg(dwc);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 065aa6f..cfe389b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -805,6 +805,7 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
+ * @incr_burst_type: INCR burst type adjustment
  * @irq_gadget: peripheral controller's IRQ number
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
@@ -928,6 +929,12 @@ struct dwc3 {
 	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
+	/*
+	 * For INCR burst type.
+	 * First field: for undefined length INCR burst type enable.
+	 * Second field: for INCRx burst type enable
+	 */
+	u32			incr_burst_type[2];
 	u32			irq_gadget;
 	u32			nr_scratch;
 	u32			u1u2;
-- 
1.7.9.5
