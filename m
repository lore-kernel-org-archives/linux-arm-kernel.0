From: peda@axentia.se (Peter Rosin)
Date: Thu, 18 Jan 2018 12:46:14 +0100
Subject: [PATCH v2 1/3] ARM: dts: at91: nattis: use up-to-date mtd partitions
In-Reply-To: <20180118114616.6639-1-peda@axentia.se>
References: <20180118114616.6639-1-peda@axentia.se>
Message-ID: <20180118114616.6639-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nattis currently relies on the cmdline to correctly configure the
MTD partition table, and the one given in the device tree is simply
ignored. Which is fortunate, since the device tree partition table is
bonkers and does not match reality.

So, in order to avoid confusion, fix the device tree partition table
to match what is expected (i.e. what is normally provided on the cmdline).
In particular, the rootfs partition should be mtd6.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 3ea1d26e1c68..03683c1b4240 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -216,29 +216,34 @@
 			reg = <0x0 0x40000>;
 		};
 
-		bootloader at 40000 {
-			label = "bootloader";
-			reg = <0x40000 0x80000>;
+		barebox at 40000 {
+			label = "barebox";
+			reg = <0x40000 0x60000>;
 		};
 
-		bootloaderenv at c0000 {
-			label = "bootloader env";
-			reg = <0xc0000 0xc0000>;
+		bareboxenv at c0000 {
+			label = "bareboxenv";
+			reg = <0xc0000 0x40000>;
 		};
 
-		dtb at 180000 {
-			label = "device tree";
-			reg = <0x180000 0x80000>;
+		bareboxenv2 at 100000 {
+			label = "bareboxenv2";
+			reg = <0x100000 0x40000>;
+		};
+
+		oftree at 180000 {
+			label = "oftree";
+			reg = <0x180000 0x20000>;
 		};
 
 		kernel at 200000 {
 			label = "kernel";
-			reg = <0x200000 0x600000>;
+			reg = <0x200000 0x500000>;
 		};
 
 		rootfs at 800000 {
 			label = "rootfs";
-			reg = <0x800000 0x0f800000>;
+			reg = <0x800000 0x1f800000>;
 		};
 	};
 };
-- 
2.11.0
