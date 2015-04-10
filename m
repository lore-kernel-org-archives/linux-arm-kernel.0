From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:36:04 +0200
Subject: [PATCH 9/9] ARM: tegra: apalis t30: fix pin muxing and add HDA in
 device tree
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <94ae838321940e1a245c115009f6c48f0eceee76.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix pin muxing, add digital audio aka HDA pin muxing and activate HDA
driver.
Fix pu vs. gpio_pu pin muxing.
While at it also update comment about supported module hardware
versions.
While at it also add an emmc label to the SDHCI node just like on
Colibri T30.
While at it set the dr_mode of the primary USB EHCI instance to OTG as
well.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
With all that it loads and detects our Realtek codec just fine as can
be seen below but so far I have been unable to figure out how to
actually get it to deliver some actual acoustics (;-p). Any input on
any of this welcome.

[    8.496588] sound hdaudioC0D1: autoconfig for ALC898: line_outs=4 (0x14/0x16/
0x15/0x17/0x0) type:line
[    8.511715] sound hdaudioC0D1:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.524117] sound hdaudioC0D1:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    8.536163] sound hdaudioC0D1:    mono: mono_out=0x0
[    8.546995] sound hdaudioC0D1:    dig-out=0x1e/0x0
[    8.557650] sound hdaudioC0D1:    inputs:
[    8.567532] sound hdaudioC0D1:      Rear Mic=0x18
[    8.578108] sound hdaudioC0D1:      Front Mic=0x19
[    8.588767] sound hdaudioC0D1:      Line=0x1a
[    8.598992] sound hdaudioC0D1:      CD=0x1c
[   13.252853] input: tegra-hda Rear Mic as /devices/soc0/70030000.hda/sound/car
d0/input1
[   13.268130] input: tegra-hda Front Mic as /devices/soc0/70030000.hda/sound/ca
rd0/input2
[   13.283471] input: tegra-hda Line as /devices/soc0/70030000.hda/sound/card0/i
nput3
[   13.298377] input: tegra-hda Line Out Front as /devices/soc0/70030000.hda/sou
nd/card0/input4
[   13.314144] input: tegra-hda Line Out Surround as /devices/soc0/70030000.hda/
sound/card0/input5
[   13.330208] input: tegra-hda Line Out CLFE as /devices/soc0/70030000.hda/soun
d/card0/input6
[   13.345893] input: tegra-hda Line Out Side as /devices/soc0/70030000.hda/soun
d/card0/input7
[   13.361579] input: tegra-hda Front Headphone as /devices/soc0/70030000.hda/so
und/card0/input8
[   13.377476] input: tegra-hda HDMI/DP,pcm=3 as /devices/soc0/70030000.hda/soun
d/card0/input9

[   14.274781] ALSA device list:
[   14.287090]   #0: tegra-hda at 0x70038000 irq 345

 arch/arm/boot/dts/tegra30-apalis-eval.dts |  5 ++++
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 46 +++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 6236bde..37437c6 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -126,6 +126,10 @@
 		};
 	};
 
+	hda at 70030000 {
+		status = "okay";
+	};
+
 	sd1: sdhci at 78000000 {
 		status = "okay";
 		bus-width = <4>;
@@ -149,6 +153,7 @@
 
 	usb-phy at 7d000000 {
 		status = "okay";
+		dr_mode = "otg";
 		vbus-supply = <&usbo1_vbus_reg>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index a5446cb..e6bac82 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -2,7 +2,7 @@
 
 /*
  * Toradex Apalis T30 Device Tree
- * Compatible for Revisions 1GB: V1.0A; 2GB: V1.0B, V1.0C
+ * Compatible for Revisions 1GB: V1.0A, V1.1A; 1GB IT: V1.1A; 2GB: V1.0B, V1.0C, V1.0E, V1.1A
  */
 / {
 	model = "Toradex Apalis T30";
@@ -65,7 +65,7 @@
 			/* BKL1_PWM_EN#, disable TPS65911 PMIC PWM backlight */
 			uart3_cts_n_pa1 {
 				nvidia,pins =	"uart3_cts_n_pa1";
-				nvidia,function = "rsvd1";
+				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -108,6 +108,30 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis Digital Audio */
+			clk1_req_pee2 {
+				nvidia,pins =	"clk1_req_pee2";
+				nvidia,function = "hda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			clk2_out_pw5 {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap1_fs_pn0 {
+				nvidia,pins =	"dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "hda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis I2C3 */
 			cam_i2c_scl_pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -151,32 +175,32 @@
 			};
 
 			/* Apalis PWM1 */
-			gpio_pu6 {
-				nvidia,pins =	"gpio_pu6";
+			pu6 {
+				nvidia,pins =	"pu6";
 				nvidia,function = "pwm3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis PWM2 */
-			gpio_pu5 {
-				nvidia,pins =	"gpio_pu5";
+			pu5 {
+				nvidia,pins =	"pu5";
 				nvidia,function = "pwm2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis PWM3 */
-			gpio_pu4 {
-				nvidia,pins =	"gpio_pu4";
+			pu4 {
+				nvidia,pins =	"pu4";
 				nvidia,function = "pwm1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* Apalis PWM4 */
-			gpio_pu3 {
-				nvidia,pins =	"gpio_pu3";
+			pu3 {
+				nvidia,pins =	"pu3";
 				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -635,7 +659,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	sdhci at 78000600 {
+	emmc: sdhci at 78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
-- 
1.9.3
