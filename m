From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Jul 2012 09:14:07 +0200
Subject: [RFC PATCHv3 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform
In-Reply-To: <1342572656-5205-2-git-send-email-dinguyen@altera.com>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
 <1342572656-5205-2-git-send-email-dinguyen@altera.com>
Message-ID: <20120718091407.0489e501@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Tue, 17 Jul 2012 18:50:55 -0600,
<dinguyen@altera.com> a ?crit :

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Adding core definitions for Altera's SOCFPGA ARM platform.

Looks much better, but I have one more comment, below.

> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> new file mode 100644
> index 0000000..fcd71aa
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk.c
> @@ -0,0 +1,47 @@
> +/*
> + *  Copyright (C) 2012 Altera Corporation <www.altera.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +
> +#define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
> +#define SOCFPGA_L4_MAIN_CLK					(400000000)
> +
> +struct clk {
> +	unsigned long rate;
> +};
> +
> +static struct clk apb_pclk = { .rate = 200000000};
> +static struct clk i2c_clk = { .rate = 100000000};
> +static struct clk spim_clk = { .rate = 100000000};
> +static struct clk mpu_pclk = { .rate = SOCFPGA_MPU_PERIHCLK_FREQ_HZ};
> +static struct clk l4_main_clk = { .rate = SOCFPGA_L4_MAIN_CLK};
> +
> +static struct clk_lookup lookups[] = {
> +	{ .clk = &apb_pclk, .con_id = "apb_pclk", },
> +	{ .clk = &i2c_clk, .dev_id = "ffc04000.i2c", },
> +	{ .clk = &i2c_clk, .dev_id = "ffc05000.i2c", },
> +	{ .clk = &spim_clk, .dev_id = "dw-spi-mmio.0", },
> +	{ .clk = &spim_clk, .dev_id = "dw-spi-mmio.1", },
> +	{ .clk = &mpu_pclk, .dev_id = "smp_twd", },
> +	{ .clk = &l4_main_clk, .dev_id = "dma-pl330", },
> +};
> +
> +void __init socfpga_init_clocks(void)
> +{
> +	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> +}

I am not sure this is the proper way of using the clock framework.
Individual platforms should no longer define their own "struct clk".
They should either use the common clock types (fixed rate, fixed
factor, divider, mux, gate, etc.). or implement their own specialized
clock types.

So in your case, since you apparently only have fixed rate clock, you
would use clk_register_fixed_rate() to register your clocks, and it
would return to you an opaque 'struct clk' reference.

For more details, you can look at Documentation/clk.txt.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
