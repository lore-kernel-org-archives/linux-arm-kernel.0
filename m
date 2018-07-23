From: pengbo.mu@nxp.com (Pengbo Mu)
Date: Mon, 23 Jul 2018 11:11:25 +0800
Subject: [PATCH v6 2/4] usb: dwc3: Enable undefined length INCR burst type
In-Reply-To: <1532315487-23137-1-git-send-email-pengbo.mu@nxp.com>
References: <1532315487-23137-1-git-send-email-pengbo.mu@nxp.com>
Message-ID: <1532315487-23137-2-git-send-email-pengbo.mu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the undefined length INCR burst type and set INCRx.
Different platform may has the different burst size type.
In order to get best performance, we need to tune the burst
size to one special value, instead of the default value.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v6:
 - rename 'dwc3_set_soc_bus_cfg' to 'dwc3_set_incr_burst_type'
 - modify the codes according to the definition of GSBUSCFG0
 - change variables from global to local
 - add the judgment of 'ntype <= 0'
Changes in v5:
 - no change
Changes in v4:
 - Modify the codes according to the definition of this property.
Changes in v3:
 - add new property for INCR burst in usb node to reset GSBUSCFG0.
Changes in v2:
 - split patch
 - create one new function to handle soc bus configuration register.
---
 drivers/usb/dwc3/core.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  3 ++
 2 files changed, 95 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1038075..29df9e8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -778,6 +778,98 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
+/* set global incr burst type configuration registers */
+static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	/* incrx_mode : for INCR burst type. */
+	bool incrx_mode;
+	/* incrx_size : for size of INCRX burst. */
+	u32 incrx_size;
+	u32 *vals;
+	u32 cfg;
+	int ntype;
+	int ret;
+	int i;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	ntype = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", NULL, 0);
+	if (ntype <= 0)
+		return;
+
+	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
+	if (!vals) {
+		dev_err(dev, "Error to get memory\n");
+		return;
+	}
+
+	/* Get INCR burst type, and parse it */
+	ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", vals, ntype);
+	if (ret) {
+		dev_err(dev, "Error to get property\n");
+		return;
+	}
+
+	incrx_size = *vals;
+
+	if (ntype > 1) {
+		/* INCRX (undefined length) burst mode */
+		incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		for (i = 1; i < ntype; i++) {
+			if (vals[i] > incrx_size)
+				incrx_size = vals[i];
+		}
+	} else {
+		/* INCRX burst mode */
+		incrx_mode = INCRX_BURST_MODE;
+	}
+
+	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
+	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
+	if (incrx_mode)
+		cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
+	switch (incrx_size) {
+	case 256:
+		cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
+		break;
+	case 128:
+		cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
+		break;
+	case 64:
+		cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
+		break;
+	case 32:
+		cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
+		break;
+	case 16:
+		cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
+		break;
+	case 8:
+		cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
+		break;
+	case 4:
+		cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
+		break;
+	case 1:
+		break;
+	default:
+		dev_err(dev, "Invalid property\n");
+		break;
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 213b939..5f14fb7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1168,6 +1168,9 @@ struct dwc3 {
 	u16			imod_interval;
 };
 
+#define INCRX_BURST_MODE 0
+#define INCRX_UNDEF_LENGTH_BURST_MODE 1
+
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
-- 
2.7.4
