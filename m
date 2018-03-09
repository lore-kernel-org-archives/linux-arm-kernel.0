From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 09 Mar 2018 15:25:22 +0100
Subject: [PATCH 5/9] media: platform: Add Sunxi Cedrus decoder driver
In-Reply-To: <20180309135702.pk4webt7xnj7lrza@flea>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
 <20180309101445.16190-3-paul.kocialkowski@bootlin.com>
 <20180309135702.pk4webt7xnj7lrza@flea>
Message-ID: <1520605522.15946.14.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2018-03-09 at 14:57 +0100, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Mar 09, 2018 at 11:14:41AM +0100, Paul Kocialkowski wrote:
> > +/*
> > + * mem2mem callbacks
> > + */
> > +
> > +void job_abort(void *priv)
> > +{}
> 
> Is that still needed?

It looks like we need a dummy callback here, the v4l2_m2m_init function
puts a hard requirement on it.

The feature is definitely not used for now, but maybe this could be
hooked to aborting the matching request? It was probably designed for
the case where the driver handles a queue of jobs on its own (that's how
it's used in vim2m) and such an internal queue is perhaps irrelevant
when using the request API (and fences later).

> > +/*
> > + * device_run() - prepares and starts processing
> > + */
> > +void device_run(void *priv)
> > +{
> 
> This function (and the one above) should probably made static. Or at
> least if you can't, they should have a much more specific name in
> order not to conflict with anything from the core.

Good point, let's go for static. Since these are passed as function
pointers, it shouldn't be a problem.

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

Definitely!

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

I'll look into that.

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

I'll add that to my tasks list. I suppose we shouldn't make this a
priority for now, but this is definitely good to have.

> > +	reset_control_assert(vpu->rstc);
> > +	reset_control_deassert(vpu->rstc);
> 
> You can use reset_control_reset here

Noted!

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

Good catch, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/36053b68/attachment.sig>
