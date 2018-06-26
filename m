From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 26 Jun 2018 12:22:30 +0200
Subject: [PATCH v2 00/15] ARM: davinci: step towards removing
 at24_platform_data
Message-ID: <20180626102245.30711-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since I took over maintainership of the at24 driver I've been working
towards removing at24_platform_data in favor for device properties.

DaVinci is the only platform that's still using it - all other users
have already been converted.

One of the obstacles in case of DaVinci is removing the setup() callback
from the pdata struct, the only user of which are some davinci boards.

Most boards use the EEPROM to store the MAC address. This series adds
support for cell lookups to the nvmem framework, registers relevant
cells for all users, converts the davinci_emac driver to using them
and replaces at24_platform_data with device properties.

The only board that's still using this callback is now mityomapl138.
Unfortunately it stores more info in EEPROM than just the MAC address
and will require some more work. Unfortunately I don't have access
to this board so I can't test any actual solutions on a live hardware.

Tested on a dm365-evm board.

v1 -> v2:
- for backward compatiblity: fall back to using of_get_mac_address() if
  we can't get an nvmem cell in patch 7
- add patch 15 which removes dead code

Bartosz Golaszewski (15):
  nvmem: add support for cell lookups
  ARM: davinci: dm365-evm: use nvmem lookup for mac address
  ARM: davinci: dm644-evm: use nvmem lookup for mac address
  ARM: davinci: dm646x-evm: use nvmem lookup for mac address
  ARM: davinci: da830-evm: use nvmem lookup for mac address
  ARM: davinci: mityomapl138: add nvmem cells lookup entries
  net: davinci_emac: use nvmem to retrieve the mac address
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code

 arch/arm/mach-davinci/board-da830-evm.c    | 25 +++++++---
 arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++++---
 arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++++---
 arch/arm/mach-davinci/board-dm646x-evm.c   | 25 +++++++---
 arch/arm/mach-davinci/board-mityomapl138.c | 30 +++++++++---
 arch/arm/mach-davinci/board-sffsdr.c       | 13 +++--
 arch/arm/mach-davinci/common.c             | 15 ------
 drivers/net/ethernet/ti/davinci_emac.c     | 33 +++++++++----
 drivers/nvmem/core.c                       | 57 +++++++++++++++++++++-
 include/linux/davinci_emac.h               |  2 -
 include/linux/nvmem-consumer.h             |  6 +++
 include/linux/nvmem-provider.h             |  6 +++
 12 files changed, 186 insertions(+), 75 deletions(-)

-- 
2.17.1
