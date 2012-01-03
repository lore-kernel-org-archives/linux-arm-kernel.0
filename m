From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  3 Jan 2012 15:25:16 -0700
Subject: [PATCH 0/4] ARM: tegra: Automatic UART selection for earlyprintk
Message-ID: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allows a Tegra zImage to automatically select the UART to use
for the zImage decompressor and early printk, based on information from
the bootloader. The code scans each UART, looking for one that is clocked,
is out of reset, and that the bootloader has written 'D' (for 'D'ebug) to
the scratch register.

At present, the ChromiumOS branch of U-Boot sets up UARTs in this way. If
this patch is accepted into the kernel, I'll upstream the U-Boot change to
mainline U-Boot.

This is important, since different boards use different UARTs, and it's
nice not to have to configure the kernel differently when switching
boards.

This patch series depends on patch "[PATCH V2] arm/tegra: Support Tegra30
in decompressor UART setup" for context.

Doug Anderson (2):
  ARM: tegra: Introduce define DEBUG_UART_SHIFT
  ARM: tegra: uncompress.h: Store UART address in a variable

Stephen Warren (2):
  ARM: tegra: uncompress.h: Choose a UART at runtime
  ARM: tegra: Pass uncompress.h UART selection to DEBUG_LL

 arch/arm/mach-tegra/common.c                   |   17 ++++
 arch/arm/mach-tegra/include/mach/debug-macro.S |   87 +++++++++++++++++---
 arch/arm/mach-tegra/include/mach/uncompress.h  |  108 +++++++++++++++++++++---
 3 files changed, 190 insertions(+), 22 deletions(-)
