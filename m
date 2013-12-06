From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Dec 2013 12:32:11 +0100
Subject: [PATCH v7 0/3] mfd: max14577: Add max14577 MFD drivers
Message-ID: <1386329534-14186-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is seventh version of patchset adding drivers for MAXIM 14577 chip.
Some parts (MFD, extcon) were already merged by maintainers so I removed them
from the patchset.

This version of patchset depends on the max14577 MFD core driver:
 - mfd: max14577: Add max14577 MFD driver core
   Merged in: git://git.linaro.org/people/ljones/mfd.git
   https://git.linaro.org/gitweb?p=people/ljones/mfd.git;a=commit;h=47ae80d7c147caa07165fcac078c26fbe87bfc28


Description
-----------
The chip contains Micro-USB Interface Circuit and Li+ Battery Charger.
It contains accessory and USB charger detection logic. It supports USB 2.0
Hi-Speed, UART and stereo audio signals over Micro-USB connector.

The battery charger is compliant with the USB Battery Charging Specification
Revision 1.1. It has also SFOUT LDO output for powering USB devices.

The patchset consists of following drivers:
1. MFD core driver. (applied by Lee Jones)
2. Extcon driver for the MUIC (Micro USB Interface Controller). (applied
   by Chanwoo Choi)
3. Charger driver using power supply class.
4. Regulator driver for SFOUT and charger.
5. Documentation of device tree bindings.

The patchset is rebased on latest Linus' tree (v3.13-rc2-122-gdea4f48a0a30)
however testing was mostly done on 3.10.


Changes since v6:
-----------------
1. Documentation of bindings: Applied changes pointed by Chanwoo Choi
   and Lee Jones.

Changes since v5:
-----------------
1. Patches "mfd: max14577: Add max14577 MFD driver core" and "mfd: max14577:
   Match regulator by of_compatible string" were applied by Lee Jones to his
   tree.
2. Patch "extcon: max14577: Add extcon-max14577 driver to support MUIC device"
   were applied by Chanwoo Choi to his tree.
3. Regulator (2/3): Use of_get_child_by_name() to match regulators node from DT.

Changes since v4:
-----------------
1. Split MFD changes from regulator patch.

Changes since v3:
-----------------
1. Applied suggestions from Lee Jones and Alexander Shiyan.
2. Extcon (2/5): Use system_power_efficient_wq for delayed cable detection
   (pointed by Mark Brown).
3. Regulator (4/5): Add compatible string to regulators node so MFD core will
   match it to the driver. Simplify and fix DT parsing. (Lee Jones)
4. Regulator (4/5): Get rid of regulators variable. (Bartlomiej Zolnierkiewicz).

Changes since v2:
-----------------
1. Replaced max14577-irq.c with regmap_irq_chip, as suggested by Mark Brown.
2. Applied suggestions from review (Mark Brown, Lee Jones).
3. Regulator: Added registering unconditionally of all regulators (Mark Brown).
4. Regulator: Removed the "struct max14577_regulator *info" (Bartlomiej
   Zolnierkiewicz).
5. Extcon: Removed work-around for hardware reboot (USB cable attached with
   factory button set to D/L mode) as it is not needed.

Changes since v1:
-----------------
1. Applied comments from review (Mark Brown, Mark Rutland).
2. Removed any DT bindings which are not needed.
3. Removed "wakeup" node from bindings.
4. Fixed interrupt handling during resume. This lead to removal of the weird
   IRQ/GPIO code discussed during review.
5. Minor fixes pointed by checkpatch, added authors.
6. Use of_get_child_by_name() for accessing regulators bindings.
7. Added documentation of bindings (fifth patch).

Best regards,
Krzysztof Kozlowski


Krzysztof Kozlowski (3):
  charger: max14577: Add charger support for Maxim 14577
  regulator: max14577: Add regulator driver for Maxim 14577
  mfd: max14577: Add device tree bindings document

 Documentation/devicetree/bindings/mfd/max14577.txt |   65 ++++
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/max14577_charger.c                   |  311 ++++++++++++++++++++
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/max14577.c                       |  272 +++++++++++++++++
 7 files changed, 664 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 create mode 100644 drivers/power/max14577_charger.c
 create mode 100644 drivers/regulator/max14577.c

-- 
1.7.9.5
