From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Oct 2010 09:37:40 +0200
Subject: [patch v3 04/10] efikamx: add mmc support
In-Reply-To: <20101026200958.255102949@rtp-net.org>
References: <20101026200723.839428019@rtp-net.org>
	<20101026200958.255102949@rtp-net.org>
Message-ID: <20101027073740.GA8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 10:07:27PM +0200, Arnaud Patard wrote:
> The efika mx is using a esdhc host for mmc support. Now that the sdhci
> has support for it, enable it.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-20 18:30:40.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-20 18:30:46.000000000 +0200
> @@ -59,6 +59,28 @@
>  	MX51_PAD_PCBID0,
>  	MX51_PAD_PCBID1,
>  	MX51_PAD_PCBID2,
> +
> +	/* SD 1 */
> +	MX51_PAD_SD1_CMD__SD1_CMD,
> +	MX51_PAD_SD1_CLK__SD1_CLK,
> +	MX51_PAD_SD1_DATA0__SD1_DATA0,
> +	MX51_PAD_SD1_DATA1__SD1_DATA1,
> +	MX51_PAD_SD1_DATA2__SD1_DATA2,
> +	MX51_PAD_SD1_DATA3__SD1_DATA3,
> +
> +	/* SD 2 */
> +	MX51_PAD_SD2_CMD__SD2_CMD,
> +	MX51_PAD_SD2_CLK__SD2_CLK,
> +	MX51_PAD_SD2_DATA0__SD2_DATA0,
> +	MX51_PAD_SD2_DATA1__SD2_DATA1,
> +	MX51_PAD_SD2_DATA2__SD2_DATA2,
> +	MX51_PAD_SD2_DATA3__SD2_DATA3,
> +
> +	/* SD/MMC WP/CD */
> +	MX51_PAD_GPIO_1_0__ESDHC1_CD,
> +	MX51_PAD_GPIO_1_1__ESDHC1_WP,
> +	MX51_PAD_GPIO_1_7__ESDHC2_WP,
> +	MX51_PAD_GPIO_1_8__ESDHC2_CD,
>  };
>  
>  /* Serial ports */
> @@ -164,6 +186,11 @@
>  	mx51_efikamx_board_id();
>  	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
>  	mxc_init_imx_uart();
> +	imx51_add_esdhc(0, NULL);
> +
> +	/* on < 1.2 boards the 2 SD controller are used */
s/the 2/both/ ?

> +	if (system_rev < 0x12)
> +		imx51_add_esdhc(1, NULL);
>  }
>  
>  static void __init mx51_efikamx_timer_init(void)
> Index: linux-2.6-submit/arch/arm/mach-mx5/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/Kconfig	2010-10-20 18:30:29.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/Kconfig	2010-10-20 18:30:46.000000000 +0200
> @@ -80,6 +80,7 @@
>  config MACH_MX51_EFIKAMX
>  	bool "Support MX51 Genesi Efika MX nettop"
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_ESDHC
Can you keep these flags sorted alphabetically please?

>  	help
>  	  Include support for Genesi Efika MX nettop. This includes specific
>  	  configurations for the board and its peripherals.
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
