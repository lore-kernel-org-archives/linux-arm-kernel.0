From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 7 Feb 2013 13:27:05 +0530
Subject: [PATCH v2 3/3] ARM: davinci: da850: add mmc DT entries
In-Reply-To: <1360223825-23929-1-git-send-email-prakash.pm@ti.com>
References: <1360223825-23929-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1360223825-23929-4-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT entry for MMC. Also add entry for pinmux information.
Tested on da850-evm without card detect and EDMA support as
DT support for GPIO and EDMA are yet come.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Cc: linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: devicetree-discuss at lists.ozlabs.org
Cc: cjb at laptop.org
Cc: Sekhar Nori <nsekhar@ti.com>
---
Since v1:
Removed bitfields for specifying the device capabilty and accomodate
controller revision in compatible field.

 arch/arm/boot/dts/da850-evm.dts |    9 +++++++++
 arch/arm/boot/dts/da850.dtsi    |   15 +++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index fa04152..78a6fb7 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -30,6 +30,15 @@
 		rtc0: rtc at 1c23000 {
 			status = "okay";
 		};
+		mmc0: mmc at 1c40000 {
+			max-frequency = <50000000>;
+			mmc-cap-sd-highspeed;
+			mmc-cap-mmc-highspeed;
+			bus-width = <4>;
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+		};
 	};
 	nand_cs3 at 62000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 099c81e..3ef9c22 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -56,6 +56,15 @@
 					0x30 0x01100000  0x0ff00000
 				>;
 			};
+			mmc0_pins: pinmux_mmc_pins {
+				pinctrl-single,bits = <
+					/* MMCSD0_DAT[3] MMCSD0_DAT[2]
+					 * MMCSD0_DAT[1] MMCSD0_DAT[0]
+					 * MMCSD0_CMD    MMCSD0_CLK
+					 */
+					0x28 0x00222222  0x00ffffff
+				>;
+			};
 		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
@@ -88,6 +97,12 @@
 				      19>;
 			status = "disabled";
 		};
+		mmc0: mmc at 1c40000 {
+			compatible = "ti,davinci-mmc-da830";
+			reg = <0x40000 0x1000>;
+			interrupts = <16>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.7.4.1
