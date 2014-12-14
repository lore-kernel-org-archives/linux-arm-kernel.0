From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 14 Dec 2014 02:43:15 +0100
Subject: [PATCHv0 5/5] dt-bindings: fix isl vs isil prefix issue for Intersil
In-Reply-To: <cover.1418519430.git.arno@natisbad.org>
References: <cover.1418519430.git.arno@natisbad.org>
Message-ID: <b2c34bea6fc7bd42d636c9cadfe1b7e5ec523aeb.1418519430.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When Intersil ISL12057 driver was introduced by commit 70e123373c05
("rtc: Add support for Intersil ISL12057 I2C RTC chip"), the vendor
prefix 'isl' was used instead of the expected 'isil' (Intersil
NASDAQ symbol) and documented in vendor-prefixes.txt.

Recently, a patch from Philip Zabel (7a6540ca856a, "ARM: mvebu:
Change vendor prefix for Intersil Corporation to isil") fixed that
prefix in ReadyNAS devices .dts files (AFAICT, the only users of
the driver).

Then, commits 7c75c1d5e72b ("dt-bindings: Document deprecated device
vendor name to fix related warning") and b2ea3f82e798 (dt-bindings:
Document correct and deprecated vendor-prefix with device isl29028)
decided to go the other way and deprecate isil in vendor-prefixes.txt
and in isl29028.c staging driver.

While trying and merge a fix I wrote for ISL12057 drivers to finish
Philip's work, it conflicted with the two recently introduced commits,
and revealed the issue: at the moment, there are various compatible
strings in drivers and .dts files for Intersil products which use
either isl or isil:

$ grep -R "isil," .
./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isil,isl29028           (deprecated, use isl)
./drivers/staging/iio/light/isl29028.c:   { .compatible = "isil,isl29028", },/* deprecated, don't use */
./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29018", },
./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29023", },
./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29035", },
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/arm/boot/dts/exynos5800-peach-pi.dts: compatible = "isil,isl29018";
./arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi: compatible = "isil,isl1208";
./arch/arm/boot/dts/tegra20-ventana.dts:     compatible = "isil,isl29018";
./arch/arm/boot/dts/tegra20-seaboard.dts:    compatible = "isil,isl29018";
./arch/arm/boot/dts/armada-xp-netgear-rn2120.dts: compatible = "isil,isl12057";
./arch/arm/boot/dts/armada-370-netgear-rn104.dts: compatible = "isil,isl12057";
./arch/arm/boot/dts/exynos5420-peach-pit.dts:     compatible = "isil,isl29018";
./arch/arm/boot/dts/armada-370-netgear-rn102.dts: compatible = "isil,isl12057";

$ grep -R "isl," .
./Documentation/devicetree/bindings/regulator/isl9305.txt:- compatible: "isl,isl9305" or "isl,isl9305h"
./Documentation/devicetree/bindings/regulator/isl9305.txt:              compatible = "isl,isl9305";
./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isl,isl12057      Intersil ISL12057 I2C RTC Chip
./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isl,isl29028      Intersil ISL29028 Ambient Light ....
./drivers/regulator/isl9305.c:          { .compatible = "isl,isl9305" },
./drivers/regulator/isl9305.c:          { .compatible = "isl,isl9305h" },
./drivers/staging/iio/light/isl29028.c: { .compatible = "isl,isl29028", },
./drivers/rtc/rtc-isl12057.c:           { .compatible = "isl,isl12057" },
./drivers/rtc/rtc-isl12022.c:           { .compatible = "isl,isl12022" },
./arch/arm/boot/dts/tegra30-cardhu.dtsi:   compatible = "isl,isl29028";
./arch/arm/boot/dts/zynq-parallella.dts:   compatible = "isl,isl9305";

AFAICT, it seems it makes sense to *definitively* settle for isil as the
vendor prefix for Intersil, as Philip did in 7a6540ca856a: it's the NASDAQ
symbol and this choice requires less changes than opting for isl.

So, this patch changes compatible strings in .dts files to use isil where
isl was found before, and modify drivers w/ compatible strings using isl
to add one using isil. In those cases, a comment is made that the old
compatible string is kept for backward compatibility (w/ out-fo-tree users
of those drivers). Additionally, it leaves only isil as prefix in
vendor-prefixes.txt. Those changes should prevent any new inclusion of
isl compatible strings for Intersil devices due to copy-and-paste.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
 Documentation/devicetree/bindings/regulator/isl9305.txt   | 4 ++--
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--
 arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
 arch/arm/boot/dts/zynq-parallella.dts                     | 2 +-
 drivers/regulator/isl9305.c                               | 6 ++++--
 drivers/rtc/rtc-isl12022.c                                | 3 ++-
 drivers/rtc/rtc-isl12057.c                                | 3 ++-
 drivers/staging/iio/light/isl29028.c                      | 4 ++--
 9 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 605dcca5dbec..213855bb419b 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -55,9 +55,8 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-isl,isl12057		Intersil ISL12057 I2C RTC Chip
-isil,isl29028           (deprecated, use isl)
-isl,isl29028            Intersil ISL29028 Ambient Light and Proximity Sensor
+isil,isl12057		Intersil ISL12057 I2C RTC/Alarm Chip
+isil,isl29028           Intersil ISL29028 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Interface
diff --git a/Documentation/devicetree/bindings/regulator/isl9305.txt b/Documentation/devicetree/bindings/regulator/isl9305.txt
index a626fc1bbf0d..d6e7c9ec9413 100644
--- a/Documentation/devicetree/bindings/regulator/isl9305.txt
+++ b/Documentation/devicetree/bindings/regulator/isl9305.txt
@@ -2,7 +2,7 @@ Intersil ISL9305/ISL9305H voltage regulator
 
 Required properties:
 
-- compatible: "isl,isl9305" or "isl,isl9305h"
+- compatible: "isil,isl9305" or "isil,isl9305h"
 - reg: I2C slave address, usually 0x68.
 - regulators: A node that houses a sub-node for each regulator within the
   device. Each sub-node is identified using the node's name, with valid
@@ -19,7 +19,7 @@ Optional properties:
 Example
 
 	pmic: isl9305 at 68 {
-		compatible = "isl,isl9305";
+		compatible = "isil,isl9305";
 		reg = <0x68>;
 
 		VINDCD1-supply = <&system_power>;
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index cc6151c431c8..ba574e431c5a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -79,8 +79,7 @@ innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
 isee	ISEE 2007 S.L.
-isil    Intersil (deprecated, use isl)
-isl	Intersil
+isil	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
 lacie	LaCie
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index cbf5a1ae0ca7..a1b682ea01bd 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -189,7 +189,7 @@
 
 		/* ALS and Proximity sensor */
 		isl29028 at 44 {
-			compatible = "isl,isl29028";
+			compatible = "isil,isl29028";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index ab1dc0a56cdd..174571232ea5 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -58,7 +58,7 @@
 	status = "okay";
 
 	isl9305: isl9305 at 68 {
-		compatible = "isl,isl9305";
+		compatible = "isil,isl9305";
 		reg = <0x68>;
 
 		regulators {
diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index 92fefd98da58..6e3a15fe00f1 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -177,8 +177,10 @@ static int isl9305_i2c_probe(struct i2c_client *i2c,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl9305_dt_ids[] = {
-	{ .compatible = "isl,isl9305" },
-	{ .compatible = "isl,isl9305h" },
+	{ .compatible = "isl,isl9305" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl9305" },
+	{ .compatible = "isl,isl9305h" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl9305h" },
 	{},
 };
 #endif
diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ee3ba7e6b45e..f9b082784b90 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -275,7 +275,8 @@ static int isl12022_probe(struct i2c_client *client,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl12022_dt_match[] = {
-	{ .compatible = "isl,isl12022" },
+	{ .compatible = "isl,isl12022" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl12022" },
 	{ },
 };
 #endif
diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index 98adc2c1bdb0..949121ed0255 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -644,7 +644,8 @@ static SIMPLE_DEV_PM_OPS(isl12057_rtc_pm_ops, isl12057_rtc_suspend,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl12057_dt_match[] = {
-	{ .compatible = "isl,isl12057" },
+	{ .compatible = "isl,isl12057" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl12057" },
 	{ },
 };
 #endif
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index e969107ddb47..6440e3b293ca 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -537,8 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isl,isl29028", },
-	{ .compatible = "isil,isl29028", },/* deprecated, don't use */
+	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl29028", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
2.1.1
