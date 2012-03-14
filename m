From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:05:02 +0000
Subject: [PATCH 06/10] ARM: ux500: Enable Cortex-A9 GIC (Generic Interrupt
 Controller) in Device Tree
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the embedded GIC on all u8500 based hardware using DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   11 +++++++++++
 arch/arm/mach-ux500/cpu.c     |   12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 0521cea..cce5df8 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -16,8 +16,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "stericsson,db8500";
+		interrupt-parent = <&intc>;
 		ranges;
 
+		intc: interrupt-controller at a0411000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			interrupt-parent;
+			reg = <0xa0411000 0x1000>,
+			      <0xa0410100 0x100>;
+		};
+
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
 			interrupts = <7>;
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 055fb6e..bd7f1dd 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
@@ -29,6 +31,11 @@
 
 void __iomem *_PRCMU_BASE;
 
+static const struct of_device_id ux500_dt_irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{},
+};
+
 void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
@@ -43,7 +50,10 @@ void __init ux500_init_irq(void)
 	} else
 		ux500_unknown_soc();
 
-	gic_init(0, 29, dist_base, cpu_base);
+	if (of_have_populated_dt())
+		of_irq_init(ux500_dt_irq_match);
+	else
+		gic_init(0, 29, dist_base, cpu_base);
 
 	/*
 	 * Init clocks here so that they are available for system timer
-- 
1.7.5.4
