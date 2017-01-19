From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 19 Jan 2017 12:44:27 +0000
Subject: [PATCH] ARM: dts: fix SolidRun iMX6 platforms
Message-ID: <E1cUC4p-00087z-NF@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removal of skeleton.dtsi from imx6qdl.dtsi caused a regression on
SolidRun platforms as the /chosen and /memory nodes are no longer
populated.  Fix this by adding the nodes into the platform .dtsi
files.

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.10.0-rc3+ (rmk at rmk-PC.arm.linux.org.uk) (gcc version 4.7.4 (GCC) ) #2066 SMP Thu Jan 19 12:31:19 GMT 2017
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt:Machine model: SolidRun Cubox-i Dual/Quad
INITRD: 0x20000000+0x001cd000 is not a memory region - disabling initrd
cma: Failed to reserve 256 MiB
Memory policy: Data cache writealloc
Kernel panic - not syncing: ERROR: Failed to allocate 0x2000 bytes below 0x0.

CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.0-rc3+ #2066
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace: invalid frame pointer 0xc09e5e44c
---[ end Kernel panic - not syncing: ERROR: Failed to allocate 0x2000 bytes below 0x0.

Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi      | 6 ++++++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index ff41f83551de..69e3a848ee74 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -44,6 +44,12 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory { device_type = "memory"; reg = <0 0>; };
+
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 9 1>;
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index a5e5356cdc6a..ae2feb882193 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -46,6 +46,8 @@
 		stdout-path = &uart1;
 	};
 
+	memory { device_type = "memory"; reg = <0 0>; };
+
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
-- 
2.7.4
