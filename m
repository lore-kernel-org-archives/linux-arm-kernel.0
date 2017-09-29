From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Sep 2017 15:34:05 -0700
Subject: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect target
 module binding
In-Reply-To: <20170929223411.9691-1-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
Message-ID: <20170929223411.9691-2-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recently introduced omap clkctrl module binding, we can start
moving omap hwmod data to device tree and drivers from arch/arm/mach-omap2.

To start doing this, let's introduce a device tree binding for TI
sysc interconnect target module hardware. The sysc manages module clocks,
idlemodes and interconnect level resets. Each interconnect target module
can have one or more child devices connected to it.

TI sysc interconnect target module hardware is independent of the
interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
and TI L4 interconnect (Sonics s3220). The sysc is mostly used for
interaction between module and PRCM. It participates in the OCP Disconnect
Protocol but other than that is mostly indepenent of the interconnect.

As all the features may not be supported for a given sysc module, we
need to use device tree configuration for the revision of the interconnect
target module.

Note that the interconnect target module control registers are always
sprinked at varying locations in the unused address space of the first
child device IP block. To avoid device tree reg conflicts, the sysc device
provides ranges for it's children.

For a non-intrusive transition from static hwmod data to using device
tree defined TI interconnect target module binding, we can keep things
working with static hwmod data if device tree property "ti,hwmods" is
specified for the the interconnect target module.

Note that additional properties for sysc capabilities will be added
later on. For now, we can already use this binding for interconnect
target modules that do not have any child device drivers available.
This allows us to idle the unused interconnect target modules during
init without the need for legacy hwmod platform data for doing it.

Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt | 93 +++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -0,0 +1,93 @@
+Texas Instruments sysc interconnect target module wrapper binding
+
+Texas Instruments SoCs can have a generic interconnect target module
+hardware for devices connected to various interconnects such as L3
+interconnect (Arteris NoC) and L4 interconnect (Sonics s3220). The sysc
+is mostly used for interaction between module and PRCM. It participates
+in the OCP Disconnect Protocol but other than that is mostly indepenent
+of the interconnect.
+
+Each interconnect target module can have one or more devices connected to
+it. There is a set of control registers for managing interconnect target
+module clocks, idle modes and interconnect level resets for the module.
+
+These control registers are sprinkled into the unused register address
+space of the first child device IP block managed by the interconnect
+target module and typically are named REVISION, SYSCONFIG and SYSSTATUS.
+
+Required standard properties:
+
+- compatible	shall be one of the following generic types:
+
+		"ti,sysc-omap2"
+		"ti,sysc-omap4"
+		"ti,sysc-omap4-simple"
+
+		or one of the following derivative types for hardware
+		needing special workarounds:
+
+		"ti,sysc-omap3430-sr"
+		"ti,sysc-omap3630-sr"
+		"ti,sysc-omap4-sr"
+		"ti,sysc-omap3-sham"
+		"ti,sysc-omap-aes"
+		"ti,sysc-mcasp"
+		"ti,sysc-usb-host-fs"
+
+- reg		shall have register areas implemented for the interconnect
+		target module in question such as revision, sysc and syss
+
+- reg-names	shall contain the register names implemented for the
+		interconnect target module in question such as
+		"rev, "sysc", and "syss"
+
+- ranges	shall contain the interconnect target module IO range
+		available for one or more child device IP blocks managed
+		by the interconnect target module, the ranges may include
+		multiple ranges such as device L4 range for control and
+		parent L3 range for DMA access
+
+Optional properties:
+
+- clocks	clock specifier for each name in the clock-names as
+		specified in the binding documentation for ti-clkctrl,
+		typically available for all interconnect targets on TI SoCs
+		based on omap4 except if it's read-only register in hwauto
+		mode as for example omap4 L4_CFG_CLKCTRL
+
+- clock-names	should contain at least "fck", and optionally also "ick"
+		depending on the SoC and the interconnect target module
+
+- ti,hwmods	optional TI interconnect module name to use legacy
+		hwmod platform data
+
+
+Example: Single instance of MUSB controller on omap4 using interconnect ranges
+using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
+
+	target-module at 2b000 {		/* 0x4a0ab000, ap 84 12.0 */
+		compatible = "ti,sysc-omap2";
+		ti,hwmods = "usb_otg_hs";
+		reg = <0x2b400 0x4>,
+		      <0x2b404 0x4>,
+		      <0x2b408 0x4>;
+		reg-names = "rev", "sysc", "syss";
+		clocks = <&l3_init_clkctrl OMAP4_USB_OTG_HS_CLKCTRL 0>;
+		clock-names = "fck";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x2b000 0x1000>;
+
+		usb_otg_hs: otg at 0 {
+			compatible = "ti,omap4-musb";
+			reg = <0x0 0x7ff>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			usb-phy = <&usb2_phy>;
+			...
+		};
+	};
+
+Note that other SoCs, such as am335x can have multipe child devices. On am335x
+there are two MUSB instances, two USB PHY instances, and a single CPPI41 DMA
+instance as children of a single interconnet target module.
-- 
2.14.2
