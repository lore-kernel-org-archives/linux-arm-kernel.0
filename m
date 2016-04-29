From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 29 Apr 2016 10:32:15 -0700
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering w/
 device tree
Message-ID: <1461951139-6109-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series picks patches from various different places to produce what
I consider the best solution to getting consistent mmc and mmcblk
ordering.

Why consistent ordering and why not just use UUIDs?  IMHO consistent
ordering solves a few different problems:

1. For poor, feeble-minded humans like me, have sane numbering for
   devices helps a lot.  When grepping through dmesg it's terribly handy
   if a given SDMMC device has a consistent number.  I know that I can
   do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
   the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
   about the SD card slot.  I don't want it to matter which one probed
   first, I don't want it to matter if I'm working on a variant of the
   hardware that has the SD card slot disabled, and I don't want to care
   what my boot device was.  Worrying about what device number I got
   increases my cognitive load.

2. There are cases where it's not trivially easy during development to
   use the UUID.  Specifically I work a lot with coreboot / depthcharge
   as a BIOS.  When configured properly, that BIOS has a nice feature to
   allow you to fetch the kernel and kernel command line from TFTP by
   pressing Ctrl-N.  In this particular case the BIOS doesn't actually
   know which disk I'd like for my root filesystem, so it's not so easy
   for it to put the right UUID into the command line.  For this
   purpose, knowing that "mmcblk0" will always refer to eMMC is handy.

Changes in v2:
- Rebased atop mmc-next
- Stat dynamic allocation after fixed allocation; thanks Wolfram!
- rk3288 patch new for v2

Douglas Anderson (1):
  ARM: dts: rockchip: Add mmc aliases for rk3288 platform

Jaehoon Chung (1):
  Documentation: mmc: Document mmc aliases

Stefan Agner (2):
  mmc: read mmc alias from device tree
  mmc: use SD/MMC host ID for block device name ID

 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
 drivers/mmc/card/block.c                      |  2 +-
 drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
