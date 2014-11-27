From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Nov 2014 15:05:08 +0000
Subject: [PATCH 1/4] spi: Add new driver for STMicroelectronics' SPI
 Controller
In-Reply-To: <20141127125904.GV7712@sirena.org.uk>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
 <20141127125904.GV7712@sirena.org.uk>
Message-ID: <20141127150508.GI4628@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > +struct spi_st {
> > +	/* SSC SPI Controller */
> > +	struct spi_bitbang	bitbang;
> 
> Is there a good reason for using bitbang over the core transmit_one()
> interface?  The operations are basically the same but more modern and
> the functionality is more discoverable.

I don't know enough about SPI to answer that question.  I will look
into moving over to transmit_one().  Most of the design decisions in
this driver were taken back when you were probably wearing denim
jackets and supporting an afro. ;) 


> > +	} else if (spi_st->bits_per_word == 8 && !(t->len & 0x1)) {
> > +		/*
> > +		 * If transfer is even-length, and 8 bits-per-word, then
> > +		 * implement as half-length 16 bits-per-word transfer
> > +		 */
> > +		spi_st->bytes_per_word = 2;
> > +		spi_st->words_remaining = t->len/2;
> > +
> > +		/* Set SSC_CTL to 16 bits-per-word */
> > +		ctl = readl_relaxed(spi_st->base + SSC_CTL);
> > +		writel_relaxed((ctl | 0xf), spi_st->base + SSC_CTL);
> > +
> > +		readl_relaxed(spi_st->base + SSC_RBUF);
> 
> No byte swapping issues here?

I think this implementation has been pretty heavily tested.  What
should I be looking out for?

[...]

> > +	printk("LEE: %s: %s()[%d]: Probing\n", __FILE__, __func__, __LINE__);
> 
> Tsk.

School boy error!

> > +	spi_st->clk = of_clk_get_by_name(np, "ssc");
> > +	if (IS_ERR(spi_st->clk)) {
> > +		dev_err(&pdev->dev, "Unable to request clock\n");
> > +		ret = PTR_ERR(spi_st->clk);
> > +		goto free_master;
> > +	}
> 
> Why is this of_get_clk_by_name() and not just devm_clk_get()?

Probably historical and I didn't notice.

I'll look into swapping it over.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
