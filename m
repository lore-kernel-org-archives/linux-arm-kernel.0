From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Mar 2017 11:47:35 +0100
Subject: [PATCH 2/3] clk: sunxi-ng: add support for PRCM CCUs
In-Reply-To: <20170301041541.24388-3-icenowy@aosc.xyz>
References: <20170301041541.24388-1-icenowy@aosc.xyz>
 <20170301041541.24388-3-icenowy@aosc.xyz>
Message-ID: <20170301104735.4dkqgxobozkosfgc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 12:15:40PM +0800, Icenowy Zheng wrote:
> SoCs after A31 has a clock controller module in the PRCM part.
> 
> Support the clock controller module on H5 and A64 now.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  drivers/clk/sunxi-ng/Kconfig            |   6 +
>  drivers/clk/sunxi-ng/Makefile           |   1 +
>  drivers/clk/sunxi-ng/ccu-sun6i-r.c      | 209 ++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun6i-r.h      |  27 +++++
>  include/dt-bindings/clock/sun6i-r-ccu.h |  58 +++++++++
>  include/dt-bindings/reset/sun6i-r-ccu.h |  54 +++++++++
>  6 files changed, 355 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-r.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-r.h
>  create mode 100644 include/dt-bindings/clock/sun6i-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun6i-r-ccu.h
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 695bbf9ef428..44984c050052 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -141,4 +141,10 @@ config SUN9I_A80_CCU
>  	select SUNXI_CCU_PHASE
>  	default MACH_SUN9I
>  
> +config SUN6I_R_CCU

This is not ordered.

> +	bool "Support for Allwinner SoCs' PRCM CCUs"
> +	select SUNXI_CCU_DIV
> +	select SUNXI_CCU_GATE
> +	default MACH_SUN8I || (ARCH_SUNXI && ARM64)

And you can't build it for A31?

> +
>  endif
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 6feaac0c5600..77ebcfd7d2ca 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
>  obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
>  obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
> +obj-$(CONFIG_SUN6I_R_CCU)	+= ccu-sun6i-r.o
>  obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
>  obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
>  obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-r.c b/drivers/clk/sunxi-ng/ccu-sun6i-r.c
> new file mode 100644
> index 000000000000..988d6b299e91
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-r.c
> @@ -0,0 +1,209 @@
> +/*
> + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_nm.h"
> +
> +#include "ccu-sun6i-r.h"
> +
> +static const char * const cpus_parents[] = { "osc32k", "osc24M",
> +					     "pll-periph0" };

You need another pll-periph0 here, the value 3 is valid.

And that pll should be in your binding.

> +
> +static struct ccu_div cpus_clk = {
> +	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
> +
> +	.mux		= {
> +		.shift	= 16,
> +		.width	= 2,
> +
> +		.variable_prediv	= {
> +			.index	= 2,
> +			.shift	= 8,
> +			.width	= 5,
> +		},
> +	},
> +
> +	.common		= {
> +		.reg		= 0x00,
> +		.features	= CCU_FEATURE_VARIABLE_PREDIV,
> +		.hw.init	= CLK_HW_INIT_PARENTS("cpus",

We've been calling it ar100 so far.

> +						      cpus_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static CLK_FIXED_FACTOR(r_ahb0_clk, "r-ahb0", "cpus", 1, 1, 0);

ahb0 is by definition in the PRCM, there's no need to prefix it by
"r-".

> +
> +static struct ccu_div r_apb0_clk = {
> +	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO),
> +
> +	.common		= {
> +		.reg		= 0x0c,
> +		.hw.init	= CLK_HW_INIT("r-apb0",

Ditto.

> +					      "r-ahb0",
> +					      &ccu_div_ops,
> +					      0),
> +	},
> +};
> +
> +static SUNXI_CCU_GATE(r_bus_pio_clk,	"r-bus-pio",	"r-apb0",
> +		      0x28, BIT(0), 0);

apb0-pio

> +static SUNXI_CCU_GATE(r_bus_ir_clk,	"r-bus-ir",	"r-apb0",
> +		      0x28, BIT(1), 0);

apb0-ir

> +static SUNXI_CCU_GATE(r_bus_timer_clk,	"r-bus-timer",	"r-apb0",
> +		      0x28, BIT(2), 0);

apb0-timer

> +static SUNXI_CCU_GATE(r_bus_rsb_clk,	"r-bus-rsb",	"r-apb0",
> +		      0x28, BIT(3), 0);

This is not RSB on the A31

> +static SUNXI_CCU_GATE(r_bus_uart_clk,	"r-bus-uart",	"r-apb0",
> +		      0x28, BIT(4), 0);

And the A31 also has a 1-wire clock here.

> +static SUNXI_CCU_GATE(r_bus_i2c_clk,	"r-bus-i2c",	"r-apb0",
> +		      0x28, BIT(6), 0);
> +
> +static const char * const r_mod0_default_parents[] = { "osc32K", "osc24M" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(r_ir_clk, "r-ir",

ir is enough.

I'm a bit worried by that to be honest. You claim to support the A31,
yet jugdging by the current state of that code you never actually
tested it on that SoC.

What makes you say that the PRCM clocks are the same for the H3 and
A64? We have to be sure, otherwise we might not be able to get the DT
binding right from the very beginning, and we might not be able to fix
it later.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170301/3cd0f578/attachment.sig>
