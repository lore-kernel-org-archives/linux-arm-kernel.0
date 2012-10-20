From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 10:58:34 +0200
Subject: [PATCH] ARM: Kirkwood: new board USI Topkick
In-Reply-To: <1350679752-11931-1-git-send-email-jason@lakedaemon.net>
References: <1350679752-11931-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20121020085834.GY21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/arch/arm/boot/dts/kirkwood-topkick.dts
> @@ -0,0 +1,85 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +
> +/ {
> +	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
> +	compatible = "usi,topkick-1281P2", "usi,topkick", "marvell,kirkwood-88f6282", "marvell,kirkwood";

Hi Jason

Nice to see the correct Kirkwood variant in DT. This is going to be an
issue for pinctrl sometime soon.

> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;

Could nr-ports be 1? It saves a little bit of memory. There only seems
to be one SATA interface available, no external SATA port. However, if
the one used is the second SATA, then 2 is required.

> diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
> new file mode 100644
> index 0000000..02ba4aa
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
> + *
> + * arch/arm/mach-kirkwood/board-dreamplug.c
> + *
> + * Marvell DreamPlug Reference Board Init for drivers not converted to
> + * flattened device tree yet.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/ata_platform.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/gpio.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/kirkwood.h>
> +#include <mach/bridge-regs.h>
> +#include <linux/platform_data/mmc-mvsdio.h>
> +#include "common.h"
> +#include "mpp.h"

A lot of these header files are not needed. Please could you remove
the unused ones.

> +
> +static struct mv643xx_eth_platform_data topkick_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +/*
> + * GPIO LED layout
> + *
> + *       /-SYS_LED(2)
> + *       |
> + *       |   /-DISK_LED
> + *       |   |
> + *       |   |   /-WLAN_LED(2)
> + *       |   |   |
> + * [SW] [*] [*] [*]
> + */
> +
> +/*
> + * Switch positions
> + *
> + *     /-SW_LEFT
> + *     |
> + *     |   /-SW_IDLE
> + *     |   |
> + *     |   |   /-SW_RIGHT
> + *     |   |   |
> + * PS [L] [I] [R] LEDS
> + */
> +
> +static unsigned int topkick_mpp_config[] __initdata = {
> +	MPP21_GPIO,	/* DISK_LED           (low active) - yellow */
> +	MPP36_GPIO,	/* SATA0 power enable (high active) */
> +	MPP37_GPIO,	/* SYS_LED2           (low active) - red */
> +	MPP38_GPIO,	/* SYS_LED            (low active) - blue */
> +	MPP39_GPIO,	/* WLAN_LED           (low active) - green */
> +	MPP43_GPIO,	/* SW_LEFT            (low active) */
> +	MPP44_GPIO,     /* SW_RIGHT           (low active) */
> +	MPP45_GPIO,	/* SW_IDLE            (low active) */
> +	MPP46_GPIO,     /* SW_LEFT            (low active) */
> +	MPP48_GPIO,	/* WLAN_LED2          (low active) - yellow */
> +	0

This assumes the boot loader is configuring all the other pins as
needed.  It would be safer to explicitly configure the SATA pins,
Ethernet pins etc. However, maybe that should wait until we have
pinctrl, which makes it a lot easier.

> +};
> +
> +#define TOPKICK_SATA0_PWR_ENABLE 36
> +
> +void __init usi_topkick_init(void)
> +{
> +	/*
> +	 * Basic setup. Needs to be called early.
> +	 */
> +	kirkwood_mpp_conf(topkick_mpp_config);
> +
> +	/* SATA0 power enable */
> +	gpio_set_value(TOPKICK_SATA0_PWR_ENABLE, 1);

It would be nice to be able to do that in DT. Does such a binding
already exist? Its something we need quite often in kirkwood, and i
guess other machines architectures as well.

> +
> +	kirkwood_ehci_init();
> +	kirkwood_ge00_init(&topkick_ge00_data);
> +}

How is the wifi device instantiated? Is it a PCIe device so it
auto-probed? Or is some explicit instantiation required, say if its an
SPI device?

It would be good to add this board to kirkwood_defconfig as well.

   Andrew
