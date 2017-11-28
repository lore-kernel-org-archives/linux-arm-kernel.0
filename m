From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 28 Nov 2017 11:49:58 +0800
Subject: [PATCH 0/4] add support of pinctrl to MT7622 SoC
Message-ID: <cover.1511840374.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The patchset adds support for pinctrl on MT7622 SoC.

patch 1: describe the hardware, also including the defintion for pins,
	 groups and function.
patch 2: add cleanup for keep drivers inside the independent menu.
patch 3/4: add support for mt7622 SoC.

The IO core found on the SoC has the registers for pinctrl, pinconf and
gpio mixed up in the same register range.

However, the IO core for the MT7622 SoC is completely distinct from
anyone of previous MediaTek SoCs which already had support, such as the
hardware internal, register address map and register detailed definition
for each pin.

Therefore, instead, the driver is being newly implemented by reusing
generic methods provided from the core layer with GENERIC_PINCONF,
GENERIC_PINCTRL_GROUPS, and GENERIC_PINMUX_FUNCTIONS for the sake of code
simplicity and avoiding superfluous code. Where the function of pins
determined by groups is utilized in this driver which can help developers
less confused with what combinations of pins effective on the SoC and
even reducing the mistakes during the integration of those relevant
boards.

As the gpio_chip handling is also only a few lines, the driver also
implements the gpio functionality directly through GPIOLIB.

Sean Wang (4):
  dt-bindings: pinctrl: add bindings for MediaTek MT7622 SoC
  pinctrl: mediatek: cleanup for placing all drivers under the menu
  pinctrl: mediatek: add pinctrl driver for MT7622 SoC
  pinctrl: mediatek: update MAINTAINERS entry with MediaTek pinctrl
    driver

 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |  330 +++++
 MAINTAINERS                                        |   10 +
 drivers/pinctrl/Makefile                           |    2 +-
 drivers/pinctrl/mediatek/Kconfig                   |   15 +-
 drivers/pinctrl/mediatek/Makefile                  |    3 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          | 1536 ++++++++++++++++++++
 6 files changed, 1892 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7622.c

-- 
2.7.4
