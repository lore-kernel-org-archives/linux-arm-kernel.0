From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:46:52 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes,
 cleanups and improvements
Message-ID: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This fairly long series of patches implement numerous fixes, cleanups
and improvements to the description of the MPP pins on Armada 370,
375, 38x, 39x and XP.

The original motivation was a bug report mentioning some
inconsistencies between the Armada 38x HW datasheet and the
corresponding pinctrl driver. Even though I had already written some
basic Python script to extract the MPP data from the datasheet, and do
some of the code generation steps automatically, a good part of the
process was still manual, which means: 1/ mistakes can be made, 2/
it's not easy to update with new versions of the datasheets that fix
bugs in the MPP description.

Therefore, I improved my Python scripts, and now the MPP tables in the
pinctrl drivers are automatically generated from the datasheet HW
information. The script in question is quite ugly, as it takes into
account some existing inconsistencies in the formatting of the
different pinctrl drivers, and also different naming choices between
Linux and the HW datasheet. But nonetheless, it has been very useful
to bring all the pinctrl drivers in sync with the datasheet, and to
detect inconsistencies between the pinctrl drivers.

This long series of patches is the result of this work, and can be
separated in three parts:

 * The "fixes", which are marked for stable because they fix some real
   potential problems. These are patches 1 to 9 included.

 * The "cleanups", which are not doing anything really interesting
   except renaming things to progressively make drivers more
   consistent with each other and with the datasheets. These are
   patches 10 to 24 included.

 * The "improvements", which are actually adding pin functions that
   were not supported earlier, or even a new SoC completely such as
   the Armada 395 (as part of the armada-39x driver). These are
   patches 25 to 34 included.

Some of the patches are breaking the DT backward compatibility, but
most of them are doing that on pins that are highly unlikely to be
used with a mainline kernel. The only real concern could be with patch
21 that renames the function "spi" on Armada XP to "spi0" to match the
datasheet and to prepare for the addition of the "spi1" function. If
that is considered to be a too serious breakage, then we can imagine
leaving "spi" for the first SPI bus and use "spi1" for the second SPI
bus. I can rework the patch series to adjust this if deemed necessary.

In some cases, I have decided to not make drivers match to not break
the DT backward compatibility. For example, some drivers use
uart0/uart1, while some others use ua0/ua1 (like in the Marvell
datasheets), and I've left this inconsistency as is (my script copes
with it).

In addition to the fixes to the MPP lists themselves, two patches are
fixing the pinctrl_gpio_range[] definitions, which were wrong for
Armada 38x and Armada 39x.

I wish you good luck when reviewing this. It was boring to do, so I
guess it is going to be horribly boring to review :-)

Best regards,

Thomas

Thomas Petazzoni (34):
  pinctrl: mvebu: armada-38x: fix PCIe functions
  pinctrl: mvebu: armada-370: fix spi0 pin description
  pinctrl: mvebu: armada-375: remove non-existing NAND re/we pins
  pinctrl: mvebu: armada-xp: remove non-existing NAND pins
  pinctrl: mvebu: armada-xp: remove non-existing VDD cpu_pd functions
  pinctrl: mvebu: armada-xp: fix functions of MPP48
  pinctrl: mvebu: armada-375: remove incorrect space in pin description
  pinctrl: mvebu: armada-38x: fix incorrect total number of GPIOs
  pinctrl: mvebu: armada-39x: fix incorrect total number of GPIOs
  pinctrl: mvebu: armada-{375,38x,39x}: normalize naming of PTP subnames
  pinctrl: mvebu: armada-{38x,39x,xp}: normalize naming of DRAM
    functions
  pinctrl: mvebu: armada-39x: normalize SATA present functionality
    naming
  pinctrl: mvebu: armada-39x: normalize SDIO pin naming
  pinctrl: mvebu: armada-{370,375,38x,39x}: normalize dev pins
  pinctrl: mvebu: armada-39x: align NAND pin naming
  pinctrl: mvebu: armada-{370,375,38x,39x,xp}: normalize TDM pins
  pinctrl: mvebu: armada-{370,375}: normalize PCIe pins
  pinctrl: mvebu: armada-{370,375}: normalize audio pins
  pinctrl: mvebu: armada-{370,xp}: normalize ethernet txclkout pins
  pinctrl: mvebu: armada-xp: fix binding documentation of ge1 pins
  pinctrl: mvebu: armada-370: align VDD cpu-pd pin naming with datasheet
  pinctrl: mvebu: armada-370: align spi1 clock pin naming
  pinctrl: mvebu: armada-xp: rename spi to spi0
  pinctrl: mvebu: armada-39x: normalize ref clock naming
  pinctrl: mvebu: armada-xp: add spi1 function
  pinctrl: mvebu: armada-xp: add nand rb function
  pinctrl: mvebu: armada-xp: add dram functions
  pinctrl: mvebu: armada-38x: add sata functions
  pinctrl: mvebu: armada-38x: add nand functions
  pinctrl: mvebu: armada-38x: add ua1 functions
  pinctrl: mvebu: armada-38x: add ptp functions
  pinctrl: mvebu: armada-39x: add missing PCIe functions
  pinctrl: mvebu: armada-39x: add missing SATA functions
  pinctrl: mvebu: armada-39x: add support for Armada 395 variant

 .../pinctrl/marvell,armada-370-pinctrl.txt         |  18 +--
 .../pinctrl/marvell,armada-375-pinctrl.txt         |  34 +++---
 .../pinctrl/marvell,armada-38x-pinctrl.txt         |  66 +++++------
 .../pinctrl/marvell,armada-39x-pinctrl.txt         |  84 +++++++------
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |  80 ++++++-------
 drivers/pinctrl/mvebu/pinctrl-armada-370.c         |  22 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-375.c         |  50 ++++----
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c         | 120 ++++++++++---------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 131 ++++++++++++---------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          |  98 +++++++--------
 10 files changed, 363 insertions(+), 340 deletions(-)

-- 
2.1.0
