From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 22:16:55 +0100
Subject: [PATCH/RFC v2 06/11] ARM: dts: r8a7779: Add SYSC PM domains
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455571020-18968-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up ARM CPU cores 1-3 to their respective PM domains.
Note that ARM CPU core 0 cannot be shut off.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Correct sysc "reg" property (#address/size-cells = 1, not 2),
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7779.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index a0cc08e6295b0396..14b28c225bb3587c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -34,18 +34,21 @@
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_arm1>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_arm2>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_arm3>;
 		};
 	};
 
@@ -591,4 +594,49 @@
 				"mmc1", "mmc0";
 		};
 	};
+
+	sysc: system-controller at ffd85000 {
+		compatible = "renesas,r8a7779-sysc";
+		reg = <0xffd85000 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_arm1: cpu at 1 {
+				reg = <1 0x41>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_arm2: cpu at 2 {
+				reg = <2 0x42>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_arm3: cpu at 3 {
+				reg = <3 0x43>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sh: sh at 16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sgx: sgx at 20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_vdp: vdp at 21 {
+				reg = <21 0x100>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_imp: imp at 24 {
+				reg = <24 0x140>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
 };
-- 
1.9.1
