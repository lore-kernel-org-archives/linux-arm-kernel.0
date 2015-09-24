From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 24 Sep 2015 17:23:52 +0200
Subject: [PATCH 1/3] Revert "ARM: dts: sun8i: Add new
 sun8i-a33-q8-tzx-723q4.dts file"
Message-ID: <1443108234-14837-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tzx-723q[a]4 board variant of A33 based Q8 formfactor tablets was
given its own dts file because the mmc would not work with a drive
strength of 30mA, Android seemed to be using a lower drive-strength
and doing the same with the upstream kernel seemed to fix this issue.

While working on a similar fix for u-boot I noticed that Android did
not use a lower drive strength for mmc0, but for mmc1, so mmc0 should
work fine with a drive strength of 30mA.

Further investigation has shown that Allwinner is using slightly
tweaked clock sample phase settings in newer Android kernels, and
that updating the mainstream sunxi mmc driver to these settings fixes
this.

With this fixed we no longer need a dts file specifically for these
pcb varants -> drop this dts file.

This reverts commit fb61c559a810f1487892b83d2d0606af1d020318.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                   |  1 -
 arch/arm/boot/dts/sun8i-a33-q8-tzx-723q4.dts | 70 ----------------------------
 2 files changed, 71 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sun8i-a33-q8-tzx-723q4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index df8e0b3..d3982e7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -637,7 +637,6 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-et-q8-v1.6.dtb \
 	sun8i-a33-ga10h-v1.1.dtb \
 	sun8i-a33-ippo-q8h-v1.2.dtb \
-	sun8i-a33-q8-tzx-723q4.dtb \
 	sun8i-a33-sinlinx-sina33.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a33-q8-tzx-723q4.dts b/arch/arm/boot/dts/sun8i-a33-q8-tzx-723q4.dts
deleted file mode 100644
index 04f396a..0000000
--- a/arch/arm/boot/dts/sun8i-a33-q8-tzx-723q4.dts
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-#include "sun8i-a33.dtsi"
-#include "sun8i-q8-common.dtsi"
-
-/ {
-	model = "Q8 TZX 723Q4 Quad Core Tablet";
-	compatible = "tzx,q8-tzx-723q4", "allwinner,sun8i-a33";
-};
-
-/* The TZX 723Q[a]4 PCB mmc only works properly with a lower drive-strenght */
-&mmc0_pins_a {
-	allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-};
-
-/*
- * FIXME for now we only support host mode and rely on u-boot to have
- * turned on Vbus which is controlled by the axp223 pmic on the board.
- *
- * Once we have axp223 support we should switch to fully supporting otg.
- */
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
-- 
2.5.0
