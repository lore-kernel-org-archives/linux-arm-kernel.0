From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 15:32:22 +0530
Subject: [PATCH 0/8] ARM; OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
In-Reply-To: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <51249F2E.6010404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Felipe ( Sorry I missed you in CC list)

On Wednesday 20 February 2013 03:27 PM, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on functional state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling.
>
> The series tries to address the issue and tries to remove complete
> sysc handling from serial driver.
>
> Patches has been tested on OMAP4430 SDP and OMAP5 EVM where the console
> sluggishness was observed without idle mode handling. CPUIDLE and
> suspend tested ok on these devices.
>
> Thanks to Vaibhav Bedia for testing on Beaglebone(AM33XX) with suspend and
> also the UART async wakeup from suspend.
>
> Thanks to Sourav Poddar for Beagle XM(OMAP3630) devices testing with
> retention and offmode in Idle and suspend for non-DT builds.
>
> Serial driver platform code still has one more function pointer
> left which is used to trigger io_ring(). This one needs some
> discussion with pincontrol driver folks on how to implement
> such a feature with generic pincontrol driver.
>
> Rajendra Nayak (4):
>    ARM: OMAP2+: hwmod: Remove unused _HWMOD_WAKEUP_ENABLED flag
>    ARM: OMAP2+: hwmod: Cleanup sidle/mstandby programming
>    ARM: OMAP2+: hwmod: Always have OCP_SYSCONFIG.ENAWAKEUP enabled
>    ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in
>      active
>
> Santosh Shilimkar (4):
>    ARM: OMAP2+: hwmod-data: UART IP needs software control to manage
>      sidle modes
>    SERIAL: OMAP: Remove the slave idle handling from the driver
>    ARM: OMAP2+: serial: Remove the un-used slave idle hooks
>    ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis
>
>   arch/arm/mach-omap2/omap_hwmod.c                   |  141 ++++----------------
>   arch/arm/mach-omap2/omap_hwmod.h                   |   13 +-
>   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +
>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 +
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +-
>   arch/arm/mach-omap2/serial.c                       |   31 -----
>   drivers/tty/serial/omap-serial.c                   |   23 ----
>   8 files changed, 50 insertions(+), 177 deletions(-)
>
