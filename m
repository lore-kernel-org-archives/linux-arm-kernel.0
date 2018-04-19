From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Apr 2018 16:58:18 +0200
Subject: [PATCH 5/9] media: platform: Add Sunxi Cedrus decoder driver
In-Reply-To: <20180309135702.pk4webt7xnj7lrza@flea>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
 <20180309101445.16190-3-paul.kocialkowski@bootlin.com>
 <20180309135702.pk4webt7xnj7lrza@flea>
Message-ID: <d2df04bd29b040001577d3bb905c81b3aff8f594.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi and thanks for the review,

On Fri, 2018-03-09 at 14:57 +0100, Maxime Ripard wrote:
> On Fri, Mar 09, 2018 at 11:14:41AM +0100, Paul Kocialkowski wrote:
> > +/*
> > + * mem2mem callbacks
> > + */
> > +
> > +void job_abort(void *priv)
> > +{}
> 
> Is that still needed?

v2 contains a proper implementation of job abortion, so yes :)

> > +/*
> > + * device_run() - prepares and starts processing
> > + */
> > +void device_run(void *priv)
> > +{
> 
> This function (and the one above) should probably made static. Or at
> least if you can't, they should have a much more specific name in
> order not to conflict with anything from the core.

Agreed, will fix in v2.

> > +	/*
> > +	 * The VPU is only able to handle bus addresses so we have
> > to subtract
> > +	 * the RAM offset to the physcal addresses
> > +	 */
> > +	in_buf     -= PHYS_OFFSET;
> > +	out_luma   -= PHYS_OFFSET;
> > +	out_chroma -= PHYS_OFFSET;
> 
> You should take care of that by putting it in the dma_pfn_offset field
> of the struct device (at least before we come up with something
> better).
> 
> You'll then be able to use the dma_addr_t directly without modifying
> it.

Ditto.

> > +	vpu->syscon = syscon_regmap_lookup_by_phandle(vpu->dev-
> > >of_node,
> > +						      "syscon");
> > +	if (IS_ERR(vpu->syscon)) {
> > +		vpu->syscon = NULL;
> > +	} else {
> > +		regmap_write_bits(vpu->syscon,
> > SYSCON_SRAM_CTRL_REG0,
> > +				  SYSCON_SRAM_C1_MAP_VE,
> > +				  SYSCON_SRAM_C1_MAP_VE);
> > +	}
> 
> This should be using our SRAM controller driver (and API), see
> Documentation/devicetree/bindings/sram/sunxi-sram.txt
> include/linux/soc/sunxi/sunxi_sram.h

This will require adding support for the VE (and the A33 along the way)
in the SRAM driver, so a dedicated patch series will be sent in this
direction eventually.

> > +	ret = clk_prepare_enable(vpu->ahb_clk);
> > +	if (ret) {
> > +		dev_err(vpu->dev, "could not enable ahb clock\n");
> > +		return -EFAULT;
> > +	}
> > +	ret = clk_prepare_enable(vpu->mod_clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(vpu->ahb_clk);
> > +		dev_err(vpu->dev, "could not enable mod clock\n");
> > +		return -EFAULT;
> > +	}
> > +	ret = clk_prepare_enable(vpu->ram_clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(vpu->mod_clk);
> > +		clk_disable_unprepare(vpu->ahb_clk);
> > +		dev_err(vpu->dev, "could not enable ram clock\n");
> > +		return -EFAULT;
> > +	}
> 
> Ideally, this should be using runtime_pm to manage the device power
> state, and disable it when not used.
> 
> > +	reset_control_assert(vpu->rstc);
> > +	reset_control_deassert(vpu->rstc);
> 
> You can use reset_control_reset here

Will do in v2.

> > +	return 0;
> > +}
> > +
> > +void sunxi_cedrus_hw_remove(struct sunxi_cedrus_dev *vpu)
> > +{
> > +	clk_disable_unprepare(vpu->ram_clk);
> > +	clk_disable_unprepare(vpu->mod_clk);
> > +	clk_disable_unprepare(vpu->ahb_clk);
> 
> The device is not put back into reset here

Good catch!

Cheers,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/eb7f5494/attachment.sig>
