From: German.Rivera@freescale.com (J. German Rivera)
Date: Fri, 6 Nov 2015 19:38:13 -0600
Subject: [PATCH v6] arm64: dts: Added syscon-reboot node for FSL's LS2080A SoC
Message-ID: <1446860293-7145-1-git-send-email-German.Rivera@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added sys-reboot node to the FSL's LS2080A SoC DT to leverage
the ARM-generic reboot mechanism for this SoC. This mechanism
is enabled through CONFIG_POWER_RESET_SYSCON.

Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
---
CHANGE HISTORY:

Changes in v6:
- Addressed comment from Javier Martinez Canillas
  * Moved change history out of actual commit message
- Addressed comment from Leo Li
  * Refer to LS2080A in compatible string

Changes in v5:
- Addressed comment from Stuart Yoder
  * Fixed commit message to refer to LS2080A instead of LS2085A.

Changes in v4:
- Addressed comment from Arnd Bergmann:
  * Changed compatible string to be more specific
  * Changed node name to 'syscon' instead of 'rstcr'
  * Changed address to lower case hex
- Addressed comment form Stuart Yoder:
  * Rebase on top of branch arm-soc/for-next

Changes in v3:
- Addressed comment form Stuart Yoder:
  * Expose only the reset register

Changes in v2:
- Addressed comment form Stuart Yoder:
  * Removed "@<address>" from reboot node

 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index e81cd48..65ac35f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -153,6 +153,18 @@
 		};
 	};

+	rstcr: syscon at 1e60000 {
+		compatible = "fsl,ls2080a-rstcr", "syscon";
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
