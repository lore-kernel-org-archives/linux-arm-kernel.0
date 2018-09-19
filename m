From: aditya@kobol.io (Aditya Prayoga)
Date: Wed, 19 Sep 2018 11:45:28 +0800
Subject: [PATCH 0/2] Add support per ATA port ledtrigger on armada 38x
Message-ID: <1537328730-9156-1-git-send-email-aditya@kobol.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support LED trigger for each ATA port indicating disk activity
in Armada 38x. I pick up the work done by Daniel Golle which can be found at [1]

Helios4 which is based on Armada 388, has four LEDs designed to indicate disk
activity on each SATA ports. As the final switch (CONFIG_ATA_LEDS) to enable
the codepath by default is no, it should not affect the rest of Armada 38x 
based boards.

[1] https://patchwork.ozlabs.org/patch/420733/ 
---
Notes
  checkpatch.pl complains about "WARNING: please write a paragraph that
    describes the config symbol fully" but I think the description is clear
    enough to ignore the warning.

  Some performance number tested on Western Digital Red 2TB WD20EFRX
    using fio randrw
    * CONFIG_ATA_LEDS disabled and selected trigger is none
      read : iops=326
      write : iops=109
    * CONFIG_ATA_LEDS disabled and selected trigger is disk-activity
      read : iops=325
      write : iops=108
    * CONFIG_ATA_LEDS enabled and selected trigger is ata1
      read : iops=325
      write : iops=108

---
Aditya Prayoga (1):
  ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x

Daniel Golle (1):
  libata: add ledtrig support

 arch/arm/mach-mvebu/Kconfig |  1 +
 drivers/ata/Kconfig         | 16 +++++++++++++
 drivers/ata/libata-core.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h      |  7 ++++++
 4 files changed, 80 insertions(+)

-- 
2.7.4
