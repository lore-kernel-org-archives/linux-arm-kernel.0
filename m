From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 26 Nov 2013 10:05:41 +0200
Subject: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
Message-ID: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to v9:
- rebased on top of 3.13-rc1
- modified the low level clk register API to provide SoC specific clk_readl
  and clk_writel support which can be registered during boot, TI SoC variant
  uses regmap on low level
- dropped regmap parameter from clock init calls, instead a helper is used
  for getting regmap index along with the register offset from DT
- dropped regmap parameter from clock structs, instead platform specific
  clk_readl / clk_writel are used to parse reg parameter according to
  platform, for TI SoC:s, this is encoded as:
  struct clk_omap_reg {
    u16 offset; /* register offset */
    u16 index; /* regmap index */
  }
- Nishanth's comments to v9 mostly addressed, except for the CLK_OF_DECLARE
  tweak which I would actually want some feedback upon, basically the problem
  is I need to return status from the clk init functions so I can see if
  -EAGAIN is passed, in which case init will be retried later, maybe some of
  this can be made generic, like converting all the CLK_OF_DECLARE type
  functions to return status

Testing done:
- omap3-beagle : boot + suspend/resume
- omap3-beagle-xm : boot (thanks to Nishanth)
- omap4-panda-es : boot + suspend/resume
- omap5-uevm : boot
- dra7-evm : boot
- am335x-bone : boot

Separate branches available at https://github.com/t-kristo/linux-pm.git

- full: 3.13-rc1-dt-clks-v10 (should be merged last, contains everything)
- clk driver only: 3.13-rc1-dt-clks-v10-for-mike
- DT data only: 3.13-rc1-dt-clks-v10-for-benoit

-Tero
