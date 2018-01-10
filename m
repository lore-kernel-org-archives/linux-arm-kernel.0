From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Jan 2018 17:10:11 +0100
Subject: [PATCH] ARM: dts: s5pv210: add interrupt-parent for ohci
Message-ID: <20180110161045.4052684-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ohci-hcd node has an interrupt number but no interrupt-parent,
leading to a warning with current dtc versions:

arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000

As seen from the related exynos dts files, the ohci and ehci controllers
always share one interrupt number, and the number is the same here as
well, so setting the same interrupt-parent is the reasonable solution
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/s5pv210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 247c0029659c..67358562a6ea 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -460,6 +460,7 @@
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0xec300000 0x100>;
 			interrupts = <23>;
+			interrupt-parent = <&vic1>;
 			clocks = <&clocks CLK_USB_HOST>;
 			clock-names = "usbhost";
 			#address-cells = <1>;
-- 
2.9.0
