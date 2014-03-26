From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 26 Mar 2014 11:07:09 +0100
Subject: [PATCH v2] ARM: dts: exynos4210-trats: add max8997 IRQ
Message-ID: <1395828429-11023-1-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds IRQ line specification for the MAX8997 chip and necessary
pinctrl group to configure pull-up and driver strength of the pin.
It's needed for proper handling of IRQs coming from MAX8997 multifunction
device (IRQs are used by PMIC, MUIC and RTC).

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---

Changelog:

v2:
- Corrected commit message.

v1: https://lkml.org/lkml/2014/3/14/124

 arch/arm/boot/dts/exynos4210-trats.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 662b482..5629eef 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -156,6 +156,14 @@
 		};
 	};
 
+	pinctrl at 11000000 {
+		max8997_irq: max8997-irq {
+			samsung,pins = "gpx0-7";
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+	};
+
 	i2c at 13890000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
@@ -187,6 +195,11 @@
 		max8997_pmic at 66 {
 			compatible = "maxim,max8997-pmic";
 
+			pinctrl-0 = <&max8997_irq>;
+			pinctrl-names = "default";
+
+			interrupt-parent = <&gpx0>;
+			interrupts = <7 0>;
 			reg = <0x66>;
 
 			max8997,pmic-buck1-uses-gpio-dvs;
-- 
1.7.9.5
