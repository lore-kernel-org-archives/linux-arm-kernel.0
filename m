From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 19 May 2013 00:47:39 +0200
Subject: [PATCH] ARM: nomadik: fix IRQ assignment for SMC ethernet
Message-ID: <1368917259-7883-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The assignment of IRQ for the SMC91x ethernet adapter had two
problems making it non-working:

- It was not put into the ethernet device node. Let's do this
  by using the board-specific overlay, so we can make other
  overlays on other Nomadik boards.

- The IRQ number was actually completely wrong, this was the
  number for NHK8815, not S8815.

After this ethernet starts working on the USB S8815.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: I would appreciate if you apply this patch
directly for v3.10 fixes.
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index b28fbf3..6f82d93 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -14,13 +14,19 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
 	};
 
+	/* This is where the interrupt is routed on the S8815 board */
+	external-bus at 34000000 {
+		ethernet at 300 {
+			interrupt-parent = <&gpio3>;
+			interrupts = <8 0x1>;
+		};
+	};
+
 	/* Custom board node with GPIO pins to active etc */
 	usb-s8815 {
 		/* The S8815 is using this very GPIO pin for the SMSC91x IRQs */
 		ethernet-gpio {
-			gpios = <&gpio3 19 0x1>;
-			interrupts = <19 0x1>;
-			interrupt-parent = <&gpio3>;
+			gpios = <&gpio3 8 0x1>;
 		};
 		/* This will bias the MMC/SD card detect line */
 		mmcsd-gpio {
-- 
1.8.1.4
