From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 Dec 2013 03:21:11 +0100
Subject: [PATCH v2 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
References: <1385879185-22455-3-git-send-email-ynvich@gmail.com>
 <1386348542-9584-1-git-send-email-ynvich@gmail.com>
Message-ID: <201312080321.12001.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Sergei Ianovich wrote:

> new file mode 100644
> index 0000000..2612e60
> --- /dev/null
> +++ b/arch/arm/configs/lp8x4x_defconfig
> @@ -0,0 +1,235 @@
> +CONFIG_CROSS_COMPILE="arm-linux-gnueabi-"

This will break some build bots, please remove it here and add it to your
build environment instead.

> +# CONFIG_LBDAF is not set
> +CONFIG_BLK_CMDLINE_PARSER=y
> +CONFIG_PARTITION_ADVANCED=y
> +CONFIG_BSD_DISKLABEL=y
> +CONFIG_MINIX_SUBPARTITION=y
> +CONFIG_SOLARIS_X86_PARTITION=y
> +CONFIG_UNIXWARE_DISKLABEL=y
> +CONFIG_LDM_PARTITION=y

You have some rather unusual options in here. I'd suggest you go through
the reduced defconfig file and remove all options that look like they
are unnecessary for your system.

It's probably based on some distro config that enables lots of modules
you don't actually want.

> +#define LP8X4X_FPGA_PHYS	0x17000000
> +#define LP8X4X_FPGA_VIRT	((void *) 0xf1000000)
> +#define LP8X4X_P2V(x)		IOMEM((x) - LP8X4X_FPGA_PHYS + LP8X4X_FPGA_VIRT)
> +#define LP8X4X_V2P(x)		((x) - LP8X4X_FPGA_VIRT + LP8X4X_FPGA_PHYS)

I think you misunderstood my comment, the point was that you should
move the IOMEM() to the LP8X4X_FPGA_VIRT definition, like

#define LP8X4X_FPGA_VIRT	((void __iomem *) 0xf1000000)
#define LP8X4X_P2V(x)		(x) - LP8X4X_FPGA_PHYS + LP8X4X_FPGA_VIRT)

which would result in the correct type because of pointer arithmetics.

> +/* board level registers in the FPGA */
> +
> +#define LP8X4X_EOI		LP8X4X_P2V(0x17009006)
> +#define LP8X4X_INSINT		LP8X4X_P2V(0x17009008)
> +#define LP8X4X_ENSYSINT		LP8X4X_P2V(0x1700900A)
> +#define LP8X4X_PRIMINT		LP8X4X_P2V(0x1700900C)
> +#define LP8X4X_SECOINT		LP8X4X_P2V(0x1700900E)
> +#define LP8X4X_ENRISEINT	LP8X4X_P2V(0x17009010)
> +#define LP8X4X_CLRRISEINT	LP8X4X_P2V(0x17009012)
> +#define LP8X4X_ENHILVINT	LP8X4X_P2V(0x17009014)
> +#define LP8X4X_CLRHILVINT	LP8X4X_P2V(0x17009016)
> +#define LP8X4X_ENFALLINT	LP8X4X_P2V(0x17009018)
> +#define LP8X4X_CLRFALLINT	LP8X4X_P2V(0x1700901a)

Thinking about this again, it's actually better if you just get rid of
LP8X4X_P2V() entirely and redefine these to

#define LP8X4X_EOI		0x0006
#define LP8X4X_INSINT		0x0008
...

and change the users to do e.g.

	readl(LP8X4X_FPGA_VIRT + LP8X4X_INSINT);

This is closer to the normal way of adding the offset to an __iomem
pointer returned from ioremap.

> +	platform_device_register_resndata(NULL, "pxa2xx-flash", 0,
> +			&lp8x4x_flash_resources[0], 1,
> +			&lp8x4x_flash_data[0], sizeof(lp8x4x_flash_data[0]));
> +	platform_device_register_resndata(NULL, "pxa2xx-flash", 1,
> +			&lp8x4x_flash_resources[1], 1,
> +			&lp8x4x_flash_data[1], sizeof(lp8x4x_flash_data[1]));
> +	platform_device_register_simple("dm9000", 0,
> +			&lp8x4x_dm9000_resources[0], 3);
> +	platform_device_register_simple("dm9000", 1,
> +			&lp8x4x_dm9000_resources[3], 3);

This looks much better than the first version, a slight improvement IMHO would
be to split the resource arrays into one symbol per device to turn this into

platform_device_register_resndata(NULL, "pxa2xx-flash", 0,
			&lp8x4x_flash_resources0, 1,
			&lp8x4x_flash_data0, sizeof(lp8x4x_flash_data0));
platform_device_register_resndata(NULL, "pxa2xx-flash", 1,
			&lp8x4x_flash_resources1, 1,
			&lp8x4x_flash_data1, sizeof(lp8x4x_flash_data1));

It's not important though if you have a strong preference for the way you
did this, it just seems unusual.

	Arnd
