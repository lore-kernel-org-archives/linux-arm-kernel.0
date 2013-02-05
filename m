From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  5 Feb 2013 20:55:14 +0100
Subject: [PATCH v5 2/3] arm: kirkwood: Instantiate cpufreq driver
In-Reply-To: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
References: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
Message-ID: <1360094115-14999-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register a platform driver structure for the cpufreq driver.
Add a DT binding for cpus/cpu at 0 with the needed clocks.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/Kconfig                                  |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                   |   13 ++++++++++++
 arch/arm/mach-kirkwood/board-dt.c                 |    2 ++
 arch/arm/mach-kirkwood/common.c                   |   23 +++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h                   |    2 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 ++
 6 files changed, 43 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..830975b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -543,6 +543,7 @@ config ARCH_DOVE
 
 config ARCH_KIRKWOOD
 	bool "Marvell Kirkwood"
+	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index d6ab442..fc86ddd 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -8,6 +8,19 @@
 	       gpio0 = &gpio0;
 	       gpio1 = &gpio1;
 	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+		      device_type = "cpu";
+		      compatible = "marvell,sheeva-88SV131";
+		      clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
+		      clock-names = "cpu_clk", "ddrclk", "powersave";
+		};
+	};
+
 	intc: interrupt-controller {
 		compatible = "marvell,orion-intc", "marvell,intc";
 		interrupt-controller;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index de4fd2b..951d96d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -95,6 +95,8 @@ static void __init kirkwood_dt_init(void)
 
 	kirkwood_l2_init();
 
+	kirkwood_cpufreq_init();
+
 	/* Setup root of clk tree */
 	kirkwood_of_clk_init();
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index bac21a5..a3dc21c 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -584,6 +584,29 @@ void __init kirkwood_audio_init(void)
 }
 
 /*****************************************************************************
+ * CPU Frequency
+ ****************************************************************************/
+static struct resource kirkwood_cpufreq_resources[] = {
+	[0] = {
+		.start  = CPU_CONTROL_PHYS,
+		.end    = CPU_CONTROL_PHYS + 3,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device kirkwood_cpufreq_device = {
+	.name		= "kirkwood-cpufreq",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(kirkwood_cpufreq_resources),
+	.resource	= kirkwood_cpufreq_resources,
+};
+
+void __init kirkwood_cpufreq_init(void)
+{
+	platform_device_register(&kirkwood_cpufreq_device);
+}
+
+/*****************************************************************************
  * General
  ****************************************************************************/
 /*
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 5ffa57f..9ede04b 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -50,6 +50,8 @@ void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
 void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
 			    int (*dev_ready)(struct mtd_info *));
 void kirkwood_audio_init(void);
+void kirkwood_cpufreq_init(void);
+
 void kirkwood_restart(char, const char *);
 void kirkwood_clk_init(void);
 
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 5c82b7d..d4cbe5e 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -17,6 +17,7 @@
 #define CPU_CONFIG_ERROR_PROP	0x00000004
 
 #define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
+#define CPU_CONTROL_PHYS	(BRIDGE_PHYS_BASE + 0x0104)
 #define CPU_RESET		0x00000002
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
@@ -69,6 +70,7 @@
 #define CGC_RUNIT		(1 << 7)
 #define CGC_XOR0		(1 << 8)
 #define CGC_AUDIO		(1 << 9)
+#define CGC_POWERSAVE           (1 << 11)
 #define CGC_SATA0		(1 << 14)
 #define CGC_SATA1		(1 << 15)
 #define CGC_XOR1		(1 << 16)
-- 
1.7.10.4
