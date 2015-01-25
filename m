From: jenskuske@gmail.com (Jens Kuske)
Date: Sun, 25 Jan 2015 16:49:16 +0100
Subject: [PATCH 0/3] net: allwinner: sun4i-emac: add missing SRAM mapping
Message-ID: <1422200959-1717-1-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The current sun4i-emac kernel driver does not set the needed SRAM mapping.

This hasn't been noticed because normally the bootloader already did this.
But in case the bootloader skips initializing the EMAC, like in U-Boot's
Falcon Mode for example, the kernel driver has to take care of it.

Patch 1-2 add a mfd/syscon for the shared registers responsible for SRAM
mapping. These patches are taken from Chen-Yu Tsai's sunxi-musb tree [1] and
I added a copy of the device-tree nodes to sun4i and sun5i.

Patch 3 adds the code to map SRAM to EMAC using the syscon.

Regards,
Jens

[1] https://github.com/wens/linux/commits/wip/sunxi-musb


Chen-Yu Tsai (2):
  ARM: dts: sunxi: Add syscon node for controlling SRAM mapping
  ARM: sunxi: Add register bit definitions for SRAM mapping syscon

Jens Kuske (1):
  net: allwinner: sun4i-emac: fix emac SRAM mapping

 arch/arm/boot/dts/sun4i-a10.dtsi            |  5 ++++
 arch/arm/boot/dts/sun5i-a10s.dtsi           |  5 ++++
 arch/arm/boot/dts/sun5i-a13.dtsi            |  5 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi            |  5 ++++
 drivers/net/ethernet/allwinner/Kconfig      |  1 +
 drivers/net/ethernet/allwinner/sun4i-emac.c | 18 +++++++++++++
 include/linux/mfd/syscon/sun4i-sc.h         | 42 +++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+)
 create mode 100644 include/linux/mfd/syscon/sun4i-sc.h

-- 
2.2.2
