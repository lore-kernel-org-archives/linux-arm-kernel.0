From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 Jan 2017 10:55:40 +0100
Subject: [RESEND PATCH v3] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
Message-ID: <1484128540-22662-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
this patch adds this reserved zone and redefines the usable memory range.

The memory node is also moved from the dtsi files into the proper dts files
to handle variants memory sizes.

This patch also fixes the memory sizes for the following platforms :
- gxl-s905x-p212 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
- gxm-s912-q201 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
- gxl-s905d-p231 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
- gxl-nexbox-a95x : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi       |  5 -----
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                 | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts       |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts           |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts           |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi          |  5 -----
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts       |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts       |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts       |  9 +++++++++
 17 files changed, 106 insertions(+), 18 deletions(-)

Changes since original v2 at [3]:
- Typo in commit 2GiB -> 1GiB, 4GiB -> 2GiB

Changes since v2 at [2]:
- Moved all memory node out of dtsi
- Added comment about useable memory
- Fixed comment about secmon reserved zone

Changes since v1 at [1] :
- Renamed reg into linux,usable-memory to ovveride u-boot memory
- only kept secmon memory zone

[1] http://lkml.kernel.org/r/20161212101801.28491-1-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1483105232-6242-1-git-send-email-narmstrong at baylibre.com
[3] http://lkml.kernel.org/r/1484128128-22454-1-git-send-email-narmstrong at baylibre.com

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 7a078be..360ec0d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -54,11 +54,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index eada0b5..66677b5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -55,6 +55,18 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 2MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon: secmon {
+			reg = <0x0 0x10000000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <0x2>;
 		#size-cells = <0x0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 4cbd626..adcaf0b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -62,7 +62,11 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x40000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
 	};
 
 	leds {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 238fbea..9d45fe6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -61,7 +61,11 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
 	};
 
 	usb_otg_pwr: regulator-usb-pwrs {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 03e3d76..8ce7cc1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -49,6 +49,15 @@
 / {
 	compatible = "amlogic,p200", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P200 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
+	};
 };
 
 &i2c_B {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 39bb037..0de22c7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -49,4 +49,13 @@
 / {
 	compatible = "amlogic,p201", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P201 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
+	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 4a96e0f..8052a39 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -53,11 +53,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x40000000>;
-	};
-
 	usb_pwr: regulator-usb-pwrs {
 		compatible = "regulator-fixed";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
index 62fb496..9d27e4f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
@@ -50,6 +50,10 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
index 9a9663a..0112205 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
@@ -50,6 +50,10 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x40000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
index 2fe167b..16bad57 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
@@ -50,6 +50,10 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
index cea4a3e..b9a354a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
@@ -60,7 +60,11 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
 	};
 
 	vddio_card: gpio-regulator {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index f66939c..d96d0c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -49,6 +49,15 @@
 / {
 	compatible = "amlogic,p230", "amlogic,s905d", "amlogic,meson-gxl";
 	model = "Amlogic Meson GXL (S905D) P230 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
+	};
 };
 
 /* P230 has exclusive choice between internal or external PHY */
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
index 95992cf..e21d3ff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
@@ -49,6 +49,15 @@
 / {
 	compatible = "amlogic,p231", "amlogic,s905d", "amlogic,meson-gxl";
 	model = "Amlogic Meson GXL (S905D) P231 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
+	};
 };
 
 /* P231 has only internal PHY port */
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 9639f01..71c5a40 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -59,7 +59,11 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 5a337d3..2568e33 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -62,7 +62,11 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
 	};
 
 	vddio_boot: regulator-vddio-boot {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
index 5dbc660..2ef5e20 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
@@ -49,6 +49,15 @@
 / {
 	compatible = "amlogic,q200", "amlogic,s912", "amlogic,meson-gxm";
 	model = "Amlogic Meson GXM (S912) Q200 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
+	};
 };
 
 /* Q200 has exclusive choice between internal or external PHY */
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
index 95e11d7..017b9af 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
@@ -49,6 +49,15 @@
 / {
 	compatible = "amlogic,q201", "amlogic,s912", "amlogic,meson-gxm";
 	model = "Amlogic Meson GXM (S912) Q201 Development Board";
+
+	memory at 0 {
+		device_type = "memory";
+		/*
+		 * The first 16MiB and last 16MiB of the DDR memory
+		 * are reserved to the Hardware ROM Firmware
+		 */
+		linux,usable-memory = <0x0 0x1000000 0x0 0x3f000000>;
+	};
 };
 
 /* Q201 has only internal PHY port */
-- 
1.9.1
