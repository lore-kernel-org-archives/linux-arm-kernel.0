From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Apr 2013 19:19:41 +0800
Subject: [PATCH V3 1/3] ARM: tegra: get PMC clock source from DT
In-Reply-To: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
References: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364901583-24867-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the bindings of the clock source of PMC in DT. And getting
the clock from DT.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* add binding document for the clock source of PMC
* get the clock from DT by of_get_clk_by_name()
* fix WARN_ON_ONCE to WARN_ON when there is no clock define in DT
V2:
* new in this series
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 23 ++++++++++++++++++++++
 arch/arm/mach-tegra/common.c                       |  2 +-
 arch/arm/mach-tegra/pmc.c                          |  4 ++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index b5846e2..1cb8f6b 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -9,11 +9,34 @@ Properties:
   signal is fed into the PMC. This signal is optionally inverted, and then
   fed into the ARM GIC. The PMC is not involved in the detection or
   handling of this interrupt signal, merely its inversion.
+- clocks : the source clock of PMC
+- clock-names : the name of source clock of PMC
 
 Example:
 
+/ SoC dts including file
 pmc at 7000f400 {
 	compatible = "nvidia,tegra20-pmc";
 	reg = <0x7000e400 0x400>;
 	nvidia,invert-interrupt;
+	clocks = <&tegra_car 110>, <&clk32k_in>;
+	clock-names = "pclk", "clk32k_in";
 };
+
+/ Tegra board dts file
+{
+	...
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock at 0 {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+	...
+}
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index f0315c9..b02ebe7 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -61,6 +61,7 @@ u32 tegra_uart_config[4] = {
 void __init tegra_dt_init_irq(void)
 {
 	tegra_clocks_init();
+	tegra_pmc_init();
 	tegra_init_irq();
 	irqchip_init();
 }
@@ -100,7 +101,6 @@ void __init tegra_init_early(void)
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra_init_cache();
-	tegra_pmc_init();
 	tegra_powergate_init();
 	tegra_hotplug_init();
 }
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index b30e921..dbe2577 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/clk.h>
 
 #define PMC_CTRL			0x0
 #define PMC_CTRL_INTR_LOW		(1 << 17)
@@ -43,6 +44,7 @@ static DEFINE_SPINLOCK(tegra_powergate_lock);
 
 static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
+static struct clk *tegra_pclk;
 
 static inline u32 tegra_pmc_readl(u32 reg)
 {
@@ -151,6 +153,8 @@ static void tegra_pmc_parse_dt(void)
 
 	tegra_pmc_invert_interrupt = of_property_read_bool(np,
 				     "nvidia,invert-interrupt");
+	tegra_pclk = of_clk_get_by_name(np, "pclk");
+	WARN_ON(IS_ERR(tegra_pclk));
 }
 
 void __init tegra_pmc_init(void)
-- 
1.8.2
