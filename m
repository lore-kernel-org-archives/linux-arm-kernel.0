From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:38:04 +0100
Subject: [PATCH 4/6] ARM: dts: tegra: apalis-tk1: hog group for ethernet, pcie,
 reset gpios
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
Message-ID: <20180210013806.28496-5-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The Apalis TK1 module uses some dedicated GPIOs as I210 gigabit Ethernet
controller reset and to control RESET_MOCI aka reset module output
carrier input on MXM3 pin 26. The Apalis Evaluation Board furthermore
uses Apalis GPIO7 on MXM3 pin 15 as reset signal for its PLX PEX 8605
PCIe Switch.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts | 10 ++++++++++
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index af6c566e8ac4..f1010cefb993 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -275,3 +275,13 @@
 		vin-supply = <&reg_5v0>;
 	};
 };
+
+&gpio {
+	/* Apalis GPIO7 MXM3 pin 15 PLX PEX 8605 PCIe Switch Reset */
+	pex_perst_n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "PEX_PERST_N";
+	};
+};
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 44c31176ce90..b7648ce4565d 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -2070,3 +2070,21 @@
 		};
 	};
 };
+
+&gpio {
+	/* I210 Gigabit Ethernet Controller Reset */
+	lan_reset_n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LAN_RESET_N";
+	};
+
+	/* Control MXM3 pin 26 Reset Module Output Carrier Input */
+	reset_moci_ctrl {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(U, 4) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "RESET_MOCI_CTRL";
+	};
+};
-- 
2.14.3
