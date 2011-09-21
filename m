From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 13:48:26 -0700
Subject: [PATCH v2 3/3] TI814X: Create board support and enable build
	for TI8148 EVM
In-Reply-To: <1316626754-5764-1-git-send-email-hemantp@ti.com>
References: <1316626754-5764-1-git-send-email-hemantp@ti.com>
Message-ID: <20110921204826.GK2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hemant Pedanekar <hemantp@ti.com> [110921 10:05]:
> +
> +static struct omap_board_config_kernel ti8148_evm_config[] __initdata = {
> +};
> +
> +static void __init ti8148_evm_init(void)
> +{
> +	omap_serial_init();
> +	omap_board_config = ti8148_evm_config;
> +	omap_board_config_size = ARRAY_SIZE(ti8148_evm_config);
> +}
> +
> +static void __init ti8148_evm_map_io(void)
> +{
> +	omap2_set_globals_ti81xx();
> +	omapti81xx_map_common_io();
> +}

Hmm I guess we still have board specific map_io in board-ti8668evm.c
also. Those would be better replaced with ti81xx_map_io in
mach-omap2/common.c. Care to take a look at that?

> +MACHINE_START(TI8148EVM, "ti8148evm")
> +	/* Maintainer: Texas Instruments */
> +	.atag_offset	= 0x100,
> +	.map_io		= ti8148_evm_map_io,
> +	.init_early	= ti81xx_init_early,
> +	.init_irq	= ti81xx_init_irq,
> +	.timer		= &omap3_timer,
> +	.init_machine	= ti8148_evm_init,
> +MACHINE_END

Please add this all to board-ti8168evm.c instead of adding a new
board-*.c file. With the upcoming device tree conversion most of
these will disappear anyways.

Regards,

Tony
