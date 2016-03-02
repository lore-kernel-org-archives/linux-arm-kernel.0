From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  2 Mar 2016 03:34:55 +0100
Subject: [PATCH v2 0/6] ARM64: meson: GXBaby (S905) and Vega S95 enablement
Message-ID: <1456886101-22967-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for the Amlogic S905 based
Tronsmart Vega S95 Pro, Meta and Telos TV boxes.

v2:
* Pick up previously acked "tronsmart" patch instead (Matthias)
* Drop ARM_GIC selection (Sudeep)
* Change some compatible strings (Sudeep, Andr?)
* Squash some node changes/additions

Note: On the Vega S95 I need to change TEXT_OFFSET as follows,
in order to avoid the vendor U-Boot overwriting itself (fwiu);
for the Mini Mx that's reportedly not necessary.

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 354d75402ace..b7cebdb8b1ce 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -62,7 +62,7 @@ head-y                := arch/arm64/kernel/head.o
 ifeq ($(CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET), y)
 TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%03x000\n", int(512 * rand())}')
 else
-TEXT_OFFSET := 0x00080000
+TEXT_OFFSET := 0x01080000
 endif
 
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)

This in turn runs into an apparent regression introduced with the
text offset randomization:

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6ebd204da16a..afdec27c8871 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -48,7 +48,7 @@
 #elif (PAGE_OFFSET & 0x1fffff) != 0
 #error PAGE_OFFSET must be@least 2MB aligned
 #elif TEXT_OFFSET > 0x1fffff
-#error TEXT_OFFSET must be less than 2MB
+//#error TEXT_OFFSET must be less than 2MB
 #endif
 
 #define KERNEL_START   _text

https://en.opensuse.org/HCL:VegaS95

https://github.com/afaerber/linux/commits/vegas95-next

Regards,
Andreas

Cc: Andr? Przywara <andre.przywara@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree at vger.kernel.org

Andreas F?rber (5):
  ARM64: Enable Amlogic Meson GXBaby platform
  Documentation: devicetree: amlogic: Document Meson GXBaby
  ARM64: dts: Prepare configs for Amlogic Meson GXBaby
  Documentation: devicetree: amlogic: Document Tronsmart Vega S95 boards
  ARM64: dts: amlogic: Add Tronsmart Vega S95 configs

Matthias Brugger (1):
  devicetree: bindings: Add vendor prefix for Tronsmart

 Documentation/devicetree/bindings/arm/amlogic.txt  |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   7 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  55 +++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  55 +++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  55 +++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  55 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 183 +++++++++++++++++++++
 10 files changed, 424 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/Makefile
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi

-- 
2.6.2
