From: German.Rivera@freescale.com (J. German Rivera)
Date: Fri, 30 Oct 2015 15:04:58 -0500
Subject: [PATCH v4] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
Message-ID: <1446235498-4093-1-git-send-email-German.Rivera@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added sys-reboot node to the FSL's LS2085A SoC DT to leverage
the ARM-generic reboot mechanism for this SoC. This mechanism
is enabled through CONFIG_POWER_RESET_SYSCON.

Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
---
CHANGE HISTORY:

Changes in v2:
- Addressed comment form Stuart Yoder:
  * Removed "@<address>" from reboot node

Changes in v3:
- Addressed comment form Stuart Yoder:
  * Expose only the reset register

Changes in v4:
- Addressed comment from Arnd Bergmann:
  * Changed compatible string to be more specific
  * Changed node name to 'syscon' instead of 'rstcr'
  * Changed address to lower case hex
- Addressed comment form Stuart Yoder:
  * Rebase on top of branch arm-soc/for-next

 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index e81cd48..a790a90 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -153,6 +153,18 @@
 		};
 	};

+	rstcr: syscon at 1e60000 {
+		compatible = "fsl,ls2085a-rstcr", "syscon";
+		reg = <0x0 0x1e60000 0x0 0x4>;
+	};
+
+	reboot {
+		compatible ="syscon-reboot";
+		regmap = <&rstcr>;
+		offset = <0x0>;
+		mask = <0x2>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 0x8>, /* Physical Secure PPI, active-low */
--
2.3.3
