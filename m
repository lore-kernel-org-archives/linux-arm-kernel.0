From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:04 +0100
Subject: [PATCH 00/12] nvmem: remove regmap dependency
Message-ID: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nvmem uses regmap_raw_read/write apis to read/write data from providers,
With recent patch 922a9f936e40 ("regmap: mmio: Convert to regmap_bus
and fix accessor usage") nvmem providers based on regmap-mmio stopped
working, as nvmem core was using raw accessors.
This issue can be fixed temporarly by moving to other regmap apis,
but we might hit same issue in future, and regmap looks like an
overdo for nvmem. Moving to interfaces based on read/write callbacks
from providers would be more robust.

This patchset converts the nvmem core and nvmem provider drivers to
use the new callbacks. Tested this patchset on qfprom and at24 drivers.
Other driver are only compile tested, any testing on them would be great.

Thanks,
srini

Srinivas Kandagatla (12):
  nvmem: core: remove regmap dependency
  eeprom: at24: remove nvmem regmap dependency
  eeprom: at25: remove nvmem regmap dependency
  nvmem: qfprom: remove nvmem regmap dependency
  nvmem: vif610-ocotp: remove nvmem regmap dependency
  nvmem: sunxi-sid: remove nvmem regmap dependency
  nvmem: rockchip-efuse: remove nvmem regmap dependency
  nvmem: mtk-efuse: remove nvmem regmap dependency
  nvmem: imx-ocotp: remove nvmem regmap dependency
  nvmem: lpc18xx-eeprom: remove nvmem regmap dependency
  nvmem: mxs-ocotp: remove nvmem regmap dependency
  nvmem: 93xx46: remove nvmem regmap dependency

 drivers/misc/eeprom/Kconfig         |   2 -
 drivers/misc/eeprom/at24.c          | 103 ++++++++----------------------------
 drivers/misc/eeprom/at25.c          |  89 +++++++------------------------
 drivers/misc/eeprom/eeprom_93xx46.c |  90 +++++++------------------------
 drivers/nvmem/Kconfig               |   4 --
 drivers/nvmem/core.c                |  67 +++++++++++++----------
 drivers/nvmem/imx-ocotp.c           |  55 ++++---------------
 drivers/nvmem/lpc18xx_eeprom.c      |  94 +++++++++-----------------------
 drivers/nvmem/mtk-efuse.c           |  47 ++++++++++------
 drivers/nvmem/mxs-ocotp.c           |  79 ++++++++-------------------
 drivers/nvmem/qfprom.c              |  56 +++++++++++++-------
 drivers/nvmem/rockchip-efuse.c      |  49 ++++-------------
 drivers/nvmem/sunxi_sid.c           |  54 ++++---------------
 drivers/nvmem/vf610-ocotp.c         |  44 ++++-----------
 include/linux/nvmem-provider.h      |  10 ++++
 15 files changed, 264 insertions(+), 579 deletions(-)

-- 
2.5.0
