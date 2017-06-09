From: bp@alien8.de (Borislav Petkov)
Date: Fri, 9 Jun 2017 11:36:51 +0200
Subject: [RFC PATCH 0/7] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <20170609083123.6539-1-jlu@pengutronix.de>
References: <20170609083123.6539-1-jlu@pengutronix.de>
Message-ID: <20170609093651.nfhthfdjn2jfkpxx@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 10:31:16AM +0200, Jan Luebbe wrote:
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
> 
> Some further differences in this series are:
> - The error details are decoded and passed to the edac error handler.
> - Multiple errors are counted even if the details are unavailable.
> - The DDR RAM configuration is read back to fill out the DIMM structures.
> - The DDR RAM error address is calculated from the bank/row/col information.
> - The L2 injection registers are exposed via debugfs instead of sysfs
>   (resulting in less driver code).
> 
> Chris, how do you want to proceed? We should probably combine our efforts in one
> series. I've already picked up part of DDR RAM config reading from your series
> for this submission. I'll send some questions/comments to your series, as well.
> 
> Jan Luebbe (7):
>   ARM: l2c: move cache-aurora-l2.h to asm/hardware
>   ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
>   EDAC: Add missing debugfs_create_x32 wrapper
>   EDAC: Add devres helpers for
>     edac_mc_alloc/edac_mc_add_mc(_with_groups)
>   EDAC: Add devres helpers for
>     edac_device_alloc_ctl_info/edac_device_add_device
>   EDAC: Add driver for the AURORA L2 cache
>   EDAC: Add driver for the Marvell Armada XP SDRAM controller
> 
>  arch/arm/include/asm/hardware/cache-aurora-l2.h | 104 +++++++
>  arch/arm/mm/cache-aurora-l2.h                   |  55 ----
>  arch/arm/mm/cache-l2x0.c                        |   6 +-
>  drivers/edac/Kconfig                            |  14 +
>  drivers/edac/Makefile                           |   2 +
>  drivers/edac/armada_xp_mc_edac.c                | 366 ++++++++++++++++++++++++
>  drivers/edac/aurora_l2_edac.c                   | 252 ++++++++++++++++

Before we go any further, pls put all the Marvell RAS functionality
into a single file - I don't want a separate compilation unit per an IP
block.

Also, some of your commit messages are empty and I'm sure they could use
some text.

And yes, it'd be very productive not to get conflicting submissions from
you and Chris. :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
