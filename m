From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 25 Oct 2012 20:14:26 +0200
Subject: [PATCH] arm: kirkwood: add support for ZyXEL NSA310
In-Reply-To: <alpine.DEB.2.02.1210251735020.15860@mirri>
References: <alpine.DEB.2.02.1210251735020.15860@mirri>
Message-ID: <20121025181426.GC21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero

On Thu, Oct 25, 2012 at 06:01:00PM +0300, Tero Jaasko wrote:
> +#define NSA310_GPIO_LED_ESATA_GREEN	12
> +#define NSA310_GPIO_LED_ESATA_RED	13
> +#define NSA310_GPIO_LED_USB_GREEN	15
> +#define NSA310_GPIO_LED_USB_RED		16
> +#define NSA310_GPIO_USB_POWER_OFF	21
> +#define NSA310_GPIO_LED_SYS_GREEN	28
> +#define NSA310_GPIO_LED_SYS_RED		29
> +#define NSA310_GPIO_KEY_RESTART		36
> +#define NSA310_GPIO_KEY_COPY		37
> +#define NSA310_GPIO_LED_COPY_GREEN	39
> +#define NSA310_GPIO_LED_COPY_RED	40
> +#define NSA310_GPIO_LED_HDD_GREEN	41
> +#define NSA310_GPIO_LED_HDD_RED		42
> +#define NSA310_GPIO_BUZZER		44
> +#define NSA310_GPIO_KEY_POWER		46
> +#define NSA310_GPIO_POWER_OFF		48

It looks like most of these are not used. Please remove them.

> +static struct mtd_partition nsa310_mtd_parts[] = {
> +	{
> +		.name	= "uboot",
> +		.offset	= 0,
> +		.size	= 0x100000,
> +		.mask_flags = MTD_WRITEABLE,
> +	}, {
> +		.name	= "uboot_env",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0x80000,
> +	}, {
> +		.name	= "key_store",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0x80000,
> +	}, {
> +		.name	= "info",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0x80000,
> +	}, {
> +		.name	= "etc",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0xa00000,
> +	}, {
> +		.name	= "kernel_1",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0xa00000,
> +	}, {
> +		.name	= "rootfs1",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0x2fc0000,
> +	}, {
> +		.name	= "kernel_2",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0xa00000,
> +	}, {
> +		.name	= "rootfs2",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 0x2fc0000,
> +	},
> +};

You should be able to put all that into DT. Take a look at

arch/arm/boot/dts/kirkwood-goflexnet.dts for example.

> +
> +static struct i2c_board_info __initdata nsa310_i2c_info[] = {
> +	{ I2C_BOARD_INFO("adt7476", 0x2e) },
> +};

You can also do this in DT as well. kirkwood-ts219.dtsi has

                i2c at 11000 {
                        status = "okay";
                        clock-frequency = <400000>;

                        s35390a: s35390a at 30 {
                                compatible = "s35390a";
                                reg = <0x30>;
                        };

Thanks
	Andrew
