From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 30 Apr 2012 12:14:29 -0700
Subject: [PATCH 19/20] ARM: Exynos5: Add combiner,
 wakeup interrupt controller and ethernet nodes
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335813270-13083-20-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And interrupt combiner, external interrupt wakeup interrupt controller
and smsc9215 lan controller nodes.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   11 ++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   55 +++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bcc4b89..dbc4bdb 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -24,6 +24,17 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200";
 	};
 
+	lan9215 at 0x05000000 {
+		compatible = "smsc,lan9215", "smsc,lan9115";
+		reg = <0x05000000 0x20000>;
+		interrupts = <5 0>;
+		interrupt-parent = <&wakeup_eint>;
+		phy-mode = "mii";
+		smsc,irq-push-pull;
+		smsc,force-internal-phy;
+		local-mac-address = [00 80 00 23 45 67];
+	};
+
 	i2c at 12C60000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 76b7dba..af124917 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -26,10 +26,65 @@
 	gic:interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		#size-cells = <0>;
 		interrupt-controller;
 		reg = <0x10481000 0x1000>, <0x10482000 0x2000>;
 	};
 
+	combiner:interrupt-controller at 10440000 {
+		compatible = "samsung,exynos4210-combiner";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		samsung,combiner-nr = <32>;
+		reg = <0x10440000 0x1000>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+			     <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
+			     <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
+			     <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
+			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
+	};
+
+	wakeup_eint: interrupt-controller at 11400000 {
+		compatible = "samsung,exynos5210-wakeup-eint";
+		reg = <0x11400000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&wakeup_map>;
+		interrupts = <0x0 0>, <0x1 0>, <0x2 0>, <0x3 0>,
+			     <0x4 0>, <0x5 0>, <0x6 0>, <0x7 0>,
+			     <0x8 0>, <0x9 0>, <0xa 0>, <0xb 0>,
+			     <0xc 0>, <0xd 0>, <0xe 0>, <0xf 0>,
+			     <0x10 0>;
+
+                wakeup_map: interrupt-map {
+			compatible = "samsung,exynos5210-wakeup-eint-map";
+                        #interrupt-cells = <2>;
+                        #address-cells = <0>;
+                        #size-cells = <0>;
+                        interrupt-map = <0x0 0 &combiner 23 0>,
+                                        <0x1 0 &combiner 24 0>,
+                                        <0x2 0 &combiner 25 0>,
+                                        <0x3 0 &combiner 25 1>,
+                                        <0x4 0 &combiner 26 0>,
+                                        <0x5 0 &combiner 26 1>,
+                                        <0x6 0 &combiner 27 0>,
+                                        <0x7 0 &combiner 27 1>,
+                                        <0x8 0 &combiner 28 0>,
+                                        <0x9 0 &combiner 28 1>,
+                                        <0xa 0 &combiner 29 0>,
+                                        <0xb 0 &combiner 29 1>,
+                                        <0xc 0 &combiner 30 0>,
+                                        <0xd 0 &combiner 30 1>,
+                                        <0xe 0 &combiner 31 0>,
+                                        <0xf 0 &combiner 31 1>,
+                                        <0x10 0 &gic 0 32 0>;
+                };
+        };
+
 	watchdog {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x101D0000 0x100>;
-- 
1.7.5.4
