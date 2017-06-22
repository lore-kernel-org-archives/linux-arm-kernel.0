From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jun 2017 12:08:27 +0800
Subject: [PATCH 0/6] mfd: axp20x: Add basic support for AXP813
Message-ID: <20170622040833.15329-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds basic device tree bindings and driver support for the
AXP813/818 PMICs. The two models are identical when comparing their
datasheets. These PMICs are actually two dies in one package: one being
the actual PMIC, the other being an AC100 codec/RTC combo chip. The
latter has its own device tree binding.

This series only adds the basic parts of the device tree binding and
driver. For the bindings, only the core and regulator bits are added.
Any sub-devices that have their own binding will be updated later on.
For the driver, only the mfd part with a basic power button (PEK) cell
is added, along with regulator IDs. I hope that this part can be merged
for 4.13, so I can work on the regulators for 4.14, and we won't have
any cross tree compile time dependencies.

The device tree changes depend on my R_INTC patches I sent earlier,
which are waiting on irqchip driver changes to be merged first.

To recap, I hope the mfd bits can be merged for 4.13, while the device
tree stuff will have to wait for 4.14.

Patch 1 adds AXP806 to the main list of supported chips, which was
missing.

Patch 2 adds bindings for the AXP813.

Patch 3 adds basic mfd driver support with PEK enabled for AXP813.

Patch 4 adds the device node and pinmux settings for the RSB controller
on the A83T. This is used to communicate with the PMIC.

Patch 5 adds a device node for the PMIC part of the chip.

Patch 6 adds a device node for the embedded AC100 part of the chip.


Regards
ChenYu


Chen-Yu Tsai (6):
  dt-bindings: mfd: axp20x: Add AXP806 to supported list of chips
  dt-bindings: mfd: axp20x: Introduce bindings for AXP813
  mfd: axp20x: Add support for AXP813 PMIC
  ARM: sun8i: a83t: Add device node and pinmux setting for RSB
    controller
  ARM: sun8i: a83t: Add device node for AXP813 PMIC
  ARM: sun8i: a83t: Enable AC100 codec / RTC combo chip in AXP813 PMIC

 Documentation/devicetree/bindings/mfd/axp20x.txt | 50 +++++++++++++++++++++---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 35 +++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                | 22 +++++++++++
 drivers/mfd/axp20x-rsb.c                         |  1 +
 drivers/mfd/axp20x.c                             | 22 +++++++++++
 include/linux/mfd/axp20x.h                       | 29 ++++++++++++++
 6 files changed, 154 insertions(+), 5 deletions(-)

-- 
2.11.0
