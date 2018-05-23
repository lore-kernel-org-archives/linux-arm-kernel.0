From: hl@rock-chips.com (Lin Huang)
Date: Wed, 23 May 2018 15:42:31 +0800
Subject: [PATCH v7 3/5] soc: rockchip: split rockchip_typec_phy struct to
 separate header
In-Reply-To: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
References: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
Message-ID: <1527061353-16902-3-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we may use rockchip_phy_typec struct in other driver, so split
it to separate header.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- None
Changes in v5:
- None
Changes in v6:
- new patch here
Changes in v7:
- move new element to next patch

 drivers/phy/rockchip/phy-rockchip-typec.c | 47 +-------------------------
 include/soc/rockchip/rockchip_phy_typec.h | 55 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 46 deletions(-)
 create mode 100644 include/soc/rockchip/rockchip_phy_typec.h

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 76a4b58..795055f 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -63,6 +63,7 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <soc/rockchip/rockchip_phy_typec.h>
 
 #define CMN_SSM_BANDGAP			(0x21 << 2)
 #define CMN_SSM_BIAS			(0x22 << 2)
@@ -349,52 +350,6 @@
 #define MODE_DFP_USB			BIT(1)
 #define MODE_DFP_DP			BIT(2)
 
-struct usb3phy_reg {
-	u32 offset;
-	u32 enable_bit;
-	u32 write_enable;
-};
-
-/**
- * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
- * @reg: the base address for usb3-phy config.
- * @typec_conn_dir: the register of type-c connector direction.
- * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
- * @external_psm: the register of type-c phy external psm clock.
- * @pipe_status: the register of type-c phy pipe status.
- * @usb3_host_disable: the register of type-c usb3 host disable.
- * @usb3_host_port: the register of type-c usb3 host port.
- * @uphy_dp_sel: the register of type-c phy DP select control.
- */
-struct rockchip_usb3phy_port_cfg {
-	unsigned int reg;
-	struct usb3phy_reg typec_conn_dir;
-	struct usb3phy_reg usb3tousb2_en;
-	struct usb3phy_reg external_psm;
-	struct usb3phy_reg pipe_status;
-	struct usb3phy_reg usb3_host_disable;
-	struct usb3phy_reg usb3_host_port;
-	struct usb3phy_reg uphy_dp_sel;
-};
-
-struct rockchip_typec_phy {
-	struct device *dev;
-	void __iomem *base;
-	struct extcon_dev *extcon;
-	struct regmap *grf_regs;
-	struct clk *clk_core;
-	struct clk *clk_ref;
-	struct reset_control *uphy_rst;
-	struct reset_control *pipe_rst;
-	struct reset_control *tcphy_rst;
-	const struct rockchip_usb3phy_port_cfg *port_cfgs;
-	/* mutex to protect access to individual PHYs */
-	struct mutex lock;
-
-	bool flip;
-	u8 mode;
-};
-
 struct phy_reg {
 	u16 value;
 	u32 addr;
diff --git a/include/soc/rockchip/rockchip_phy_typec.h b/include/soc/rockchip/rockchip_phy_typec.h
new file mode 100644
index 0000000..4afe039
--- /dev/null
+++ b/include/soc/rockchip/rockchip_phy_typec.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Author: Lin Huang <hl@rock-chips.com>
+ */
+
+#ifndef __SOC_ROCKCHIP_PHY_TYPEC_H
+#define __SOC_ROCKCHIP_PHY_TYPEC_H
+
+struct usb3phy_reg {
+	u32 offset;
+	u32 enable_bit;
+	u32 write_enable;
+};
+
+/**
+ * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
+ * @reg: the base address for usb3-phy config.
+ * @typec_conn_dir: the register of type-c connector direction.
+ * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
+ * @external_psm: the register of type-c phy external psm clock.
+ * @pipe_status: the register of type-c phy pipe status.
+ * @usb3_host_disable: the register of type-c usb3 host disable.
+ * @usb3_host_port: the register of type-c usb3 host port.
+ * @uphy_dp_sel: the register of type-c phy DP select control.
+ */
+struct rockchip_usb3phy_port_cfg {
+	unsigned int reg;
+	struct usb3phy_reg typec_conn_dir;
+	struct usb3phy_reg usb3tousb2_en;
+	struct usb3phy_reg external_psm;
+	struct usb3phy_reg pipe_status;
+	struct usb3phy_reg usb3_host_disable;
+	struct usb3phy_reg usb3_host_port;
+	struct usb3phy_reg uphy_dp_sel;
+};
+
+struct rockchip_typec_phy {
+	struct device *dev;
+	void __iomem *base;
+	struct extcon_dev *extcon;
+	struct regmap *grf_regs;
+	struct clk *clk_core;
+	struct clk *clk_ref;
+	struct reset_control *uphy_rst;
+	struct reset_control *pipe_rst;
+	struct reset_control *tcphy_rst;
+	const struct rockchip_usb3phy_port_cfg *port_cfgs;
+	/* mutex to protect access to individual PHYs */
+	struct mutex lock;
+	bool flip;
+	u8 mode;
+};
+
+#endif
-- 
2.7.4
