From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 11:29:51 +0800
Subject: [PATCH 0/2] mfd: axp20x: Fix AXP806 access errors on cold boot
Message-ID: <20161111032953.20849-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Recently we've added full SPL support for A80 to mainline U-boot. This
means we no longer depend on Allwinner's bootloader. It also means that
some of system configuration the bootloader set up no longer applies.

The bootloader was correctly configuring the multi-device addressing
support in the AXP806 PMIC. If the PMIC is not correctly addressed, it
just ignores all reads and writes to the other registers. As mainline
U-boot does not support the AXP806, and since we can't always count on
a good bootloader, we should re-configure this in the kernel regardless.

Patch 1 adds the registers for the multi-device addressing scheme to
the AXP806 regmap.

Patch 2 configures the register at probe time, and reinitializes the
regmap cache.

Since support for this PMIC was just added in 4.9-rc1, I hope you can
merge these 2 patches as fixes for 4.9.

Thank you!


Regards
ChenYu


Chen-Yu Tsai (2):
  mfd: axp20x: Add address extension registers for AXP806 regmap
  mfd: axp20x: Fix AXP806 access errors on cold boot

 drivers/mfd/axp20x.c       | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/axp20x.h |  2 ++
 2 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.10.2
