From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 11:10:29 +0100
Subject: [PATCH v2 1/9] irqchip: meson: add support for gpio interrupt
 controller
In-Reply-To: <1477039751.15560.88.camel@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-2-git-send-email-jbrunet@baylibre.com>
 <ec297647-1ab7-7e6b-5945-be8360f92421@arm.com>
 <1477039751.15560.88.camel@baylibre.com>
Message-ID: <20161021101029.GD15372@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 10:49:11AM +0200, Jerome Brunet wrote:
> On Thu, 2016-10-20 at 17:33 +0100, Marc Zyngier wrote:
> > On 19/10/16 16:21, Jerome Brunet wrote:
> > > +struct meson_gpio_irq_chip_data {
> > > +	void __iomem *base;
> > > +	int index;
> > > +};
> > > +
> > > +static irq_hw_number_t meson_parent_hwirqs[] = {
> > > +	64, 65, 66, 67, 68, 69, 70, 71,
> > > +};
> > 
> > If that a guarantee that these numbers will always represent the
> > parent interrupt?
> 
> At the moment, the 3 supported SoC use these parent interrupts, but we
> have absolutely no idea (or guarantee) that is will remain the same, or
> even contiguous, in the upcoming SoC (like the GXM or GXL)
> 
> I reckon, it is likely that manufacturer will keep on using these
> parent irqs for a while but I would prefer not make an assumption about
> it in the driver.
> 
> If a SoC get a different set of interrupts I would have added a new
> table like this and passed it to the appropriate params :
> 
> static irq_hw_number_t meson_new_parent_hwirqs[] = {
> 	143, 144, 150, 151, 152, 173, 178, 179,
> };
> 
> > It feels a bit odd not to get that information directly from
> > the device tree, in the form of a device specific property. Something
> > like:
> > 
> > 	upstream-interrupts = <64 65 66 ... >;
> > 
> 
> I wondered about putting this information in DT or in the driver for a
> while. Maybe DT would be a more suitable place holder for these data
> (parent irq and number of provided hwirq) but I was under the
> understanding that we should now put these information in the driver
> and use the compatible property to get the appropriate parameters.
> 
> I'd love to get the view of the DT guys on this.

Please describe inter-device relationships in DT when you are aware of
them. The SoC-specific compatible string is more of a future-proofing
thing / last restort for things we realise too late.

To be clear, we should *also* have an soc-specific compatible string,
but for differences we already know about, we should use DT properties.

> > > +static const struct meson_gpio_irq_params meson8b_params = {
> > > +	.nhwirq??= 119,
> > > +	.source??= meson_parent_hwirqs,
> > > +	.nsource = ARRAY_SIZE(meson_parent_hwirqs),
> > > +};
> > > +
> > > +static const struct meson_gpio_irq_params meson_gxbb_params = {
> > > +	.nhwirq??= 133,
> > > +	.source??= meson_parent_hwirqs,
> > > +	.nsource = ARRAY_SIZE(meson_parent_hwirqs),
> > > +};
> > 
> > Same thing. How big is the variability of these structures? Are we
> > going to see more of those? or is that now set into stone?
> 
> The number of pad mapped to the controller seems to change with every
> SoC version. The parent irqs have not changed so far, but as explained
> above, there is no guarantee it will keep on being this way.
> 
> So i'd say probably more of those ...
> 
> > +Mark: what's the policy to describe this kind of things?

Generally, I'd prefer that we describe this in DT rather than
accumulating a set of string -> number mappings in the driver.

Thanks,
Mark.
