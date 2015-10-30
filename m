From: German.Rivera@freescale.com (J. German Rivera)
Date: Fri, 30 Oct 2015 12:08:12 -0500
Subject: [PATCH v3] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
Message-ID: <1446224892-29407-1-git-send-email-German.Rivera@freescale.com>
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

 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
index e281ceb..5e3d894 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
@@ -131,6 +131,18 @@
 		interrupts = <1 9 0x4>;
 	};

+	rstcr: rstcr at 1E60000 {
+		compatible = "syscon";
+		reg = <0x0 0x1E60000 0x0 0x4>;
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
