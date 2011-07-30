From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Jul 2011 02:53:19 +0800
Subject: [PATCH v2 1/3] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
References: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1312052001-16660-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds function mxc_iomuxc_dt_init() to parse iomuxc pad configuration
from device tree.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl/iomuxc.txt         |   47 +++++++++++++
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/iomuxc-dt.c                      |   70 ++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h            |    3 +
 4 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
 create mode 100644 arch/arm/mach-mx5/iomuxc-dt.c

diff --git a/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt b/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
new file mode 100644
index 0000000..ae9292b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
@@ -0,0 +1,47 @@
+* Freescale i.MX IOMUX Controller (IOMUXC)
+
+Required properties:
+- compatible : "fsl,<soc>-iomuxc";
+
+Sub-nodes present individual PAD configuration, and node name is the
+PAD name given by hardware document.
+
+Required properties:
+- reg : Should contain the offset of registers
+  IOMUXC_SW_MUX_CTL_PAD_<pad-name> and IOMUXC_SW_PAD_CTL_PAD_<pad-name>.
+- fsl,iomuxc-mux-mode : Should specify the MUX_MODE setting of register
+  IOMUXC_SW_MUX_CTL_PAD_<pad-name>.
+
+Optional properties:
+- fsl,iomuxc-sion : Indicates that bit SION of register
+  IOMUXC_SW_MUX_CTL_PAD_<pad-name> needs to be set for given MUX_MODE
+  setting of the PAD.
+- fsl,iomuxc-select-input : Specify the offset of register
+  IOMUXC_<...>_SELECT_INPUT and the value of bit-field DAISY for given
+  MUX_MODE setting of the PAD.
+
+Examples:
+
+iomuxc at 53fa8000 {
+	#address-cells = <2>;
+	#size-cells = <0>;
+	compatible = "fsl,imx53-iomuxc";
+	reg = <0x53fa8000 0x4000>;
+
+	/*
+	 * I2C2
+	 */
+	key-col3 { /* I2C2_SCL */
+		reg = <0x3c 0x364>;
+		fsl,iomuxc-mux-mode = <4>;
+		fsl,iomuxc-sion;
+		fsl,iomuxc-select-input = <0x81c 0x0>;
+	};
+
+	key-row3 { /* I2C2_SDA */
+		reg = <0x40 0x368>;
+		fsl,iomuxc-mux-mode = <4>;
+		fsl,iomuxc-sion;
+		fsl,iomuxc-select-input = <0x820 0x0>;
+	};
+};
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 383e7cd..71379f6 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
 obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
 obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
 obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
+
+obj-$(CONFIG_OF) += iomuxc-dt.o
diff --git a/arch/arm/mach-mx5/iomuxc-dt.c b/arch/arm/mach-mx5/iomuxc-dt.c
new file mode 100644
index 0000000..b974924
--- /dev/null
+++ b/arch/arm/mach-mx5/iomuxc-dt.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+
+#define IOMUXC_CONFIG_SION	(1 << 4)
+
+void mxc_iomuxc_dt_init(const struct of_device_id *match)
+{
+	struct device_node *node = of_find_matching_node(NULL, match);
+	struct device_node *child;
+	void __iomem *base;
+	u32 reg[2], select_input[2];
+	u32 mux_mode, pad_ctl;
+
+	if (!node)
+		return;
+
+	if (of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg))) {
+		pr_warn("%s: property 'reg' not found\n", __func__);
+		goto out;
+	}
+
+	base = ioremap(reg[0], reg[1]);
+	if (!base) {
+		pr_warn("%s: ioremap failed\n", __func__);
+		goto out;
+	}
+
+	for_each_child_of_node(node, child) {
+		/* get regsister offset of mux_ctl and pad_ctl */
+		if (of_property_read_u32_array(child, "reg", reg,
+					       ARRAY_SIZE(reg)))
+			continue;
+
+		/* set register mux_ctl */
+		if (of_property_read_u32(child, "fsl,iomuxc-mux-mode",
+					 &mux_mode))
+			continue;
+		if (of_get_property(child, "fsl,iomuxc-sion", NULL))
+			mux_mode |= IOMUXC_CONFIG_SION;
+		writel(mux_mode, base + reg[0]);
+
+		/* set register pad_ctl */
+		if (!of_property_read_u32(child, "fsl,iomuxc-pad-ctl",
+					  &pad_ctl))
+			writel(pad_ctl, base + reg[1]);
+
+		/* get offset/value pair and set select_input register */
+		if (!of_property_read_u32_array(child,
+				"fsl,iomuxc-select-input", select_input,
+				ARRAY_SIZE(select_input)))
+			writel(select_input[1], base + select_input[0]);
+	}
+
+	iounmap(base);
+
+out:
+	of_node_put(node);
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..12b7499 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -13,6 +13,7 @@
 
 struct platform_device;
 struct clk;
+struct of_device_id;
 
 extern void mx1_map_io(void);
 extern void mx21_map_io(void);
@@ -72,4 +73,6 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+
+extern void mxc_iomuxc_dt_init(const struct of_device_id *match);
 #endif
-- 
1.7.4.1
