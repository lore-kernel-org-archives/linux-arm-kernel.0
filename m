From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 24 Jul 2018 11:06:54 +0200
Subject: [PATCH v6 5/5] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <eebba930-b3d7-3670-3d96-35cc6c2a6bcb@pengutronix.de>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-6-o.rempel@pengutronix.de>
 <1532366380.3163.109.camel@pengutronix.de>
 <eebba930-b3d7-3670-3d96-35cc6c2a6bcb@pengutronix.de>
Message-ID: <1532423214.32306.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 24.07.2018, 07:14 +0200 schrieb Oleksij Rempel:
> Hi Lucas,
> 
> here is more detailed response:
> 
> On 23.07.2018 19:19, Lucas Stach wrote:
[...]
> > > +};
> > > +
> > > +static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
> > > +{
> > > > +	return container_of(mbox, struct imx_mu_priv, mbox);
> > > 
> > > +}
> > > +
> > > +static void imx_mu_write(struct imx_mu_priv *priv, u32 val, u32 offs)
> > > +{
> > > +	iowrite32(val, priv->base + offs);
> > 
> > This driver is never going to be used on a device with port based IO,
> > so iowrite doesn't make much sense here, just use writel. Same comment
> > applies to the below read function.
> 
> As before I don't really understand the difference. I took some time for
> learning and here are my findings:
> - historical background of ioread/iowrite functions. What I can find is
> > this LWN article: https://lwn.net/Articles/102232/ . The main point
> seems to be "The first of these is a new __iomem annotation used to mark
> pointers to I/O memory" ... " As with __user, the __iomem marker serves
> a documentation role in the kernel code;"
> 
> In modern kernel the difference between ioread32 and readl seems to be
> completely disappeared.
> with this LWN article (2016):
> https://lwn.net/Articles/698014/
> the readl and reade32 are always in the same group..

Okay, as discussed offline this is more a thing of personal preference,
since this maps to the same thing internally when used on a
architecture without IO ports. I slightly dislike those as they don't
have a _relaxed counterpart, but other than that there should be no
difference. As we don't use any of the relaxed stuff in this driver
it's really about the color of the bikeshed, so feel free to keep it
your way.

> If there is some documentation which will say why I should use readl()
> instead of ioread32() i would really love to read it.
> 
> > Also, given that those functions are not really shortening the code in
> > the user they may also be removed completely IMHO.
> 
> Wrong assumption..??I use this functions for tracing. It is just to easy
> to add two trace points...??From technical perspective I don't see any
> advantage or disadvantage of having this functions.
> If it is my personal preference, then I decide to keep it.

That IMHO implies that I'm perfectly fine with you ignoring this
comment. :)

[...]
> > > +static int imx_mu_startup(struct mbox_chan *chan)
> > > +{
> > > > > > > > +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> > > > > > > > +	struct imx_mu_con_priv *cp = chan->con_priv;
> > > > +	int ret;
> > > 
> > > +
> > > > > > > > +	cp->irq_desc = devm_kasprintf(priv->dev, GFP_KERNEL, "imx_mu_chan[%i]",
> > > > > > > > +				??????cp->idx);
> > > > > > > > +	if (!cp->irq_desc)
> > > > +		return -ENOMEM;
> > > 
> > > +
> > > > +	ret = devm_request_irq(priv->dev, cp->irq, imx_mu_isr,
> > > 
> > > +			???????IRQF_SHARED, cp->irq_desc, chan);
> > 
> > Using the devm_ variants of those functions doesn't make sense when the
> > resources aren't tied to the device lifetime. As you are tearing them
> > down manually in imx_mu_shutdown anyways, just use the raw variants of
> > those functions.
> 
> I have nothing against it.

Thanks, as this is something I feel more strongly about. As the devm_
stuff is meant to tie the lifetime of an object to the device/driver
lifetime using them in a context where there is no relation at all is
kind of an API abuse to me.

Regards,
Lucas
