From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Jul 2017 13:23:11 +0200
Subject: [PATCH] ARM: dts: armada-38x: Fix irq type for pca955
Message-ID: <20170712112311.922-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As written in the datasheet the PCA955 can only handle low level irq and
not edge irq.

Without this fix the interrupt is not usable for pca955: the gpio-pca953x
driver already set the irq type as low level which is incompatible with
edge type, then the kernel prevents using the interrupt:

"irq: type mismatch, failed to map hwirq-18 for
/soc/internal-regs/gpio at 18100!"

Fixes: 928413bd859c ("ARM: mvebu: Add Armada 388 General Purpose
Development Board support")
Cc: stable at vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 895fa6cfa15a..563901e0ec07 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -75,7 +75,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pca0_pins>;
 					interrupt-parent = <&gpio0>;
-					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+					interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
 					gpio-controller;
 					#gpio-cells = <2>;
 					interrupt-controller;
@@ -87,7 +87,7 @@
 					compatible = "nxp,pca9555";
 					pinctrl-names = "default";
 					interrupt-parent = <&gpio0>;
-					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+					interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
 					gpio-controller;
 					#gpio-cells = <2>;
 					interrupt-controller;
-- 
2.13.2
