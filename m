From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jul 2012 07:27:31 +0000
Subject: [RFC PATCHv3 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform
In-Reply-To: <1342572656-5205-2-git-send-email-dinguyen@altera.com>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
 <1342572656-5205-2-git-send-email-dinguyen@altera.com>
Message-ID: <201207180727.32041.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, dinguyen at altera.com wrote:
> +struct clk {
> +       unsigned long rate;
> +};
> +
> +static struct clk apb_pclk = { .rate = 200000000};
> +static struct clk i2c_clk = { .rate = 100000000};
> +static struct clk spim_clk = { .rate = 100000000};
> +static struct clk mpu_pclk = { .rate = SOCFPGA_MPU_PERIHCLK_FREQ_HZ};
> +static struct clk l4_main_clk = { .rate = SOCFPGA_L4_MAIN_CLK};
> +
> +static struct clk_lookup lookups[] = {
> +       { .clk = &apb_pclk, .con_id = "apb_pclk", },

I have one comment left: You still define "struct clk" privately here,
which means that any driver using clk_get and clk_get_rate will
access an invalid data structure and not get the rate you put in here.

I believe you just need to be using clk_register_fixed_rate()
rather than defining the clk structures statically.

	Arnd
