From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Jan 2011 09:51:45 +0100
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using
	PHYS_OFFSET
In-Reply-To: <E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
Message-ID: <20110106085145.GB26617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 08:22:37PM +0000, Russell King - ARM Linux wrote:
> As PHYS_OFFSET will be becoming a variable, we can't have it used in
> initializers nor assembly code.  Replace those in generic code with
> a run-time initialization.  Replace those in platform code using the
> individual platform specific PLAT_PHYS_OFFSET.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/setup.c                  |    4 +++-
>  arch/arm/mach-msm/board-msm7x27.c        |    8 ++++----
>  arch/arm/mach-msm/board-msm7x30.c        |    6 +++---
>  arch/arm/mach-msm/board-qsd8x50.c        |    4 ++--
>  arch/arm/mach-msm/board-sapphire.c       |    2 +-
>  arch/arm/mach-mx5/board-cpuimx51.c       |    2 +-
>  arch/arm/mach-mx5/board-cpuimx51sd.c     |    2 +-
>  arch/arm/mach-mx5/board-mx51_3ds.c       |    2 +-
>  arch/arm/mach-pxa/balloon3.c             |    2 +-
>  arch/arm/mach-realview/realview_eb.c     |    2 +-
>  arch/arm/mach-realview/realview_pb1176.c |    2 +-
>  arch/arm/mach-realview/realview_pb11mp.c |    2 +-
>  arch/arm/mach-realview/realview_pba8.c   |    2 +-
>  arch/arm/mach-realview/realview_pbx.c    |    2 +-
>  arch/arm/mach-s5pv210/sleep.S            |    2 +-
>  arch/arm/mach-tcc8k/board-tcc8000-sdk.c  |    2 +-
>  arch/arm/mach-vexpress/ct-ca9x4.c        |    2 +-
>  17 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 6a9792f..c4c3a9c 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -292,7 +292,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
>  	/* Maintainer: Eric B??nard <eric@eukrea.com> */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = PLAT_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = eukrea_cpuimx51_init,
> diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
> index 4b3a611..b887381 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51sd.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
> @@ -323,7 +323,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
>  	/* Maintainer: Eric B??nard <eric@eukrea.com> */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = PLAT_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = eukrea_cpuimx51sd_init,
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> index 79ce8dc..10e6ce3 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -186,7 +186,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
>  	/* Maintainer: Freescale Semiconductor, Inc. */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = PLAT_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = mxc_board_init,

As Russell noted this conflicts with the current i.MX branch. In current
i.MX branch we have:

-       .boot_params = PHYS_OFFSET + 0x100,
+       .boot_params = MX51_PHYS_OFFSET + 0x100,

PLAT_PHYS_OFFSET should be defined to MX51_PHYS_OFFSET, so it shouldn't
matter which solution to the conflict we choose.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
