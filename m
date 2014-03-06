From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu,  6 Mar 2014 10:58:43 +0100
Subject: [PATCH v6 0/5] i.MX6 PU power domain support
Message-ID: <1394099928-19901-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

in this version I fixed the issues Shawn pointed out last time.
Old blurb, fast-forward if you followed previous iterations:

The i.MX6Q can gate off the CPU and PU (GPU/VPU) power domains using the
Power Gating Controller (PGC) in the GPC register space. The CPU power
domain is already handled by wait state code, but the PU power domain can
be controlled using the generic power domain framework and power off the PU
supply regulator if all devices in the power domain are (runtime) suspended.

This patchset adds a GPC platform device initialized at subsys_initcall time
(after anatop regulators) that binds to the gpc device tree node and sets up
the PU power domain. The GPC node becomes a power-controller as defined by
Tomasz' OF power domain bindings. This series depends on the patches
    "drivercore: Bind/unbind power domain on probe/remove" and
    "base: power: Add generic OF-based power domain look-up".

Changes since v5:
 - Fixed compilation for !CONFIG_PM case
 - Added #define for clock array size
 - Keep "fsl,imx6q-gpc" compatible value for i.MX6SL gpc node

Philipp Zabel (5):
  Documentation: Add device tree bindings for Freescale i.MX GPC
  ARM: imx6: gpc: Add PU power domain for GPU/VPU
  ARM: dts: imx6qdl: Add power-domain information to gpc node
  ARM: dts: imx6sl: Add power-domain information to gpc node
  ARM: dts: imx6qdl: Allow disabling the PU regulator, add a enable ramp
    delay

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  54 ++++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   7 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   4 +
 arch/arm/mach-imx/Kconfig                          |   1 +
 arch/arm/mach-imx/gpc.c                            | 203 +++++++++++++++++++++
 5 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt

-- 
1.9.0
