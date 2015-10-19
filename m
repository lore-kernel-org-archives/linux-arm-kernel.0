From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 19 Oct 2015 14:32:22 -0300
Subject: [PATCH v2 0/4] Add support for NXP LPC18xx EEPROM using nvmem
Message-ID: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for NXP LPC18xx EEPROM memory found in
NXP LPC185x/3x and LPC435x/3x/2x/1x devices.

This patchset is based on tag next-20151019 of the linux-next
repository. It has been successfully tested on a LPC4337 CIAA-NXP
Board.

EEPROM notes:
------------

EEPROM size is 16384 bytes and it can be entirely read and 
written/erased with 1 word (4 bytes) granularity. The last page
(128 bytes) contains the EEPROM initialization data and is not writable.

Erase/program time is less than 3ms. The EEPROM device requires a
~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
the system bus clock by the division factor, contained in the divider
register (minus 1 encoded).

Changeset:
---------
v1 -> v2:
* Moved dt-bindings to be the first patch.
* Changed compatible name from lpc1850 to lpc1857 as the former doesn't have EEPROM.
* Fix hardware description which contained SoCs models without EEPROM.
* Disabled fast_io and changed mdelay for msleep in regmap writes.
* Replaced BUG_ON() in write function for an -EINVAL return.
* Add patches for defconfig and devicetree files.

Thanks,

Ariel D'Alessandro (4):
  DT: nvmem: Add NXP LPC18xx EEPROM memory binding documentation
  nvmem: NXP LPC18xx EEPROM memory NVMEM driver
  ARM: dts: lpc18xx: add EEPROM memory node
  ARM: configs: lpc18xx: enable EEPROM NVMEM driver

 .../devicetree/bindings/nvmem/lpc1857-eeprom.txt   |  26 ++
 arch/arm/boot/dts/lpc18xx.dtsi                     |  12 +
 arch/arm/configs/lpc18xx_defconfig                 |   2 +
 drivers/nvmem/Kconfig                              |   9 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/lpc18xx_eeprom.c                     | 266 +++++++++++++++++++++
 6 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
 create mode 100644 drivers/nvmem/lpc18xx_eeprom.c

-- 
2.6.1
