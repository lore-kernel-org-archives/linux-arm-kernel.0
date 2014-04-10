From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 14:25:42 +0200
Subject: [PATCH v2 0/5] ARM: sunxi: add multi pin controller support
Message-ID: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series rework the sunxi pinctrl driver to support the PL and PM
pins available on the A31 SoC, which are controlled using the R_PIO
block.

This series add support for multi pin controller which was previously
impossible for several reasons:
1) the pinctrl instance was registering a static instance of the gpio
   chip, which means, in case you were probing 2 devices, the gpio chip
   was added twice to the gpiochip list
2) the base pin of the gpio chip was always set to 0, and thus the 2
   gpiochip pin numbers were overlapping

I still haven't reworked the interrupt part (to handle the "per bank
interrupt" instead of the "one interrupt for the whole gpio" chip
approach), but this will be part of another series.

Best Regards,

Boris

Changes since v1:
 - rework the pinctrl driver to support multiple pin controller instances
 - removed reset and clock gate patches from the series
 - removed A31 DT modifications from the series (we need to get the PRCM
 reset and clk drivers before being able to declare the r_pio node, and
 we're still discussing how this should be implemented)

Boris BREZILLON (5):
  pinctrl: sunxi: add PL and PM pin definitions
  pinctrl: sunxi: support multiple pin controller
  pinctrl: sunxi: define A31 R_PIO pin functions
  pinctrl: sunxi: add reset control support
  ARM: sunxi: update the default ARCH_NR_GPIO for sunxi arch

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |  1 +
 arch/arm/Kconfig                                   |  2 +-
 drivers/pinctrl/pinctrl-sunxi-pins.h               | 74 ++++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.c                    | 40 +++++++-----
 drivers/pinctrl/pinctrl-sunxi.h                    | 69 ++++++++++++++++++++
 5 files changed, 169 insertions(+), 17 deletions(-)

-- 
1.8.3.2
