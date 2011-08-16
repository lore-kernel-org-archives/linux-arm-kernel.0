From: davidb@codeaurora.org (David Brown)
Date: Tue, 16 Aug 2011 10:52:16 -0700
Subject: [PATCH v2 4/4] ARM: msm: Describe MSM 8660 SURF FPGA registers in DT
In-Reply-To: <1313517136-27414-1-git-send-email-davidb@codeaurora.org>
References: <1313517136-27414-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1313517136-27414-5-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM 8660 SURF development board contains a register-accessible
FPGA.  By default, this FPGA configures the first UART in output-only
mode.  On this target, reconfigure this FPGA to enable the UART to be
bidirectional.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/boot/dts/msm8660-surf.dts |    5 +++
 arch/arm/mach-msm/board-msm8x60.c  |   48 +++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/msm8660-surf.dts
index 15ded0d..3591c94 100644
--- a/arch/arm/boot/dts/msm8660-surf.dts
+++ b/arch/arm/boot/dts/msm8660-surf.dts
@@ -21,4 +21,9 @@
 		      <0x19c00000 0x1000>;
 		interrupts = <195>;
 	};
+
+	qcom,fpga at 1d000000 {
+		compatible = "qcom,msm8660-surf-fpga";
+		reg = < 0x1d000000 0x1000 >;
+	};
 };
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 10fa8f6..db973bb 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -58,8 +58,51 @@ static void __init msm8x60_init_irq(void)
 	}
 }
 
+static void __init msm8660_surf_fpga_init(void *fpga_mem)
+{
+	/* Advanced mode */
+	writew(0xFFFF, fpga_mem + 0x15C);
+	/* FPGA_UART_SEL */
+	writew(0, fpga_mem + 0x172);
+	/* FPGA_GPIO_CONFIG_117 */
+	writew(1, fpga_mem + 0xEA);
+	/* FPGA_GPIO_CONFIG_118 */
+	writew(1, fpga_mem + 0xEC);
+	dmb();
+	iounmap(fpga_mem);
+}
+
+static void __init msm8660_surf_fpga_init_platform(void)
+{
+	/* 0x1D000000 now belongs to EBI2:CS3 i.e. USB ISP Controller */
+	void *fpga_mem = ioremap(0x1D000000, SZ_4K);
+	msm8660_surf_fpga_init(fpga_mem);
+}
+
+#ifdef CONFIG_OF
+static void __init msm8660_surf_fpga_init_dt(void)
+{
+	struct device_node *node;
+	void *fpga_mem;
+
+	node = of_find_compatible_node(NULL, NULL, "qcom,msm8660-surf-fpga");
+	if (!node)
+		return;
+
+	fpga_mem = of_iomap(node, 0);
+	of_node_put(node);
+	if (!fpga_mem) {
+		printk(KERN_ERR "%s: Can't map fpga registers\n", __func__);
+		return;
+	}
+
+	msm8660_surf_fpga_init(fpga_mem);
+}
+#endif
+
 static void __init msm8x60_init(void)
 {
+	msm8660_surf_fpga_init_platform();
 }
 
 #ifdef CONFIG_OF
@@ -81,10 +124,7 @@ static void __init msm8x60_dt_init(void)
 	if (node)
 		irq_domain_add_simple(node, GIC_SPI_START);
 
-	if (of_machine_is_compatible("qcom,msm8660-surf")) {
-		printk(KERN_INFO "Init surf UART registers\n");
-		msm8x60_init_uart12dm();
-	}
+	msm8660_surf_fpga_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			msm_auxdata_lookup, NULL);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
