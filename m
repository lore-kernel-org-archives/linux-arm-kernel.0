From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 12:20:15 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
Message-ID: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Juno motherboard has a NOR flash on the motherboard, enable
this to be accessed with the CFI flash driver. Results after
enabling MTD, MTD_CFI, MTD_PHYSMAP, MTD_PHYSMAP_OF,
MTD_CFI_INTELEXT:

8000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank.
Manufacturer ID 0x000089 Chip ID 0x008919
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x40000,blocks=255
erase region 1: offset=0x3fc0000,size=0x10000,blocks=4

Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for -next if
people are OK with it, as I have no other Juno patches
pending for now.
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 637e046f0e36..c7c99a42e2e9 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -103,6 +103,14 @@
 				};
 			};
 
+			flash at 0,00000000 {
+				/* 2 * 32MiB NOR Flash memory mounted on CS0 */
+				compatible = "arm,vexpress-flash", "cfi-flash";
+				linux,part-probe = "afs";
+				reg = <0 0x00000000 0x04000000>;
+				bank-width = <4>;
+			};
+
 			ethernet at 2,00000000 {
 				compatible = "smsc,lan9118", "smsc,lan9115";
 				reg = <2 0x00000000 0x10000>;
-- 
2.4.3
