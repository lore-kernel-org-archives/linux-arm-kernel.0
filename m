From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 16 Apr 2010 02:29:52 +0200
Subject: [PATCH] ARM: LPC32XX: adding a LPC3XXX machine for backwards
	compatibility
In-Reply-To: <1271354001-14210-1-git-send-email-bengardiner@nanometrics.ca>
References: <1271354001-14210-1-git-send-email-bengardiner@nanometrics.ca>
Message-ID: <083DF309106F364B939360100EC290F80976AE806E@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In the previous release of the lpc3250 kernel support -- a patch against
> 2.6.27.8 -- the machine type registered was LPC3XXX. This patch proposes
> to enable a compatibiluty machine definition so that existing u-boots
> can use a newer kernel without being re-flashed.
> 

In the older 27.8 release (still used a lot), the same machine ID was
used for all board variants before we started submitting our patches here
for potential inclusion into mainline. We recently registered and
switched over to new machine IDs specific to each board and have updated
our u-boot source with these new IDs, but won't be using the generic
LPC3XXX mach ID anymore.

However, we will provide a legacy patch for this on our webpage.
This should help developers that want to update to the latest kernel,
but are using a premade u-boot binary with the old mach id (and don't
want to rebuild u-boot or another bootloader).

thanks,
Kevin

> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> ---
>  arch/arm/mach-lpc32xx/Kconfig   |    5 +++++
>  arch/arm/mach-lpc32xx/phy3250.c |   14 ++++++++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
> index d522922..fade298 100644
> --- a/arch/arm/mach-lpc32xx/Kconfig
> +++ b/arch/arm/mach-lpc32xx/Kconfig
> @@ -47,4 +47,9 @@ config ARCH_LPC32XX_HSUART7_SELECT
> 
>  endmenu
> 
> +config LPC3XXX_COMPAT
> +	bool "Define also a LPC3XXX machine"
> +	help
> +	 Adds also a LPC3XXX machine for backwards compatibility with old u-
> boot versions.
> +
>  endif
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-
> lpc32xx/phy3250.c
> index 2672b63..a7d94d7 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -569,3 +569,17 @@ MACHINE_START(PHY3250, "Phytec 3250 board with the
> LPC3250 Microcontroller")
>  	.timer		= &lpc32xx_timer,
>  	.init_machine	= phy3250_board_init,
>  MACHINE_END
> +
> +#ifdef CONFIG_LPC3XXX_COMPAT
> +MACHINE_START(LPC3XXX, "Phytec 3250 board with the LPC3250
> Microcontroller")
> +	/* Maintainer: Kevin Wells, NXP Semiconductors */
> +	.phys_io	= LPC32XX_UART5_BASE,
> +	.io_pg_offst	= ((IO_ADDRESS(LPC32XX_UART5_BASE))>>18) & 0xfffc,
> +	.boot_params	= 0x80000100,
> +	.map_io		= lpc32xx_map_io,
> +	.init_irq	= lpc32xx_init_irq,
> +	.timer		= &lpc32xx_timer,
> +	.init_machine	= phy3250_board_init,
> +MACHINE_END
> +
> +#endif
> --
> 1.6.3.3
