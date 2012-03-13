From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 16:44:11 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <1331650032-15274-1-git-send-email-sr@denx.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
Message-ID: <201203131644.12048.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Stefan Roese wrote:
> This patch adds a generic target for SPEAr600 board that can be
> configured via the device-tree. Currently only interrupts are
> configured via device-tree. Other peripheral devices (e.g.
> ethernet, I2C, SMI flash, FSMC NAND flash etc) will follow in
> later patches.
> 
> Only the spear600-evb is currently supported. Other SPEAr600
> based boards will follow later.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Viresh Kumar <viresh.kumar@st.com>

Hi Stefan,

This is very cool, welcome onboard for the DT conversion with spear600!

> +static struct amba_device *amba_devs[] __initdata = {
> +	&gpio_device[0],
> +	&gpio_device[1],
> +	&gpio_device[2],
> +	&uart_device[0],
> +	&uart_device[1],
> +};

I would suggest you convert these to DT next so you can remove the
amba_devs list. Which devices are these? If they are pl061 and
pl010/pl011, the binding should be really easy to do.

> +static struct platform_device *plat_devs[] __initdata = {
> +};

This could be dropped right away, because you would never
add anything here.

> +static void __init spear600_dt_init(void)
> +{
> +	unsigned int i;
> +
> +	/* call spear600 machine init function */
> +	spear600_init();

spear600_init currently is an empty function, I think you can
drop that one too.

> +	/* Add Platform Devices */
> +	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
> +
> +	/* Add Amba Devices */
> +	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
> +		amba_device_register(amba_devs[i], &iomem_resource);

So although all of this can go away soon, you will have to
add a call to of_platform_populate() here in order to add the
devices from the device tree.

> +}
> +
> +static const char *spear600_dt_board_compat[] = {
> +	"st,spear600-evb",
> +	NULL
> +};
> +
> +static const struct of_device_id vic_of_match[] __initconst = {
> +	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
> +	{ /* Sentinel */ }
> +};
> +
> +static void __init spear6xx_dt_init_irq(void)
> +{
> +	of_irq_init(vic_of_match);
> +}
> +
> +DT_MACHINE_START(SPEAR600_DT, "ST-SPEAR600-DT")
> +	.map_io		=	spear6xx_map_io,
> +	.init_irq	=	spear6xx_dt_init_irq,
> +	.handle_irq	=	vic_handle_irq,
> +	.timer		=	&spear6xx_timer,
> +	.init_machine	=	spear600_dt_init,
> +	.restart	=	spear_restart,
> +	.dt_compat	=	spear600_dt_board_compat,
> +MACHINE_END

Since there is only one upstream board file and that is for the same board,
we can soon collapse all of it into the base platform support.

I think you should add all the code from this file to spear6xx.c instead
of adding a new file. We can then delete the spear600.c and spear600_evb.c
files once the DT support has matured.

	Arnd
