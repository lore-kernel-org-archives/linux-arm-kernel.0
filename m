From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 11 Sep 2017 22:00:59 +0900
Subject: [PATCH 0/5] nvmem: some cleanups and sparse warning fixes
Message-ID: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Socionext is trying to add a new nvmem driver.

Before adding a new one, I'd like to be sure about the preferred
coding style in this subsystem, and build-up cleaner code base.

Please pick up what you like.  Please feel free to throw away
what you do not like.

1/5, 2/5: convert kzalloc to stack because nvmem_config
is small one-time use data.
This is what we agreed in the discussion.

3/5, 4/5: fix sparse warning
For mtk-efuse, qfprom, the base address is the only private data
but, assigning (void __iomem *) to ->priv directly causes sparse
warnings.

5/5: clean-up of owner settings - if the owner field matches
nvmem->dev->driver->onwer, we need not set the onwer field
explicitly.



Masahiro Yamada (5):
  nvmem: imx-iim: use stack for nvmem_config instead of malloc'ing it
  nvmem: mtk-efuse: use stack for nvmem_config instead of malloc'ing it
  nvmem: mtk-efuse: fix different address space warnings of sparse
  nvmem: qfprom: fix different address space warnings of sparse
  nvmem: set nvmem->owner to nvmem->dev->driver->owner if unset

 drivers/nvmem/bcm-ocotp.c      |  1 -
 drivers/nvmem/core.c           |  2 ++
 drivers/nvmem/imx-iim.c        | 24 +++++++++------------
 drivers/nvmem/imx-ocotp.c      |  1 -
 drivers/nvmem/lpc18xx_eeprom.c |  1 -
 drivers/nvmem/lpc18xx_otp.c    |  1 -
 drivers/nvmem/meson-efuse.c    |  1 -
 drivers/nvmem/mtk-efuse.c      | 47 ++++++++++++++++++++++--------------------
 drivers/nvmem/mxs-ocotp.c      |  1 -
 drivers/nvmem/qfprom.c         | 27 +++++++++++++++---------
 drivers/nvmem/rockchip-efuse.c |  1 -
 drivers/nvmem/sunxi_sid.c      |  1 -
 drivers/nvmem/vf610-ocotp.c    |  1 -
 13 files changed, 54 insertions(+), 55 deletions(-)

-- 
2.7.4
