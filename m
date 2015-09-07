From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon,  7 Sep 2015 16:48:34 +0530
Subject: [PATCH-v2 0/7] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI
 controller
Message-ID: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA1928 SDHCI controller has few differences, for example,

                         PXAxxx                    PXA1928
                         ======                    =======
 SDCLK_DELAY field       0x10A                     0x114
 SDCLK_DELAY mask        0x1F                      0x3FF
 SDCLK_DELAY shift        9                          8
 SDCLK_SEL shift          8                          2 (SEL1)

So this patch series introduces new compatible device_id
(marvell,pxav3-1928-sdhci), and makes use of .data for handling
such differences.

The series also adds support like,

 - independent ->set_clock() api, as we need to enable internal clock gate
   and TX clock
 - pinctrl configuration based on bus speed.
 - introduce new quirk SDHCI_QUIRK2_MUST_SET_SDHCI_BUS_POWER
   SD_BUS_POWER & SD_BUS_VLT bit-fields are used internally to gate the
   clocks, so it is important to configure them as part of ->set_power()
   More detailed description is written into commit log.
 - Enable SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for PXA1928 device_id
 - Enable SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk for pxa1928 device


V1 => V2:
=========
 - Fixed typo issue (residual change remained by mistake)
 - Added new patch updating DT binding document for pxa1928 support
 - Added new patch enabling CARD_ON_NEEDS_BUS_ON for pxa1928 device

Testing:
I have done basic testing on both eMMC and SD card on PXA1928 based
platform.

Note: I tried to made sure that I do not break any other platform, which
used sdhci, except HS200 configuration.?
Unfortunately I do not have access to any other datasheets, where I can
cross check the details on HS200 bit-fields. Probably someone who has
access can confirm [PATCH 4/5], whether it impacts other platforms.

Kevin Liu (1):
  mmc: sdhci-pxav3: Fix HS200 mode support

Vaibhav Hiremath (6):
  mmc: sdhci-pxav3: Enable pxa1928 device support
  mmc: sdhci-pxav3: binding: Add pxa1928 compatible support
  mmc: sdhci-pxav3: Add platform specific set_clock ops
  mmc: sdhci-pxav3: Add pinctl setting according to bus clock
  mmc: sdhci: add new quirk for setting BUS_POWER & BUS_VLT fields
  mmc: sdhci: enable SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON for pxa1928

 .../devicetree/bindings/mmc/sdhci-pxa.txt          |   2 +-
 drivers/mmc/host/sdhci-pltfm.c                     |   4 +
 drivers/mmc/host/sdhci-pxav3.c                     | 168 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 5 files changed, 165 insertions(+), 14 deletions(-)

-- 
1.9.1
