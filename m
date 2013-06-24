From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jun 2013 23:04:55 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <20130624160440.GA15201@kroah.com>
References: <1371502778-15849-1-git-send-email-oliver+list@schinagl.nl>
 <1371502778-15849-2-git-send-email-oliver+list@schinagl.nl>
 <20130617225847.GA9494@kroah.com> <20130624092942.GG26008@lukather>
 <20130624160440.GA15201@kroah.com>
Message-ID: <20130624210455.GJ26008@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 09:04:40AM -0700, Greg KH wrote:
> On Mon, Jun 24, 2013 at 11:29:42AM +0200, Maxime Ripard wrote:
> > Hi Greg,
> > 
> > On Mon, Jun 17, 2013 at 03:58:47PM -0700, Greg KH wrote:
> > > On Mon, Jun 17, 2013 at 10:59:37PM +0200, Oliver Schinagl wrote:
> > 
> > [..]
> > 
> > > > +static int __init sunxi_sid_probe(struct platform_device *pdev)
> > > > +{
> > > > +	u8 entropy[SID_SIZE];
> > > > +	unsigned int i;
> > > > +	struct resource *res;
> > > > +	void __iomem *sid_reg_base;
> > > > +	int ret;
> > > > +
> > > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +	sid_reg_base = devm_ioremap_resource(&pdev->dev, res);
> > > > +	if (IS_ERR(sid_reg_base))
> > > > +		return PTR_ERR(sid_reg_base);
> > > > +	platform_set_drvdata(pdev, sid_reg_base);
> > > > +
> > > > +	ret = device_create_bin_file(&pdev->dev, &sid_bin_attr);
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > You just raced with userspace, having the file show up after the device
> > > was announced to users that it was there.  Please use the proper device
> > > file api to add default attributes to prevent this from happening.
> > 
> > Sorry if the question looks dumb, but what kind of race can we generate
> > here?
> 
> Userspace gets told about the device from the driver core, udev runs and
> reads all of the attributes, then your probe function comes along and
> adds a new attribute.  Userspace will then not know about it at all.

Hmm, I see.

Thanks for the explanations!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/8f4b023d/attachment.sig>
