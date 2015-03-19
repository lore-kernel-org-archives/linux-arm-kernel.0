From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:23 +0800
Subject: [PATCH 12/12] usb: chipidea: add burst size configuration interface
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-13-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The user can adjust it through dts or other platform interfaces.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/bits.h  |  4 ++++
 drivers/usb/chipidea/ci.h    |  1 +
 drivers/usb/chipidea/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/usb/chipidea.h |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 3af6213..466ce89 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -56,6 +56,10 @@
 #define DEVICEADDR_USBADRA    BIT(24)
 #define DEVICEADDR_USBADR     (0x7FUL << 25)
 
+/* BURSTSIZE */
+#define RX_BURST_MASK		0xff
+#define TX_BURST_MASK		0xff00
+
 /* PORTSC */
 #define PORTSC_CCS            BIT(0)
 #define PORTSC_CSC            BIT(1)
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 888606b..232156b 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -50,6 +50,7 @@ enum ci_hw_regs {
 	OP_USBINTR,
 	OP_DEVICEADDR,
 	OP_ENDPTLISTADDR,
+	OP_BURSTSIZE,
 	OP_PORTSC,
 	OP_DEVLC,
 	OP_OTGSC,
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index c0e6bb1..beb4236 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -84,6 +84,7 @@ static const u8 ci_regs_nolpm[] = {
 	[OP_USBINTR]		= 0x08U,
 	[OP_DEVICEADDR]		= 0x14U,
 	[OP_ENDPTLISTADDR]	= 0x18U,
+	[OP_BURSTSIZE]		= 0x20U,
 	[OP_PORTSC]		= 0x44U,
 	[OP_DEVLC]		= 0x84U,
 	[OP_OTGSC]		= 0x64U,
@@ -106,6 +107,7 @@ static const u8 ci_regs_lpm[] = {
 	[OP_USBINTR]		= 0x08U,
 	[OP_DEVICEADDR]		= 0x14U,
 	[OP_ENDPTLISTADDR]	= 0x18U,
+	[OP_BURSTSIZE]		= 0x20U,
 	[OP_PORTSC]		= 0x44U,
 	[OP_DEVLC]		= 0x84U,
 	[OP_OTGSC]		= 0xC4U,
@@ -412,6 +414,7 @@ static int ci_usb_phy_init(struct ci_hdrc *ci)
  */
 void ci_platform_config(struct ci_hdrc *ci, int usb_mode)
 {
+	u32 ahb_burst_config;
 	bool override_needed;
 
 	if (usb_mode == USBMODE_CM_DC) {
@@ -447,6 +450,22 @@ void ci_platform_config(struct ci_hdrc *ci, int usb_mode)
 	if (override_needed)
 		hw_write_id_reg(ci, ID_SBUSCFG, AHBBRST_MASK,
 			ci->platdata->ahbburst_config);
+
+	ahb_burst_config = hw_read_id_reg(ci, ID_SBUSCFG, AHBBRST_MASK);
+
+	/* Override tx burst size if needed */
+	override_needed = hw_read(ci, OP_BURSTSIZE, RX_BURST_MASK) !=
+			(ci->platdata->rx_burst_size & RX_BURST_MASK);
+	if (!ahb_burst_config && override_needed)
+		hw_write(ci, OP_BURSTSIZE, RX_BURST_MASK,
+			ci->platdata->rx_burst_size);
+
+	/* Override tx burst size if needed */
+	override_needed = ((hw_read(ci, OP_BURSTSIZE, TX_BURST_MASK) >>
+			__ffs(TX_BURST_MASK)) != ci->platdata->tx_burst_size);
+	if (!ahb_burst_config && override_needed)
+		hw_write(ci, OP_BURSTSIZE, TX_BURST_MASK,
+			ci->platdata->tx_burst_size << __ffs(TX_BURST_MASK));
 }
 
 /**
@@ -651,6 +670,26 @@ static int ci_get_platdata(struct device *dev,
 		}
 	}
 
+	if (of_find_property(dev->of_node, "tx-burst-size-dword", NULL)) {
+		ret = of_property_read_u32(dev->of_node, "tx-burst-size-dword",
+			&platdata->tx_burst_size);
+		if (ret) {
+			dev_err(dev,
+				"failed to get tx-burst-size-dword value\n");
+			return ret;
+		}
+	}
+
+	if (of_find_property(dev->of_node, "rx-burst-size-dword", NULL)) {
+		ret = of_property_read_u32(dev->of_node, "rx-burst-size-dword",
+			&platdata->rx_burst_size);
+		if (ret) {
+			dev_err(dev,
+				"failed to get rx-burst-size-dword value\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 4d7ceb3..b5f0d7b 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -42,6 +42,8 @@ struct ci_hdrc_platform_data {
 	/* interrupt threshold value for gadget */
 	u32			gadget_itc_setting;
 	u32			ahbburst_config;
+	u32			tx_burst_size;
+	u32			rx_burst_size;
 };
 
 /* Default offset of capability registers */
-- 
1.9.1
