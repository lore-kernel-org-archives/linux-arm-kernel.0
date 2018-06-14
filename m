From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 14 Jun 2018 17:39:53 +0200
Subject: [PATCH v3 11/14] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <20180507154201.4vz3y6j7u7kzfud6@flea>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-12-paul.kocialkowski@bootlin.com>
 <20180507154201.4vz3y6j7u7kzfud6@flea>
Message-ID: <042923c4f378f3e134bf490d5f6a650173984411.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-05-07 at 17:42 +0200, Maxime Ripard wrote:
> On Mon, May 07, 2018 at 02:44:57PM +0200, Paul Kocialkowski wrote:
> > +#define SYSCON_SRAM_CTRL_REG0	0x0
> > +#define SYSCON_SRAM_C1_MAP_VE	0x7fffffff
> 
> This isn't needed anymore

Will do in the next revision.

> > +	dev->ahb_clk = devm_clk_get(dev->dev, "ahb");
> > +	if (IS_ERR(dev->ahb_clk)) {
> > +		dev_err(dev->dev, "failed to get ahb clock\n");
> > +		return PTR_ERR(dev->ahb_clk);
> > +	}
> > +	dev->mod_clk = devm_clk_get(dev->dev, "mod");
> > +	if (IS_ERR(dev->mod_clk)) {
> > +		dev_err(dev->dev, "failed to get mod clock\n");
> > +		return PTR_ERR(dev->mod_clk);
> > +	}
> > +	dev->ram_clk = devm_clk_get(dev->dev, "ram");
> > +	if (IS_ERR(dev->ram_clk)) {
> > +		dev_err(dev->dev, "failed to get ram clock\n");
> > +		return PTR_ERR(dev->ram_clk);
> > +	}
> 
> Please add some blank lines between those blocks

Yes, looks much better that way!

> > +	dev->rstc = devm_reset_control_get(dev->dev, NULL);
> 
> You're not checking the error code here

Good catch.

> > +	dev->syscon = syscon_regmap_lookup_by_phandle(dev->dev->of_node,
> > +						      "syscon");
> > +	if (IS_ERR(dev->syscon)) {
> > +		dev->syscon = NULL;
> > +	} else {
> > +		regmap_write_bits(dev->syscon, SYSCON_SRAM_CTRL_REG0,
> > +				  SYSCON_SRAM_C1_MAP_VE,
> > +				  SYSCON_SRAM_C1_MAP_VE);
> > +	}
> 
> You don't need the syscon part anymore either

Correct.

> > +	ret = clk_prepare_enable(dev->ahb_clk);
> > +	if (ret) {
> > +		dev_err(dev->dev, "could not enable ahb clock\n");
> > +		return -EFAULT;
> > +	}
> > +	ret = clk_prepare_enable(dev->mod_clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(dev->ahb_clk);
> > +		dev_err(dev->dev, "could not enable mod clock\n");
> > +		return -EFAULT;
> > +	}
> > +	ret = clk_prepare_enable(dev->ram_clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(dev->mod_clk);
> > +		clk_disable_unprepare(dev->ahb_clk);
> > +		dev_err(dev->dev, "could not enable ram clock\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	ret = reset_control_reset(dev->rstc);
> > +	if (ret) {
> > +		clk_disable_unprepare(dev->ram_clk);
> > +		clk_disable_unprepare(dev->mod_clk);
> > +		clk_disable_unprepare(dev->ahb_clk);
> > +		dev_err(dev->dev, "could not reset device\n");
> > +		return -EFAULT;
> 
> labels would simplify this greatly, and you should also release the
> sram and the memory region here.

I'll definitely do a sweep and add labels/gotos for this before
submitting the nexr revision.

Thanks for the review!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180614/71c6d245/attachment.sig>
