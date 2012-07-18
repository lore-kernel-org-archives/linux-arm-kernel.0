From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Jul 2012 12:04:35 +0200
Subject: [RFC PATCHv3 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform
In-Reply-To: <20120718091407.0489e501@skate>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
 <1342572656-5205-2-git-send-email-dinguyen@altera.com>
 <20120718091407.0489e501@skate>
Message-ID: <20120718100435.GA7607@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +struct clk {
> > +	unsigned long rate;
> > +};
> > +
> > +static struct clk apb_pclk = { .rate = 200000000};
> > +static struct clk i2c_clk = { .rate = 100000000};
> > +static struct clk spim_clk = { .rate = 100000000};
> > +static struct clk mpu_pclk = { .rate = SOCFPGA_MPU_PERIHCLK_FREQ_HZ};
> > +static struct clk l4_main_clk = { .rate = SOCFPGA_L4_MAIN_CLK};
> > +
> > +static struct clk_lookup lookups[] = {
> > +	{ .clk = &apb_pclk, .con_id = "apb_pclk", },
> > +	{ .clk = &i2c_clk, .dev_id = "ffc04000.i2c", },
> > +	{ .clk = &i2c_clk, .dev_id = "ffc05000.i2c", },
> > +	{ .clk = &spim_clk, .dev_id = "dw-spi-mmio.0", },
> > +	{ .clk = &spim_clk, .dev_id = "dw-spi-mmio.1", },
> > +	{ .clk = &mpu_pclk, .dev_id = "smp_twd", },
> > +	{ .clk = &l4_main_clk, .dev_id = "dma-pl330", },
> > +};
> > +
> > +void __init socfpga_init_clocks(void)
> > +{
> > +	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> > +}
> 
> I am not sure this is the proper way of using the clock framework.
> Individual platforms should no longer define their own "struct clk".
> They should either use the common clock types (fixed rate, fixed
> factor, divider, mux, gate, etc.). or implement their own specialized
> clock types.
> 
> So in your case, since you apparently only have fixed rate clock, you
> would use clk_register_fixed_rate() to register your clocks, and it
> would return to you an opaque 'struct clk' reference.
> 
> For more details, you can look at Documentation/clk.txt.

Ok, I had version that did that at one point. But... as bootloader
currently sets up the clock, this code is currently mostly unused. So
what about removing it from initial merge and re-adding it when it is
used/neccessary?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
