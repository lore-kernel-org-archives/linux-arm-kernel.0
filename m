From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Feb 2014 14:27:07 +0100
Subject: [RFC PATCH 0/4] i.MX6 PU power domain support
Message-ID: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
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

		pd_pu: power-domain at 020dc260 {
			compatible = "fsl,power-domain";
			reg = <0x020dc260 0x10>;
		};
	};

It registers a platform bus notifier so that it can add GPU and VPU devices
to the power domain when they are bound. If finds devices to be added to the
power domain by scanning the device tree for nodes that contain a
	power-domain = <&pd_pu>;
property.

For i.MX6QDL there is only one power domain, but on i.MX6SL I suspect the
DISP power domain could be handled using the same mechanism.

regards
Philipp

Philipp Zabel (4):
  ARM: imx6: gpc: Add PU power domain for GPU/VPU
  ARM: imx6: gpc: Add pm clock support to PU power domain
  ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp
    delay
  ARM: dts: imx6qdl: Add PU power-domain information to gpc node

 arch/arm/boot/dts/imx6qdl.dtsi |  11 +-
 arch/arm/mach-imx/Kconfig      |   2 +
 arch/arm/mach-imx/gpc.c        | 243 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+), 1 deletion(-)

-- 
1.8.5.3
