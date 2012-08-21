From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 21 Aug 2012 17:33:56 +0300
Subject: [PATCH] ASoC: omap-mcbsp: Device tree binding documentation update
Message-ID: <1345559636-23370-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To reflect the final devicetree node structure of McBSPs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello,

the initial OMAP McBSP DT structure was not able to describe the IP (and it's
versions) correctly.
The main issue was the sidetone block of McBSP2/3 on OMAP3.
With this change in the DT description the OS can get the needed information
about the IP.

The sidetone is still not supported when the Linux kernel is booted with DT
since we still depend on hwmod to fill the resources.

This patch depend on the McBSP DT support series going via audio tree.

Regards,
Peter

 .../devicetree/bindings/sound/omap-mcbsp.txt       |   28 +++++++------------
 1 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-mcbsp.txt b/Documentation/devicetree/bindings/sound/omap-mcbsp.txt
index 447cb13..17cce44 100644
--- a/Documentation/devicetree/bindings/sound/omap-mcbsp.txt
+++ b/Documentation/devicetree/bindings/sound/omap-mcbsp.txt
@@ -8,38 +8,30 @@ Required properties:
 - reg: Register location and size, for OMAP4+ as an array:
        <MPU access base address, size>,
        <L3 interconnect address, size>;
+- reg-names: Array of strings associated with the address space
 - interrupts: Interrupt numbers for the McBSP port, as an array in case the
 	      McBSP IP have more interrupt lines:
 	<OCP compliant irq>,
 	<TX irq>,
 	<RX irq>;
+- interrupt-names: Array of strings associated with the interrupt numbers
 - interrupt-parent: The parent interrupt controller
 - ti,buffer-size: Size of the FIFO on the port (OMAP2430 and newer SoC)
 - ti,hwmods: Name of the hwmod associated to the McBSP port
 
-Sidetone support for OMAP3 McBSP2 and 3 ports:
-- sidetone { }: Within this section the following parameters are required:
-- reg: Register location and size for the ST block
-- interrupts: The interrupt number for the ST block
-- interrupt-parent: The parent interrupt controller for the ST block
-
 Example:
 
 mcbsp2: mcbsp at 49022000 {
 	compatible = "ti,omap3-mcbsp";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg = <0x49022000 0xff>;
-	interrupts = <0 17 0x4>, /* OCP compliant interrup */
-		     <0 62 0x4>, /* TX interrup */
-		     <0 63 0x4>; /* RX interrup */
+	reg = <0x49022000 0xff>,
+	      <0x49028000 0xff>;
+	reg-names = "mpu", "sidetone";
+	interrupts = <0 17 0x4>, /* OCP compliant interrupt */
+		     <0 62 0x4>, /* TX interrupt */
+		     <0 63 0x4>, /* RX interrupt */
+		     <0 4 0x4>;  /* Sidetone */
+	interrupt-names = "common", "tx", "rx", "sidetone";
 	interrupt-parent = <&intc>;
 	ti,buffer-size = <1280>;
 	ti,hwmods = "mcbsp2";
-
-	sidetone {
-		reg = <0x49028000 0xff>;
-		interrupts = <0 4 0x4>;
-		interrupt-parent = <&intc>;
-	};
 };
-- 
1.7.8.6
