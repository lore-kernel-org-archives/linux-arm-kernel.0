From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 May 2015 10:15:35 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <4862159.g8Sk9nOiS2@wuerfel>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-3-git-send-email-maxime.ripard@free-electrons.com>
 <4862159.g8Sk9nOiS2@wuerfel>
Message-ID: <20150513081535.GS10961@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, May 12, 2015 at 05:49:08PM +0200, Arnd Bergmann wrote:
> On Tuesday 12 May 2015 17:37:37 Maxime Ripard wrote:
> > From: Lior Amsalem <alior@marvell.com>
> > 
> > The Marvell Armada 38x SoC introduce new features to the XOR engine,
> > especially the fact that the engine mode (MEMCPY/XOR/PQ/etc) can be part of
> > the descriptor and not set through the controller registers.
> > 
> > This new feature allows mixing of different commands (even PQ) on the same
> > channel/chain without the need to stop the engine to reconfigure the engine
> > mode.
> > 
> > Refactor the driver to be able to use that new feature on the Armada 38x,
> > while keeping the old behaviour on the older SoCs.
> > 
> > Signed-off-by: Lior Amsalem <alior@marvell.com>
> > Reviewed-by: Ofer Heifetz <oferh@marvell.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Two minimal style comments:
> 
> > +static void mv_chan_set_mode_to_desc(struct mv_xor_chan *chan)
> > +{
> > +	u32 op_mode;
> > +	u32 config = readl_relaxed(XOR_CONFIG(chan));
> > +
> > +	op_mode = XOR_OPERATION_MODE_IN_DESC;
> > +
> > +	config &= ~0x7;
> > +	config |= op_mode;
> > +
> > +#if defined(__BIG_ENDIAN)
> > +	config |= XOR_DESCRIPTOR_SWAP;
> > +#else
> > +	config &= ~XOR_DESCRIPTOR_SWAP;
> > +#endif
> > +
> > +	writel_relaxed(config, XOR_CONFIG(chan));
> > +}
> 
> Using 
> 
> 	if (IS_ENABLED(__BIG_ENDIAN))
> 
> here would make it more readable by avoiding the #if.

Indeed. I'll change that.

> Alternatively, you could leave the XOR_DESCRIPTOR_SWAP flag disabled
> and just swap the descriptors manually like a lot of other drivers
> do. You have to swap the mmio accesses anywya.

That won't be easily doable however.

Not only the endianness of the individual fields in the descriptor
changes, but changing the endianness also swaps the fields themselves
by pair of u32.

You can see that here:
http://lxr.free-electrons.com/source/drivers/dma/mv_xor.h#L159

So I'm guessing that leaving it like it is was the more readable
solution.

> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id mv_xor_dt_ids[] = {
> > +	{ .compatible = "marvell,orion-xor", .data = (void *)XOR_MODE_IN_REG },
> > +	{ .compatible = "marvell,a38x-xor", .data = (void *)XOR_MODE_IN_DESC },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, mv_xor_dt_ids);
> > +#endif
> > +
> 
> Just leave out the #ifdef here. Almost all the mvebu machines use DT now,
> so it's not worth the size benefit of leaving it out on the few machines
> that don't.
> 
> You'll have to remove the of_match_ptr() invocation as well if you do that,
> to avoid a warning about an unused symbol.

Will do.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/4d57f15b/attachment.sig>
