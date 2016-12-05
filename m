From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon,  5 Dec 2016 11:09:06 +0100
Subject: [PATCH v3 0/3] ARM: da850: fix pll0 rate setting
Message-ID: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to set the pll0 rate from the kernel I noticed there are
two issues with da850 clocks. The first patch fixes an infinite loop
in propagate_rate(). The third fixes an oops in da850_set_pll0rate().
The second patch is just a coding style fix, while we're at it.

v1 -> v2:
- change the approach in 1/3: create a new clock for nand inheriting
  the rate from the aemif clock (verified that nand still works on
  da850-lcdk)
- patch 3/3: also update the davinci_cpufreq driver - the only
  (indirect) user of da850_set_pll0rate()
- s/requested_rate/rate in 3/3

v2 -> v3:
- 1/3: keep the "aemif" connector id for the nand clock
- 3/3: instead of multiplying freq->frequency, divide rate by 1000
- retested both davinci_nand and clk_set_rate() for pll0

Bartosz Golaszewski (3):
  ARM: da850: fix infinite loop in clk_set_rate()
  ARM: da850: coding style fix
  ARM: da850: fix da850_set_pll0rate()

 arch/arm/mach-davinci/da850.c     | 29 +++++++++++++++++++++++------
 drivers/cpufreq/davinci-cpufreq.c |  2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.9.3
