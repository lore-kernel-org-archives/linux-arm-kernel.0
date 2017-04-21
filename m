From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Apr 2017 22:40:58 +0200
Subject: [PATCH 5/5 v3] ARM: dts: Add the FOTG210 USB host to Gemini
In-Reply-To: <20170421204058.6206-1-linus.walleij@linaro.org>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
Message-ID: <20170421204058.6206-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the FOTG210 USB host controller to the Gemini
device trees. In the main SoC DTSI it is flagged as disabled
and then it is selectively enabled on the devices that utilize
it (these per-platform enablements are done on the out-of-tree
OpenWrt patch set). It is not enabled on the Itian SquareOne
NAS/router since this instead has a VIA host controller
soldered on the PCI port, and can gate off these USB host
controllers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
USB maintainers: I will merge this through the ARM SoC tree,
the patch is only included in the series for context.
---
 arch/arm/boot/dts/gemini-nas4220b.dts |  8 ++++++++
 arch/arm/boot/dts/gemini-rut1xx.dts   |  8 ++++++++
 arch/arm/boot/dts/gemini-wbd111.dts   |  8 ++++++++
 arch/arm/boot/dts/gemini-wbd222.dts   |  8 ++++++++
 arch/arm/boot/dts/gemini.dtsi         | 22 ++++++++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 7668ba52158e..55059a72aef2 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -98,5 +98,13 @@
 				read-only;
 			};
 		};
+
+		usb at 68000000 {
+			status = "okay";
+		};
+
+		usb at 69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index 7b920bfbda32..1c253da9f28c 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -61,5 +61,13 @@
 			reg = <0x30000000 0x00800000>;
 			/* TODO: add flash partitions here */
 		};
+
+		usb at 68000000 {
+			status = "okay";
+		};
+
+		usb at 69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index 63b756e3bf5a..c6a5abca0935 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -98,5 +98,13 @@
 				read-only;
 			};
 		};
+
+		usb at 68000000 {
+			status = "okay";
+		};
+
+		usb at 69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index 9747f5a47807..415380262140 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -98,5 +98,13 @@
 				read-only;
 			};
 		};
+
+		usb at 68000000 {
+			status = "okay";
+		};
+
+		usb at 69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 6fe678a68e31..2f8d0381d5eb 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -183,5 +183,27 @@
 				#interrupt-cells = <1>;
 			};
 		};
+
+		usb at 68000000 {
+			compatible = "cortina,gemini-usb", "faraday,fotg210";
+			reg = <0x68000000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcon 8>;
+			clocks = <&gcc GEMINI_CLK_GATE_USB0>;
+			clock-names = "PCLK";
+			syscon = <&syscon>;
+			status = "disabled";
+		};
+
+		usb at 69000000 {
+			compatible = "cortina,gemini-usb", "faraday,fotg210";
+			reg = <0x69000000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcon 9>;
+			clocks = <&gcc GEMINI_CLK_GATE_USB1>;
+			clock-names = "PCLK";
+			syscon = <&syscon>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.9.3
