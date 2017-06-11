From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 11 Jun 2017 22:07:23 +0000
Subject: [RFC PATCH 0/7] EDAC drivers for Armada XP L2 and DDR
References: <20170609083123.6539-1-jlu@pengutronix.de>
Message-ID: <261d8b59e4764883917f15ed9d2ee8ce@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On 09/06/17 20:53, Jan Luebbe wrote:
> This series add drivers for the L2 cache and DDR RAM ECC functionality as found
> on the MV78230/MV78x60 SoCs. I've tested these changes with the MV78460 (on a
> custom board with a DDR3 ECC DIMM).
> 
> Also contained in this series are devm_ helpers for edac_mc_/edac_device_
> allocation and registration, which make error handing and cleanup simpler. They
> may already be mergeable.
> 
> It seems Chris and I had a race condition, he posted a driver for this
> functionality just yesterday. Compared to his submission, the L2 and DDR
> support is split into two drivers for this series, as they don't actually share
> any functionality.

I think the DDR controller is also applicable to Armada-38x (which is 
why I called it mvebu in my series). The L2 cache is different between 
Armada-XP and Armada-38x so it makes sense to split them.

> 
> Some further differences in this series are:
> - The error details are decoded and passed to the edac error handler.
> - Multiple errors are counted even if the details are unavailable.
> - The DDR RAM configuration is read back to fill out the DIMM structures.
> - The DDR RAM error address is calculated from the bank/row/col information.
> - The L2 injection registers are exposed via debugfs instead of sysfs
>    (resulting in less driver code).
> 
> Chris, how do you want to proceed? We should probably combine our efforts in one
> series. I've already picked up part of DDR RAM config reading from your series
> for this submission. I'll send some questions/comments to your series, as well.

I'm more than happy for you to take the lead on this one. I can test on 
a couple of different 98dx3236 boards (switch chips with integrated 
Armada-XP).

> 
> Jan Luebbe (7):
>    ARM: l2c: move cache-aurora-l2.h to asm/hardware
>    ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
>    EDAC: Add missing debugfs_create_x32 wrapper
>    EDAC: Add devres helpers for
>      edac_mc_alloc/edac_mc_add_mc(_with_groups)
>    EDAC: Add devres helpers for
>      edac_device_alloc_ctl_info/edac_device_add_device
>    EDAC: Add driver for the AURORA L2 cache
>    EDAC: Add driver for the Marvell Armada XP SDRAM controller
> 
>   arch/arm/include/asm/hardware/cache-aurora-l2.h | 104 +++++++
>   arch/arm/mm/cache-aurora-l2.h                   |  55 ----
>   arch/arm/mm/cache-l2x0.c                        |   6 +-
>   drivers/edac/Kconfig                            |  14 +
>   drivers/edac/Makefile                           |   2 +
>   drivers/edac/armada_xp_mc_edac.c                | 366 ++++++++++++++++++++++++
>   drivers/edac/aurora_l2_edac.c                   | 252 ++++++++++++++++
>   drivers/edac/debugfs.c                          |  11 +
>   drivers/edac/edac_device.c                      |  59 ++++
>   drivers/edac/edac_device.h                      |  29 ++
>   drivers/edac/edac_mc.c                          |  53 ++++
>   drivers/edac/edac_mc.h                          |  26 ++
>   drivers/edac/edac_module.h                      |   5 +
>   13 files changed, 924 insertions(+), 58 deletions(-)
>   create mode 100644 arch/arm/include/asm/hardware/cache-aurora-l2.h
>   delete mode 100644 arch/arm/mm/cache-aurora-l2.h
>   create mode 100644 drivers/edac/armada_xp_mc_edac.c
>   create mode 100644 drivers/edac/aurora_l2_edac.c
> 
