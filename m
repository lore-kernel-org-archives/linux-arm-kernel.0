From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 13 Feb 2014 15:39:03 +0100
Subject: [PATCH v2 0/7] i.MX6 PU power domain support
Message-ID: <1392302350-11729-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6Q can gate off the CPU and PU (GPU/VPU) power domains using the
Power Gating Controller (PGC) in the GPC register space. The CPU power
domain is already handled by wait state code, but the PU power domain can
be controlled using the generic power domain framework and power off the PU
supply regulator if all devices in the power domain are (runtime) suspended.

This patchset adds a GPC platform device initialized at subsys_initcall time
(after anatop regulators) that binds to the gpc device tree node and sets up
the PU power domain:

	gpc: gpc at 020dc000 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "fsl,imx6q-gpc";
		reg = <0x020dc000 0x4000>;
		interrupts = <0 89 0x04 0 90 0x04>;
		pu-supply = <&reg_pu>;

		pd_pu: pu-power-domain at 020dc260 {
			compatible = "fsl,imx6q-power-domain";
			reg = <0x020dc260 0x10>;
		};

		pd_arm: cpu-power-domain at 020dc2a0 {
			compatible = "fsl,imx6q-power-domain";
			reg = <0x020dc2a0 0x10>;
		};
	};

The cpu-power-domain node is included for completeness' sake, it is not
currently used by the code.
It registers a platform bus notifier so that it can add GPU and VPU devices
to the power domain when they are bound. If finds devices to be added to the
power domain by scanning the device tree for nodes that contain a
	power-domain = <&pd_pu>;
property.

For i.MX6QDL there is only one power domain that can be disabled at runtime,
on i.MX6SL there is an additional DISPLAY power domain, which is not yet
handled by the code.

Changes since v1:
 - Added device tree binding documentation
 - Removed a superfluous comment in gpc.c
 - Changed the power domain compatible to be less generic
 - Link PU domain with its DT node, check for PU domain in bus notifier
 - Turn off the PU power domain on boot
 - Renamed power-domain node to pu-power-domain and added cpu-power-domain
   for i.MX6QDL
 - Added dts patch for i.MX6SL

regards
Philipp

Philipp Zabel (7):
  Documentation: Add device tree bindings for Freescale i.MX GPC
  ARM: imx6: gpc: Add PU power domain for GPU/VPU
  ARM: imx6: gpc: Add pm clock support to PU power domain
  ARM: imx6: gpc: Add observed worst case latencies
  ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp
    delay
  ARM: dts: imx6qdl: Add power-domain information to gpc node
  ARM: dts: imx6sl: Add power-domain information to gpc node

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  61 +++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |  16 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  18 ++
 arch/arm/mach-imx/Kconfig                          |   2 +
 arch/arm/mach-imx/gpc.c                            | 253 +++++++++++++++++++++
 5 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt

-- 
1.8.5.3
