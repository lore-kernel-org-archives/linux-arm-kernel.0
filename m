From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  2 Sep 2014 09:50:13 +0200
Subject: [PATCH 0/5] clk: at91: fix USB clk support on at91rm9200/sam9 SoCs
Message-ID: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series fixes several bugs in the PLL driver preventing a proper
set_rate on the PLL clk.
It also enables propagation of set_rate request on the USB clk in order to
configure the PLL rate according to the USB block requirement (48 MHz).

Note that existing kernels, relying on the PLL configuration made by the
the bootloader should not be impacted by this bug, but others (those
directly booting from at91bootstrap or not enabling USB support in the
bootloader) will be.

This bug was reported by Ga?l, who's directly booting the kernel from the
bootstrap.

Best Regards,

Boris

Boris BREZILLON (5):
  clk: at91: fix PLL_MAX_COUNT macro definition
  clk: at91: rework PLL rate calculation
  clk: at91: fix recalc_rate implementation of PLL driver
  clk: at91: rework rm9200 USB clock to propagate set_rate to the parent
    clk
  clk: at91: fix div by zero in USB clock driver

 drivers/clk/at91/clk-pll.c | 160 +++++++++++++++++++++++----------------------
 drivers/clk/at91/clk-usb.c |  20 ++++--
 2 files changed, 96 insertions(+), 84 deletions(-)

-- 
1.9.1
