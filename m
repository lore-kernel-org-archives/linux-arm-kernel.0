From: s-anna@ti.com (Suman Anna)
Date: Mon, 31 Jul 2017 15:05:02 -0500
Subject: [PATCH] remoteproc/keystone: Add support for Keystone 66AK2G SOCs
Message-ID: <20170731200502.30479-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to the keystone remoteproc driver for managing the
DSP present in the Keystone 2 66AK2G SoC. The 66AK2G SoC has
a Power Management Micro Controller (PMMC) that manages the
individual device's power, clock and reset functionalities.

The keystone remoteproc driver already uses standard frameworks
for reset and clock control, so it doesn't require any significant
modifications other than a new compatible suitable for 66AK2G DSP.

The binding document is also updated to reflect the modified
property values used by the 66AK2G DSP node as compared to the
values used by existing Keystone 2 DSPs.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
Hi Bjorn,

This patch adds the support to the last remaining family of Keystone2 SoCs.
The SoC integration is slightly different for this family, and all the
dependent drivers were finally merged in 4.13-rc1. The patch is mainly
updating the binding, so didn't split the patch into two.

regards
Suman

 .../bindings/remoteproc/ti,keystone-rproc.txt      | 73 +++++++++++++++++++---
 drivers/remoteproc/keystone_remoteproc.c           |  1 +
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
index 2aac1aa4123d..1eb72874130b 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
+++ b/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
@@ -26,6 +26,7 @@ The following are the mandatory properties:
 			    "ti,k2hk-dsp" for DSPs on Keystone 2 66AK2H/K SoCs
 			    "ti,k2l-dsp" for DSPs on Keystone 2 66AK2L SoCs
 			    "ti,k2e-dsp" for DSPs on Keystone 2 66AK2E SoCs
+			    "ti,k2g-dsp" for DSPs on Keystone 2 66AK2G SoCs
 
 - reg:			Should contain an entry for each value in 'reg-names'.
 			Each entry should have the memory region's start address
@@ -37,20 +38,18 @@ The following are the mandatory properties:
 			should be defined in this order,
 			     "l2sram", "l1pram", "l1dram"
 
-- clocks: 		Should contain the device's input clock, and should be
-			defined as per the bindings in,
-			Documentation/devicetree/bindings/clock/keystone-gate.txt
-
 - ti,syscon-dev:	Should be a pair of the phandle to the Keystone Device
 			State Control node, and the register offset of the DSP
 			boot address register within that node's address space.
 
 - resets:		Should contain the phandle to the reset controller node
 			managing the resets for this device, and a reset
-			specifier. Please refer to the following reset bindings
-			for the reset argument specifier as per SoC,
+			specifier. Please refer to either of the following reset
+			bindings for the reset argument specifier as per SoC,
 			Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
-			    for 66AK2HK/66AK2L/66AK2E SoCs
+			    for 66AK2HK/66AK2L/66AK2E SoCs or,
+			Documentation/devicetree/bindings/reset/ti,sci-reset.txt
+			    for 66AK2G SoCs
 
 - interrupt-parent:	Should contain a phandle to the Keystone 2 IRQ controller
 			IP node that is used by the ARM CorePac processor to
@@ -75,6 +74,22 @@ The following are the mandatory properties:
 			The gpio device to be used is as per the bindings in,
 			Documentation/devicetree/bindings/gpio/gpio-dsp-keystone.txt
 
+SoC-specific Required properties:
+---------------------------------
+The following are mandatory properties for Keystone 2 66AK2HK, 66AK2L and 66AK2E
+SoCs only:
+
+- clocks: 		Should contain the device's input clock, and should be
+			defined as per the bindings in,
+			Documentation/devicetree/bindings/clock/keystone-gate.txt
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the DSP device id
+			value. This property is as per the binding,
+			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+
 Optional properties:
 --------------------
 
@@ -85,8 +100,10 @@ Optional properties:
 			Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
 
 
-Example:
---------
+Examples:
+---------
+
+1.
 	/* 66AK2H/K DSP aliases */
 	aliases {
 		rproc0 = &dsp0;
@@ -131,3 +148,41 @@ Example:
 		};
 
 	};
+
+2.
+	/* 66AK2G DSP alias */
+	aliases {
+		rproc0 = &dsp0;
+	};
+
+	/* 66AK2G DSP memory node */
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dsp_common_memory: dsp-common-memory at 81f800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00000008 0x1f800000 0x00000000 0x800000>;
+			reusable;
+		};
+	};
+
+	/* 66AK2G DSP node */
+	soc {
+		dsp0: dsp at 10800000 {
+			compatible = "ti,k2g-dsp";
+			reg = <0x10800000 0x00100000>,
+			      <0x10e00000 0x00008000>,
+			      <0x10f00000 0x00008000>;
+			reg-names = "l2sram", "l1pram", "l1dram";
+			power-domains = <&k2g_pds 0x0046>;
+			ti,syscon-dev = <&devctrl 0x40>;
+			resets = <&k2g_reset 0x0046 0x1>;
+			interrupt-parent = <&kirq0>;
+			interrupts = <0 8>;
+			interrupt-names = "vring", "exception";
+			kick-gpios = <&dspgpio0 27 0>;
+			memory-region = <&dsp_common_memory>;
+		};
+	};
diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 5f776bfd674a..97abb0c8ad65 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -505,6 +505,7 @@ static const struct of_device_id keystone_rproc_of_match[] = {
 	{ .compatible = "ti,k2hk-dsp", },
 	{ .compatible = "ti,k2l-dsp", },
 	{ .compatible = "ti,k2e-dsp", },
+	{ .compatible = "ti,k2g-dsp", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, keystone_rproc_of_match);
-- 
2.13.1
