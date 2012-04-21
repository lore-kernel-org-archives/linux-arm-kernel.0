From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:45:56 +0530
Subject: [PATCH V2 01/10] SPEAr: Add DT bindings for SPEAr's timer
In-Reply-To: <cover.1335010373.git.viresh.kumar@st.com>
References: <cover.1335010373.git.viresh.kumar@st.com>
Message-ID: <108eff2da29b7da76b536799a0529804e9dadbe2.1335010373.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SPEAr SoC's use ST's Timer module. This patch adds device tree probing
capability for that.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 .../devicetree/bindings/arm/spear-timer.txt        |   18 +++++++++++
 arch/arm/boot/dts/spear3xx.dtsi                    |    6 ++++
 arch/arm/boot/dts/spear600.dtsi                    |    6 ++++
 arch/arm/mach-spear3xx/include/mach/generic.h      |    2 +-
 arch/arm/mach-spear3xx/include/mach/irqs.h         |    1 -
 arch/arm/mach-spear3xx/include/mach/spear.h        |    1 -
 arch/arm/mach-spear3xx/spear3xx.c                  |    2 +-
 arch/arm/mach-spear6xx/include/mach/generic.h      |    2 +-
 arch/arm/mach-spear6xx/include/mach/irqs.h         |    3 --
 arch/arm/mach-spear6xx/include/mach/spear.h        |    1 -
 arch/arm/mach-spear6xx/spear6xx.c                  |    2 +-
 arch/arm/plat-spear/time.c                         |   31 ++++++++++++++------
 12 files changed, 56 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear-timer.txt

diff --git a/Documentation/devicetree/bindings/arm/spear-timer.txt b/Documentation/devicetree/bindings/arm/spear-timer.txt
new file mode 100644
index 0000000..c001722
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear-timer.txt
@@ -0,0 +1,18 @@
+* SPEAr ARM Timer
+
+** Timer node required properties:
+
+- compatible : Should be:
+	"st,spear-timer"
+- reg: Address range of the timer registers
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupt: Should contain the timer interrupt number
+
+Example:
+
+	timer at f0000000 {
+		compatible = "st,spear-timer";
+		reg = <0xf0000000 0x400>;
+		interrupts = <2>;
+	};
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
index 0ae7c8e..9107255 100644
--- a/arch/arm/boot/dts/spear3xx.dtsi
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -139,6 +139,12 @@
 				interrupts = <12>;
 				status = "disabled";
 			};
+
+			timer at f0000000 {
+				compatible = "st,spear-timer";
+				reg = <0xf0000000 0x400>;
+				interrupts = <2>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index d777e3a..089f0a4 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -177,6 +177,12 @@
 				interrupts = <28>;
 				status = "disabled";
 			};
+
+			timer at f0000000 {
+				compatible = "st,spear-timer";
+				reg = <0xf0000000 0x400>;
+				interrupts = <16>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 278646b..e065217 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -27,7 +27,7 @@ extern struct pl022_ssp_controller pl022_plat_data;
 extern struct pl08x_platform_data pl080_plat_data;
 
 /* Add spear3xx family function declarations here */
-void __init spear_setup_timer(resource_size_t base, int irq);
+void __init spear_setup_of_timer(void);
 void __init spear3xx_clk_init(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_dt_init_irq(void);
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index 319620a..51bd62a 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -16,7 +16,6 @@
 
 /* FIXME: probe all these from DT */
 #define SPEAR3XX_IRQ_INTRCOMM_RAS_ARM		1
-#define SPEAR3XX_IRQ_CPU_GPT1_1			2
 #define SPEAR3XX_IRQ_GEN_RAS_1			28
 #define SPEAR3XX_IRQ_GEN_RAS_2			29
 #define SPEAR3XX_IRQ_GEN_RAS_3			30
diff --git a/arch/arm/mach-spear3xx/include/mach/spear.h b/arch/arm/mach-spear3xx/include/mach/spear.h
index c5a16f9..51eb953 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear.h
@@ -26,7 +26,6 @@
 /* ML1 - Multi Layer CPU Subsystem */
 #define SPEAR3XX_ICM3_ML1_2_BASE	UL(0xF0000000)
 #define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
-#define SPEAR3XX_CPU_TMR_BASE		UL(0xF0000000)
 
 /* ICM3 - Basic Subsystem */
 #define SPEAR3XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 2b26fc5..f22419e 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -111,7 +111,7 @@ static void __init spear3xx_timer_init(void)
 	clk_put(gpt_clk);
 	clk_put(pclk);
 
-	spear_setup_timer(SPEAR3XX_CPU_TMR_BASE, SPEAR3XX_IRQ_CPU_GPT1_1);
+	spear_setup_of_timer();
 }
 
 struct sys_timer spear3xx_timer = {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 7167fd3..65514b1 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -16,7 +16,7 @@
 
 #include <linux/init.h>
 
-void __init spear_setup_timer(resource_size_t base, int irq);
+void __init spear_setup_of_timer(void);
 void spear_restart(char, const char *);
 void __init spear6xx_clk_init(void);
 
diff --git a/arch/arm/mach-spear6xx/include/mach/irqs.h b/arch/arm/mach-spear6xx/include/mach/irqs.h
index 2b73538..37a5c41 100644
--- a/arch/arm/mach-spear6xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear6xx/include/mach/irqs.h
@@ -16,9 +16,6 @@
 
 /* IRQ definitions */
 /* VIC 1 */
-/* FIXME: probe this from DT */
-#define IRQ_CPU_GPT1_1				16
-
 #define IRQ_VIC_END				64
 
 /* GPIO pins virtual irqs */
diff --git a/arch/arm/mach-spear6xx/include/mach/spear.h b/arch/arm/mach-spear6xx/include/mach/spear.h
index d278ed0..cb8ed2f 100644
--- a/arch/arm/mach-spear6xx/include/mach/spear.h
+++ b/arch/arm/mach-spear6xx/include/mach/spear.h
@@ -25,7 +25,6 @@
 /* ML-1, 2 - Multi Layer CPU Subsystem */
 #define SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
 #define VA_SPEAR6XX_ML_CPU_BASE		UL(0xF0000000)
-#define SPEAR6XX_CPU_TMR_BASE		UL(0xF0000000)
 
 /* ICM3 - Basic Subsystem */
 #define SPEAR6XX_ICM3_SMI_CTRL_BASE	UL(0xFC000000)
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index d74bec1..2e2e359 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -447,7 +447,7 @@ static void __init spear6xx_timer_init(void)
 	clk_put(gpt_clk);
 	clk_put(pclk);
 
-	spear_setup_timer(SPEAR6XX_CPU_TMR_BASE, IRQ_CPU_GPT1_1);
+	spear_setup_of_timer();
 }
 
 struct sys_timer spear6xx_timer = {
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index 4f05d26..03321af 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -18,6 +18,8 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <linux/time.h>
 #include <linux/irq.h>
 #include <asm/mach/time.h>
@@ -197,19 +199,32 @@ static void __init spear_clockevent_init(int irq)
 	setup_irq(irq, &spear_timer_irq);
 }
 
-void __init spear_setup_timer(resource_size_t base, int irq)
+const static struct of_device_id timer_of_match[] __initconst = {
+	{ .compatible = "st,spear-timer", },
+	{ },
+};
+
+void __init spear_setup_of_timer(void)
 {
-	int ret;
+	struct device_node *np;
+	int irq, ret;
+
+	np = of_find_matching_node(NULL, timer_of_match);
+	if (!np) {
+		pr_err("%s: No timer passed via DT\n", __func__);
+		return;
+	}
 
-	if (!request_mem_region(base, SZ_1K, "gpt0")) {
-		pr_err("%s:cannot get IO addr\n", __func__);
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("%s: No irq passed for timer via DT\n", __func__);
 		return;
 	}
 
-	gpt_base = ioremap(base, SZ_1K);
+	gpt_base = of_iomap(np, 0);
 	if (!gpt_base) {
-		pr_err("%s:ioremap failed for gpt\n", __func__);
-		goto err_mem;
+		pr_err("%s: of iomap failed\n", __func__);
+		return;
 	}
 
 	gpt_clk = clk_get_sys("gpt0", NULL);
@@ -233,6 +248,4 @@ err_prepare_enable_clk:
 	clk_put(gpt_clk);
 err_iomap:
 	iounmap(gpt_base);
-err_mem:
-	release_mem_region(base, SZ_1K);
 }
-- 
1.7.9
