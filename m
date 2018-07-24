From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 24 Jul 2018 16:56:57 +0200
Subject: [PATCH v5 18/22] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <20180710084223.jguogmvlwloi2utf@flea>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-19-paul.kocialkowski@bootlin.com>
 <20180710084223.jguogmvlwloi2utf@flea>
Message-ID: <25fee2b5ad35f46ccadf56b93d1a9261c9855f97.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2018-07-10 at 10:42 +0200, Maxime Ripard wrote:
> On Tue, Jul 10, 2018 at 10:01:10AM +0200, Paul Kocialkowski wrote:
> > +static int cedrus_remove(struct platform_device *pdev)
> > +{
> > +       struct cedrus_dev *dev = platform_get_drvdata(pdev);
> > +
> > +       v4l2_info(&dev->v4l2_dev, "Removing " CEDRUS_NAME);
> 
> That log is kind of pointless.

Fair enough, I'll get rid of it.

> > +static void cedrus_hw_set_capabilities(struct cedrus_dev *dev)
> > +{
> > +	unsigned int engine_version;
> > +
> > +	engine_version = cedrus_read(dev, VE_VERSION) >> VE_VERSION_SHIFT;
> > +
> > +	if (engine_version >= 0x1667)
> > +		dev->capabilities |= CEDRUS_CAPABILITY_UNTILED;
> 
> The version used here would need a define, but I'm wondering if this
> is the right solution here. You are using at the same time the version
> ID returned by the register and the compatible in various places, and
> they are both redundant. If you want to base the capabilities on the
> compatible, then you can do it for all of those properties and
> capabilities, and if you want to use the version register, then you
> don't need all those compatibles but just one.
> 
> I think that basing all our capabilities on the compatible makes more
> sense, since you need to have access to the registers in order to read
> the version register, and this changes from one SoC generation to the
> other (for example, keeping the reset line asserted would prevent you
> from reading it, and the fact that there is a reset line depends on
> the SoC).

I concur, let's move this to a compatible-based logic instead!

> > +int cedrus_hw_probe(struct cedrus_dev *dev)
> > +{
> > +	struct resource *res;
> > +	int irq_dec;
> > +	int ret;
> > +
> > +	irq_dec = platform_get_irq(dev->pdev, 0);
> > +	if (irq_dec <= 0) {
> > +		v4l2_err(&dev->v4l2_dev, "Failed to get IRQ\n");
> > +		return -ENXIO;
> > +	}
> 
> You already have an error code returned by platform_get_irq, there's
> no point in masking it and returning -ENXIO. This can even lead to
> some bugs, for example when the error code is EPROBE_DEFER.

Right, I'll fix this and all the similar issues you mentionned.

[...]

> There's also a bunch of warnings/checks reported by checkpatch that
> should be fixed in the next iteration: the spaces after a cast, the
> NULL comparison, macros arguments precedence, parenthesis alignments
> issues, etc.)

Thanks, I'll look into that for the next revision.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/2e27a68b/attachment.sig>
