From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Dec 2016 22:44:17 +0100
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <20161207203412.GA10158@localhost>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <20161206011244.GC2749@dragon> <20161207203412.GA10158@localhost>
Message-ID: <5275588.dlJdb2OzJi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 7, 2016 12:34:12 PM CET Olof Johansson wrote:
> 
> So, it seems that Arnd didn't apply the old patch to fixes-non-critical, or
> at least didn't push out after doing it. So, I've done that now, as well as
> applied the fixup you have above.
> 

My mistake, I forgot to push it out.

I checked the other branches now and found two other commits missing
in next/fixes-non-critical:


arm64: tegra: Add missing Smaug revision
arm64: tegra: Add VDD_GPU regulator to Jetson TX1

Both sent by Thierry Reding last Friday. I can add them back on top
or you pick them up again if you are already busy doing merges.

For the first patch, I had amended the changelog text, this is the
version I had.

	Arnd

8<---------
>From 4d0a00060c1cec86f5aab57c814afbfb3e152578 Mon Sep 17 00:00:00 2001
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 2 Dec 2016 20:57:55 +0100
Subject: [PATCH] arm64: tegra: Add VDD_GPU regulator to Jetson TX1

Add the VDD_GPU regulator (a GPIO-enabled PWM regulator) to the Jetson
TX1 board. This addition allows the GPU to be used provided the
bootloader properly enabled the GPU node.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
[as pointed out by Thierry on IRC, nobody has reported a bug
 in the field, but using a new bootloader with a .dtb that
 has the incorrect data, it will crash on boot]
Fixes: 336f79c7b6d7 ("arm64: tegra: Add NVIDIA Jetson TX1 Developer Kit support")
Cc: stable at vger.kernel.org #v4.5+
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 5fda583..906fb83 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -21,6 +21,10 @@
 		reg = <0x0 0x80000000 0x1 0x0>;
 	};
 
+	gpu at 57000000 {
+		vdd-supply = <&vdd_gpu>;
+	};
+
 	/* debug port */
 	serial at 70006000 {
 		status = "okay";
@@ -291,4 +295,18 @@
 			clock-frequency = <32768>;
 		};
 	};
+
+	regulators {
+		vdd_gpu: regulator at 100 {
+			compatible = "pwm-regulator";
+			reg = <100>;
+			pwms = <&pwm 1 4880>;
+			regulator-name = "VDD_GPU";
+			regulator-min-microvolt = <710000>;
+			regulator-max-microvolt = <1320000>;
+			enable-gpios = <&pmic 6 GPIO_ACTIVE_HIGH>;
+			regulator-ramp-delay = <80>;
+			regulator-enable-ramp-delay = <1000>;
+		};
+	};
 };
