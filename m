From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 12 Feb 2018 13:39:43 +0100
Subject: [PATCHv4 0/2] Improved perf support for imx53/ppd
Message-ID: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This improves perf on imx53 by adding support for enabling the Secure
Debug Enable Register (SDER) SUNIDEN bit. This unlocks new
functionality:

ppd before patchset# perf stat -e cycles,instructions sleep 1 2>&1 | grep instructions
                 0      instructions              #    0.00  insn per cycle

ppd  after patchset# perf stat -e cycles,instructions sleep 1 2>&1 | grep instructions
            177864      instructions              #    0.05  insn per cycle

Changes since PATCHV3:
 * Use readl_relaxed instead of __raw_readl (and the same for writel)
 * Drop final return in void function
 * Add Reviewed-by from Fabio to 2nd patch
Changes since PATCHv2:
 * Always enable GPC_DBG_EN when kernel configuration allows using perf
   to allow cleanup of the arm-pmu driver.
Changes since PATCHv1:
 * Update DTS patch to reference imx53.dtsi's pmu node
 * Remove a superfluous newline in first patch

-- Sebastian

Sebastian Reichel (2):
  ARM: imx53: add secure-reg-access support for PMU
  ARM: dts: imx53: PPD: Enable secure-reg-access

 arch/arm/boot/dts/imx53-ppd.dts |  4 ++++
 arch/arm/boot/dts/imx53.dtsi    |  2 +-
 arch/arm/mach-imx/mach-imx53.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.15.1
