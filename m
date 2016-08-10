From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 10 Aug 2016 11:00:32 +0000
Subject: [PATCH v2 4/4] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <20160810110032.29295-1-kbeldan@baylibre.com>
References: <20160810110032.29295-1-kbeldan@baylibre.com>
Message-ID: <20160810110032.29295-5-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DT support for the NAND connected to the SoC AEMIF.
The parameters (timings, ecc) are the same as what the board ships with
(default AEMIF timings, 1bit ECC) and improvements will be handled in
due course.
This passed elementary tests hashing a 20MB file on top of ubifs on my
LCDK.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 107 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index dbcca0b..a3f9845 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -27,6 +27,27 @@
 
 &pmx_core {
 	status = "okay";
+
+	nand_pins: nand_pins {
+		pinctrl-single,bits = <
+			/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[3] */
+			0x1c 0x10110010  0xf0ff00f0
+			/*
+			 * EMA_D[0], EMA_D[1], EMA_D[2],
+			 * EMA_D[3], EMA_D[4], EMA_D[5],
+			 * EMA_D[6], EMA_D[7]
+			 */
+			0x24 0x11111111  0xffffffff
+			/*
+			 * EMA_D[8],  EMA_D[9],  EMA_D[10],
+			 * EMA_D[11], EMA_D[12], EMA_D[13],
+			 * EMA_D[14], EMA_D[15]
+			 */
+			0x20 0x11111111  0xffffffff
+			/* EMA_A[1], EMA_A[2] */
+			0x30 0x01100000  0x0ff00000
+		>;
+	};
 };
 
 &serial2 {
@@ -68,3 +89,89 @@
 	cd-gpios = <&gpio 64 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
+
+&aemif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins>;
+	status = "ok";
+	cs3 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		clock-ranges;
+		ranges;
+
+		ti,cs-chipselect = <3>;
+
+		nand at 2000000,0 {
+			compatible = "ti,davinci-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0 0x02000000 0x02000000
+			       1 0x00000000 0x00008000>;
+
+			ti,davinci-chipselect = <1>;
+			ti,davinci-mask-ale = <0>;
+			ti,davinci-mask-cle = <0>;
+			ti,davinci-mask-chipsel = <0>;
+
+			/*
+			 * nand_ecc_strength_good will emit a warning
+			 * but the LCDK ships with these settings [1].
+			 * Also HW 4bits ECC with 16bits NAND seems to
+			 * require some attention.
+			 *
+			 * ATM nand_davinci_probe handling of nand-ecc-*
+			 * is broken, e.g.
+			 * chip.ecc.strength = pdata->ecc_bits occurs after
+			 * scan_ident(), otherwise I would have used:
+			 * 	nand-ecc-mode = "hw";
+			 * 	nand-ecc-strength = <1>;
+			 * 	nand-ecc-step-size = <512>;
+			 */
+			ti,davinci-nand-buswidth = <16>;
+			ti,davinci-ecc-mode = "hw";
+			ti,davinci-ecc-bits = <1>;
+			ti,davinci-nand-use-bbt;
+
+			/*
+			 * LCDK original partitions:
+			 * 0x000000000000-0x000000020000 : "u-boot env"
+			 * 0x000000020000-0x0000000a0000 : "u-boot"
+			 * 0x0000000a0000-0x0000002a0000 : "kernel"
+			 * 0x0000002a0000-0x000020000000 : "filesystem"
+			 *
+			 * The 1st NAND block being guaranted to be valid w/o ECC (> 1k cycles),
+			 * it makes a perfect candidate as an SPL for the BootROM to jump to.
+			 * However the OMAP-L132/L138 Bootloader doc SPRAB41E reads:
+			 * "To boot from NAND Flash, the AIS should be written to NAND block 1
+			 * (NAND block 0 is not used by default)", which matches the LCDK
+			 * original partitioning.
+			 * Also, the LCDK ships with only the u-boot partition provisioned and
+			 * boots on it in its default configuration while using the MMC for the
+			 * kernel and rootfs, so preserve that one as is for now.
+			 * [1]: Ensuring for example that U-Boot LCDK SPL can handle it properly
+			 * and a proper boot chain ROM->SPL->U-Boot->Linux wrt ECC, would allow
+			 * for a better partitioning.
+			 */
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition at 0 {
+					label = "u-boot env";
+					reg = <0 0x020000>;
+				};
+				partition at 0x020000 {
+					/* The LCDK defaults to booting from this partition */
+					label = "u-boot";
+					reg = <0x020000 0x080000>;
+				};
+				partition at 0x0a0000 {
+					label = "space";
+					reg = <0x0a0000 0>;
+				};
+			};
+		};
+	};
+};
-- 
2.9.2
