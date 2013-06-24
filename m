From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jun 2013 11:29:42 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <20130617225847.GA9494@kroah.com>
References: <1371502778-15849-1-git-send-email-oliver+list@schinagl.nl>
 <1371502778-15849-2-git-send-email-oliver+list@schinagl.nl>
 <20130617225847.GA9494@kroah.com>
Message-ID: <20130624092942.GG26008@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Mon, Jun 17, 2013 at 03:58:47PM -0700, Greg KH wrote:
> On Mon, Jun 17, 2013 at 10:59:37PM +0200, Oliver Schinagl wrote:

[..]

> > +static int __init sunxi_sid_probe(struct platform_device *pdev)
> > +{
> > +	u8 entropy[SID_SIZE];
> > +	unsigned int i;
> > +	struct resource *res;
> > +	void __iomem *sid_reg_base;
> > +	int ret;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	sid_reg_base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(sid_reg_base))
> > +		return PTR_ERR(sid_reg_base);
> > +	platform_set_drvdata(pdev, sid_reg_base);
> > +
> > +	ret = device_create_bin_file(&pdev->dev, &sid_bin_attr);
> > +	if (ret)
> > +		return ret;
> 
> You just raced with userspace, having the file show up after the device
> was announced to users that it was there.  Please use the proper device
> file api to add default attributes to prevent this from happening.

Sorry if the question looks dumb, but what kind of race can we generate
here?

The device_create_bin_file is the last call that we make (if we except
the entropy stuff, but it doesn't really matter here), so after we
created the file, we have everything properly initialised so that our
functions can be called, right?

And another dumb question for you, what is the "proper device file API"
you are referring to ? :)

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/2bb28f3d/attachment.sig>
