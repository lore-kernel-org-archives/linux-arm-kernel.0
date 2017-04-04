From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 4 Apr 2017 20:04:10 +0300
Subject: [PATCH v2 0/4] ARM: imx: Set LDO regulator supply
Message-ID: <cover.1491324640.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the LDO regulator parent is optional but beneficial. It will cause
the PMIC output voltage to be dynamically set to the minimum input for the
LDOs, this should be more efficient.

This propagation was introduced by:
commit fc42112c0eaa ("regulator: core: Propagate voltage changes to supply
regulators")

Changes since v1:
 * Drop patch 1 since it only avoids logging a warning and the gpc driver
is going through more changes.
 * Initialize cpufreq->suspend_freq based on policy->max instead.
 * Remove reference to ldo-bypass from suspend_freq patch message.

It's not clear if policy->cpuinfo.max would be preferable, at init time
they should be identical.

Link: https://lkml.org/lkml/2017/3/31/683

Irina Tirdea (1):
  cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator

Leonard Crestez (3):
  cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend
  ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
  ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qp-sabresd.dts   |  4 ++--
 drivers/cpufreq/imx6q-cpufreq.c        | 15 ++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.7.4
