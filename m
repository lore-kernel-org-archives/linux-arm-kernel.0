From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:50 -0600
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
Message-ID: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This series removes common kconfig options required by multi-platform
builds out of individual platforms as they are redundant. Patches 2 and
3 make SMP and CACHE_L2X0 config options visible on MULTI_V7 builds as
most platforms enable these options and all platforms can run with them
enabled.

The previous version [1] was mainly a discussion about v6 vs. v6K.
Several platforms have this wrong and incorrectly select v6 when the
more optimal v6K option could be used. After more research, my memory
about i.MX31 was wrong and it does need to remain v6. I've tested the
v6K change on Rasp Pi. The default change to v6K for MULTI_V6 does not
switch any platforms. I don't plan to submit the v6K changes for
platforms without platform maintainers acks or testing. 

Finally, patch 8 removes mach-virt as it is no longer needed. The core
ARM code can handle all the necessary initialization and mach-virt is
left as a kconfig option. Although not really related to this series, 
it would otherwise conflict with it.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/216631.html

Rob Herring (9):
  ARM: centralize common multi-platform kconfig options
  ARM: select HAVE_SMP for V7 multi-platform
  ARM: select MIGHT_HAVE_CACHE_L2X0 for V7 multi-platform
  ARM: Select V6K instead of V6 by default for multi-platform
  ARM: bcm2835: enable V6K instead of plain V6
  ARM: cns3xxx: enable V6K instead of plain V6
  ARM: vt8500: enable V6K instead of plain V6
  ARM: virt: make mach-virt just a kconfig option
  ARM: virt: select ARM_AMBA

 arch/arm/Kconfig                | 15 ++++++++++++---
 arch/arm/Makefile               |  1 -
 arch/arm/mach-bcm/Kconfig       |  5 -----
 arch/arm/mach-bcm2835/Kconfig   |  4 ----
 arch/arm/mach-berlin/Kconfig    |  4 ----
 arch/arm/mach-cns3xxx/Kconfig   |  3 ---
 arch/arm/mach-highbank/Kconfig  |  7 -------
 arch/arm/mach-hisi/Kconfig      |  4 ----
 arch/arm/mach-imx/Kconfig       | 14 --------------
 arch/arm/mach-keystone/Kconfig  |  4 ----
 arch/arm/mach-moxart/Kconfig    |  5 -----
 arch/arm/mach-mvebu/Kconfig     |  6 ------
 arch/arm/mach-mxs/Kconfig       |  4 ----
 arch/arm/mach-nomadik/Kconfig   |  5 -----
 arch/arm/mach-nspire/Kconfig    |  5 -----
 arch/arm/mach-omap2/Kconfig     | 17 -----------------
 arch/arm/mach-picoxcell/Kconfig |  5 -----
 arch/arm/mach-prima2/Kconfig    |  6 ------
 arch/arm/mach-rockchip/Kconfig  |  3 ---
 arch/arm/mach-shmobile/Kconfig  |  5 -----
 arch/arm/mach-socfpga/Kconfig   |  7 -------
 arch/arm/mach-spear/Kconfig     | 10 ----------
 arch/arm/mach-sti/Kconfig       |  4 ----
 arch/arm/mach-sunxi/Kconfig     |  5 -----
 arch/arm/mach-tegra/Kconfig     |  8 --------
 arch/arm/mach-u300/Kconfig      |  6 ------
 arch/arm/mach-ux500/Kconfig     |  6 ------
 arch/arm/mach-vexpress/Kconfig  |  5 -----
 arch/arm/mach-virt/Kconfig      | 10 ----------
 arch/arm/mach-virt/Makefile     |  5 -----
 arch/arm/mach-virt/virt.c       | 41 -----------------------------------------
 arch/arm/mach-vt8500/Kconfig    |  4 ----
 arch/arm/mach-zynq/Kconfig      |  7 -------
 33 files changed, 12 insertions(+), 228 deletions(-)
 delete mode 100644 arch/arm/mach-virt/Kconfig
 delete mode 100644 arch/arm/mach-virt/Makefile
 delete mode 100644 arch/arm/mach-virt/virt.c

-- 
1.8.3.2
