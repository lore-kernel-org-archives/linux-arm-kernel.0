From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 14:40:10 +0000
Subject: [PATCH] mach-kirkwood: Support for DLink DNS-320 & DNS-325 NAS
In-Reply-To: <alpine.DEB.2.02.1202121424080.16803@bunsen.wrottesley.wormnet.eu>
References: <alpine.DEB.2.02.1202121424080.16803@bunsen.wrottesley.wormnet.eu>
Message-ID: <201202291440.10418.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 February 2012, Jamie Lentin wrote:
> This patch adds support for the D-Link DNS-320 & DNS-325 NAS. Kirkwood-based
> successors to the DNS-323.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> My previous patch supported just the DNS-325, the DNS-320 is a very similar
> device and so I've combined the support for both devices into one board support
> file. The main difference with the DNS-320 is that the temperature sensor
> is accessed via ttyS1 instead of I2C (I have a userland script to do this).
> 
> I appreciate board support files like this are old hat and should be using
> device tree instead. If I should be focusing on that instead of getting this
> merged, some pointers would be very useful.

Hi Jamie,

I just saw this patch going through the mailing list and noticed that you
had sent it out another time before without getting any reply. 

I'm sorry that you did not get any feedback on this. Jason Cooper had a
similar patch and he ended up a bit more fortunate than you, since he
got support for the kirkwood based "dreamplug" into the arm-soc tree
and is working on converting that to device tree now.

I would suggest that you two team up and put DNS-32x support into the new
common board-dt.c file as well.

Some more comments:

> diff --git a/arch/arm/mach-kirkwood/dnskw-setup.c b/arch/arm/mach-kirkwood/dnskw-setup.c
> new file mode 100644
> index 0000000..25ea0fa
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/dnskw-setup.c
> @@ -0,0 +1,431 @@
> +/*
> + * arch/arm/mach-kirkwood/dnskw-setup.c

All future boards should ideally go through a single board file, and the plan
is to work on minimizing the non-generic contents of that over time.
Right now, it only contains support for the dreamplug, but there is no
reason why this one couldn't get merged into it as well.

> +static struct mtd_partition dnskw_nand_parts[] = {
> +	{
> +		.name		= "u-boot",
> +		.offset		= 0,
> +		.size		= SZ_1M,
> +		.mask_flags	= MTD_WRITEABLE
> +	}, {
> +		.name		= "uImage",
> +		.offset		= MTDPART_OFS_NXTBLK,
> +		.size		= 5 * SZ_1M
> +	}, {
> +		.name		= "ramdisk",
> +		.offset		= MTDPART_OFS_NXTBLK,
> +		.size		= 5 * SZ_1M
> +	}, {
> +		.name		= "image",
> +		.offset		= MTDPART_OFS_NXTBLK,
> +		.size		= 102 * SZ_1M
> +	}, {
> +		.name		= "mini firmware",
> +		.offset		= MTDPART_OFS_NXTBLK,
> +		.size		= 10 * SZ_1M
> +	}, {
> +		.name		= "config",
> +		.offset		= MTDPART_OFS_NXTBLK,
> +		.size		= 5 * SZ_1M
> +	},
> +};

Jason already has a patch for NAND partitions through the SPI attachment,
I would suggest that you do the same for the nand controller, the patch
should be fairly similar.

> +static struct mv643xx_eth_platform_data dnskw_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> +};
> +
> +static struct mv_sata_platform_data dnskw_sata_data = {
> +	.n_ports	= 2,
> +};
> +
> +/*****************************************************************************
> + *  I2C-based devices
> + *
> + *  i2c addr | chip        | description
> + *  0x48     | GMT G751-2f | LM75-compatible temp. sensor (DNS-325 only)
> + *  0x0c     | ?           | (DNS-325 only)
> + *  0x64     | ?           |
> + ****************************************************************************/
> +
> +#ifdef CONFIG_MACH_DNS325
> +static struct i2c_board_info dns325_i2c_board_info[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("lm75", 0x48),
> +	},
> +};
> +#endif

These three things will require simple device tree bindings, but I think you
can leave them present in the first version and then submit follow-on patches
for them, moving all the data into the device tree.

> +/*****************************************************************************
> + * MPP / GPIO setup
> + ****************************************************************************/
> +
> +static unsigned int dnskw_mpp_config[] __initdata = {
> +	MPP13_UART1_TXD,	/* Custom ... */
> +	MPP14_UART1_RXD,	/* ... Controller (DNS-320 only) */
> +	MPP20_SATA1_ACTn,	/* LED: White Right HDD */
> +	MPP21_SATA0_ACTn,	/* LED: White Left HDD */
> +	MPP24_GPIO,
> +	MPP25_GPIO,
> +	MPP26_GPIO,	/* LED: Power */
> +	MPP27_GPIO,	/* LED: Red Right HDD */
> +	MPP28_GPIO,	/* LED: Red Left HDD */
> +	MPP29_GPIO,	/* LED: Red USB (DNS-325 only) */
> +	MPP30_GPIO,
> +	MPP31_GPIO,
> +	MPP32_GPIO,
> +	MPP33_GPO,
> +	MPP34_GPIO,	/* Button: Front power */
> +	MPP35_GPIO,	/* LED: Red USB (DNS-320 only) */
> +	MPP36_GPIO,	/* Power: MV88F6281_DEV_ID Board */
> +	MPP37_GPIO,	/* Power: Boot when power applied */
> +	MPP38_GPIO,
> +	MPP39_GPIO,	/* Power: SATA0 */
> +	MPP40_GPIO,	/* Power: SATA1 */
> +	MPP41_GPIO,
> +	MPP42_GPIO,
> +	MPP43_GPIO,	/* LED: White USB */
> +	MPP44_GPIO,	/* Fan: Tachometer Pin */
> +	MPP45_GPIO,	/* Fan: high speed */
> +	MPP46_GPIO,	/* Fan: low speed */
> +	MPP47_GPIO,	/* Button: Back unmount */
> +	MPP48_GPIO,	/* Button: Back reset */
> +	MPP49_GPIO,	/* Pin of unused U5 (DNS-320 only) */
> +	0
> +};

mpp config is a bit tricky, this will likely stay like this for the
next time.

> +/*****************************************************************************
> + * Power controls
> + ****************************************************************************/
> +
> +static void dnskw_power_off(void)
> +{
> +	gpio_set_value(DNSKW_GPIO_POWER, 1);
> +}
> ... <snip -- lots of gpio stuff>

The entire gpio setup is rather complex, and I don't know how much of it
can be handled with the existing gpio device tree bindings. I hope someone
else can comment here.

> +/*****************************************************************************
> + * Main init
> + ****************************************************************************/
> +
> +static void __init dnskw_init(void)
> +{
> +	u32 dev, rev;
> +
> +	/*
> +	 * Basic setup. Needs to be called early.
> +	 */
> +	kirkwood_init();
> +	kirkwood_mpp_conf(dnskw_mpp_config);

There is now a kirkwood_dt_init function that calls the board specific
functions based on an of_machine_is_compatible() check. Best add anything
from this function in there that cannot be handled using device tree
probing yet.

> +	kirkwood_uart0_init();
> +	kirkwood_uart1_init();

These can be done from the device tree already.

> +	kirkwood_nand_init(ARRAY_AND_SIZE(dnskw_nand_parts), 25);

This is the one I mentioned above that I think you should try to convert.

> +	kirkwood_ehci_init();
> +	kirkwood_i2c_init();
> +	kirkwood_ge00_init(&dnskw_ge00_data);
> +	kirkwood_sata_init(&dnskw_sata_data);

These should be handled next, but not necessarily before this board
supports makes it into the upstream kernel. Adding the bindings for
these should be fairly straightforward, and it will get easier
if kirkwood is first converted to use the generic clock framework.

> +#ifdef CONFIG_MACH_DNS320
> +	if (machine_is_dns320())
> +		platform_device_register(&dns320_led_device);
> +#endif
> +#ifdef CONFIG_MACH_DNS325
> +	if (machine_is_dns325()) {
> +		platform_device_register(&dns325_led_device);
> +
> +		i2c_register_board_info(0, dns325_i2c_board_info,
> +					ARRAY_SIZE(dns325_i2c_board_info));
> +	}
> +#endif
> +
> +	/*
> +	 * Turn on power to harddrives, then enable SATA.
> +	 * NB: Bootloader should have turned sata0 on already, kernel needs
> +	 * to turn on sata1. The idea is to stagger spin-up of HDDs.
> +	 */
> +	dnskw_gpio_register(DNSKW_GPIO_POWER_SATA0, "dnskw:power:sata0", 1);
> +	dnskw_gpio_register(DNSKW_GPIO_POWER_SATA1, "dnskw:power:sata1", 1);
> +
> +	platform_device_register(&dnskw_button_device);
> +	platform_device_register(&dnskw_fan_device);

It should be possible to handle all this by putting the right devices
into the device tree, but I don't know how to do that.

> +	/* Register power off routine */
> +	kirkwood_pcie_id(&dev, &rev);
> +	if (dev == MV88F6281_DEV_ID) {
> +		pr_info("PCI-E Device ID: MV88F6281, configuring power-off");
> +		if (gpio_request(DNSKW_GPIO_POWER, "dnskw:power:off") == 0 &&
> +		    gpio_direction_output(DNSKW_GPIO_POWER, 0) == 0)
> +			pm_power_off = dnskw_power_off;
> +		else
> +			pr_err("dnskw: failed to configure power-off GPIO\n");
> +	} else {
> +		/*
> +		 * Dlink code also defines 0x6192, and sets LOW_BASE +
> +		 * 0x01000000 high. Either cargo-culted code or another model.
> +		 */
> +		pr_err("Unknown PCI-E Device ID %x, no power-off", dev);
> +	}
> +
> +	/* Set state of power_recover pin */
> +	if (gpio_request(DNSKW_GPIO_POWER_RECOVER, "dnskw:power:recover") == 0
> +	 && gpio_direction_output(DNSKW_GPIO_POWER_RECOVER, 0) == 0) {
> +		pr_info("dnskw: Setting power-recover %s\n",
> +			power_recover_value ? "on" : "off");
> +		gpio_set_value(DNSKW_GPIO_POWER_RECOVER, power_recover_value);
> +	} else
> +		pr_err("dnskw: Failed to register power-recover GPIO\n");
> +}

This might have to stay board specific.

> +#ifdef CONFIG_MACH_DNS320
> +MACHINE_START(DNS320, "D-Link DNS-320")
> +	/* Maintainer: Jamie Lentin <jm@lentin.co.uk> */
> +	.atag_offset	= 0x100,
> +	.init_machine	= dnskw_init,
> +	.map_io		= kirkwood_map_io,
> +	.init_early	= kirkwood_init_early,
> +	.init_irq	= kirkwood_init_irq,
> +	.timer		= &kirkwood_timer,
> +	.restart	= kirkwood_restart,
> +MACHINE_END
> +#endif
> +
> +#ifdef CONFIG_MACH_DNS325
> +MACHINE_START(DNS325, "D-Link DNS-325")
> +	/* Maintainer: Jamie Lentin <jm@lentin.co.uk> */
> +	.atag_offset	= 0x100,
> +	.init_machine	= dnskw_init,
> +	.map_io		= kirkwood_map_io,
> +	.init_early	= kirkwood_init_early,
> +	.init_irq	= kirkwood_init_irq,
> +	.timer		= &kirkwood_timer,
> +	.restart	= kirkwood_restart,
> +MACHINE_END
> +#endif

Just use DT_MACHINE_START here and remove the machine ID and atag_offset. See
the board-dt.c file.

	Arnd
