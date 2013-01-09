From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  9 Jan 2013 18:17:15 +0100
Subject: [RFC PATCH 1/5] ARM i.MX6q: Add GPU, VPU, IPU,
 and OpenVG resets to system reset controller
In-Reply-To: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1357751839-19680-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   45 ++++++++++++++++++++
 arch/arm/mach-imx/src.c                            |   41 ++++++++++++++++++
 include/linux/imx-src.h                            |    6 +++
 3 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
 create mode 100644 include/linux/imx-src.h

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
new file mode 100644
index 0000000..8f1e66a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
@@ -0,0 +1,45 @@
+Freescale i.MX System Reset Controller
+======================================
+
+Required properties:
+- compatible: Should be "fsl,<chip>-src"
+- reg: should be register base and length as documented in the
+  datasheet
+- interrupts: Should contain SRC interrupt and CPU WDOG interrupt,
+  in this order.
+- #reset-cells: 1, see below
+
+example:
+
+src: src at 020d8000 {
+        compatible = "fsl,imx6q-src";
+        reg = <0x020d8000 0x4000>;
+        interrupts = <0 91 0x04 0 96 0x04>;
+        #reset-cells = <1>;
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+The system reset controller can be used to reset the GPU, VPU,
+IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
+nodes should specify the reset line on the SRC in their reset
+property, containing a phandle to the SRC device node and a
+RESET_INDEX specifying which module to reset.
+
+example:
+
+        ipu0: ipu0 {
+                reset = <&src 2>;
+        };
+        ipu1: ipu1 {
+                reset = <&src 4>;
+        };
+
+The following RESET_INDEX values are valid for i.MX5:
+GPU_RESET     0
+VPU_RESET     1
+IPU1_RESET    2
+OPEN_VG_RESET 3
+The following additional RESET_INDEX value is valid for i.MX6:
+IPU2_RESET    4
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index e15f155..10658b4 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -20,11 +20,52 @@
 #define SRC_SCR				0x000
 #define SRC_GPR1			0x020
 #define BP_SRC_SCR_WARM_RESET_ENABLE	0
+#define BP_SRC_SCR_SW_GPU_RST		1
+#define BP_SRC_SCR_SW_VPU_RST		2
+#define BP_SRC_SCR_SW_IPU1_RST		3
+#define BP_SRC_SCR_SW_OPEN_VG_RST	4
+#define BP_SRC_SCR_SW_IPU2_RST		12
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
 static void __iomem *src_base;
 
+static int sw_reset_bits[5] = {
+	BP_SRC_SCR_SW_GPU_RST,
+	BP_SRC_SCR_SW_VPU_RST,
+	BP_SRC_SCR_SW_IPU1_RST,
+	BP_SRC_SCR_SW_OPEN_VG_RST,
+	BP_SRC_SCR_SW_IPU2_RST
+};
+
+int imx_src_reset(int sw_reset_idx)
+{
+	unsigned long timeout;
+	int bit;
+	u32 val;
+
+	if (!src_base)
+		return -ENODEV;
+
+	if (sw_reset_idx >= ARRAY_SIZE(sw_reset_bits))
+		return -EINVAL;
+
+	bit = 1 << sw_reset_bits[sw_reset_idx];
+
+	val = readl_relaxed(src_base + SRC_SCR);
+	val |= bit;
+	writel_relaxed(val, src_base + SRC_SCR);
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (readl(src_base + SRC_SCR) & bit) {
+		if (time_after(jiffies, timeout))
+			return -ETIME;
+		cpu_relax();
+	}
+
+	return 0;
+}
+
 void imx_enable_cpu(int cpu, bool enable)
 {
 	u32 mask, val;
diff --git a/include/linux/imx-src.h b/include/linux/imx-src.h
new file mode 100644
index 0000000..b93ed96
--- /dev/null
+++ b/include/linux/imx-src.h
@@ -0,0 +1,6 @@
+#ifndef __IMX_SRC_H__
+#define __IMX_SRC_H__
+
+extern int imx_src_reset(int sw_reset_idx);
+
+#endif /* __IMX_SRC_H__ */
-- 
1.7.10.4
