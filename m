From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Fri, 31 Mar 2017 22:25:35 +0300
Subject: [PATCH 0/5] ARM: imx: Set LDO regulator supply
Message-ID: <cover.1490987945.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the LDO regulator parent is optional but beneficial. It will cause
the PMIC output voltage to be dynamically set to the minimum input for the
LDOs, this should be more efficient.

This propagation was introduced by:
commit fc42112c0eaa ("regulator: core: Propagate voltage changes to supply
regulators")

In this case it is desirable that the parent regulator sets the minimum
voltage for it's consumers. It's not clear if this behavior from the
regulator core is entirely intentional. If it's not then perhaps it should
be made configurable through DT somehow?

This makes probe order more complicated, fix that in patches 1 and 2.

It can also break suspend because cpufreq voltage switches can end up
talking to a PMIC via I2C which is already suspended. This is fixed in
patch 3.

It's good to have these issues fixed upstream because they might affect
other complex configurations.

These changes are required for LDO bypass but they are also useful
standalone. Here's a link to the that other discussion:
https://lkml.org/lkml/2017/3/22/640

Irina Tirdea (1):
  cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator

Leonard Crestez (4):
  ARM: imx: gpc: Do not print error message for EPROBE_DEFER
  cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend
  ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
  ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qp-sabresd.dts   |  4 ++--
 arch/arm/mach-imx/gpc.c                |  6 +++++-
 drivers/cpufreq/imx6q-cpufreq.c        |  9 +++++++++
 4 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.7.4
