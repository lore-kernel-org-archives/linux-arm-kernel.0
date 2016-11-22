From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Nov 2016 17:16:02 +0100
Subject: [PATCH] arm64: tegra: Add VDD_GPU regulator to Jetson TX1
Message-ID: <20161122161602.3984-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Courbot <acourbot@nvidia.com>

Add the VDD_GPU regulator (a GPIO-enabled PWM regulator) to the Jetson
TX1 board. This addition allows the GPU to be used provided the
bootloader properly enabled the GPU node.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi ARM-SoC maintainers,

This was part of a pull request for v4.8 but it seems everything of the
pull request except this one patch made it upstream. I think perhaps it
may have been the dependency on the regulator tree that made you defer
this to after v4.8-rc1 and then I forgot to resend.

Here's a link to the pull request:

	http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/443469.html

There was no discussion on the list, but we might have discussed it on
IRC.

Can you please pick this up for v4.10-rc1?

Thanks,
Thierry

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 5fda583351d7..906fb836d241 100644
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
-- 
2.10.2
