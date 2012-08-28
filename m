From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 28 Aug 2012 14:20:54 +0200
Subject: [RFC PATCH] ARM: initial DTS support for km_kirkwood
In-Reply-To: <1346154976-16916-1-git-send-email-valentin.longchamp@keymile.com>
References: <1346154976-16916-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20120828122054.GG31704@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valentin

> This is a first attempt to support the km_kirkwood reference design with
> a device tree. This km_kirkwood design is present in many Keymile
> products. It is based on the Marvell Bobcat SOC which integrates a
> Kirkwood CPU next to a big L2 Ethernet Switch. The Kirkwood in the SOC
> is very similar to the "normal" one, but there are a few differences.

Is there a public datasheet for this device?

> diff --git a/arch/arm/mach-kirkwood/board-km_kirkwood.c b/arch/arm/mach-kirkwood/board-km_kirkwood.c
> new file mode 100644
> index 0000000..7a103db
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-km_kirkwood.c
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright 2012 2012 KEYMILE AG, CH-3097 Bern
> + * Valentin Longchamp <valentin.longchamp@keymile.com>
> + *
> + * arch/arm/mach-kirkwood/board-km_kirkwood.c
> + *
> + * Keymile km_kirkwood Reference Desing Init for drivers not converted to
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
> +#include <linux/clk.h>
> +#include <linux/clk-private.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/kirkwood.h>
> +#include <mach/bridge-regs.h>
> +#include <plat/mvsdio.h>
> +#include "common.h"
> +#include "mpp.h"

Please remove all the header files you don't need.

> +
> +static struct mv643xx_eth_platform_data km_kirkwood_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +static unsigned int km_kirkwood_mpp_config[] __initdata = {
> +	MPP8_GPIO,	/* I2C SDA */
> +	MPP9_GPIO,	/* I2C SCL */
> +	0
> +};
> +
> +void __init km_kirkwood_init(void)
> +{
> +	struct clk *sata_clk;
> +	/*
> +	 * Basic setup. Needs to be called early.
> +	 */
> +
> +	kirkwood_mpp_conf(km_kirkwood_mpp_config);
> +
> +	/*
> +	 * Our variant of kirkwood (integrated in the Bobcat) hangs on accessing
> +	 * SATA bits (14-15) of the Clock Gating Control Register. Since these
> +	 * devices are also not present in this variant, their clocks get
> +	 * disabled because unused when clk_disable_unused() gets called.

So there is no SATA at all on this SoC? Anything else missing which a
'normal' kirkwood has?

If there a way to identify the chipset? e.g. what does 

kirkwood_pcie_id(&dev, &rev);

give? It would be better to not create the clocks at all, if we could
determine at runtime the hardware was not there.

Apart from these comments, the patch looks good.

      Andrew
