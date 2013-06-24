From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 24 Jun 2013 09:04:40 -0700
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <20130624092942.GG26008@lukather>
References: <1371502778-15849-1-git-send-email-oliver+list@schinagl.nl>
 <1371502778-15849-2-git-send-email-oliver+list@schinagl.nl>
 <20130617225847.GA9494@kroah.com> <20130624092942.GG26008@lukather>
Message-ID: <20130624160440.GA15201@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 11:29:42AM +0200, Maxime Ripard wrote:
> Hi Greg,
> 
> On Mon, Jun 17, 2013 at 03:58:47PM -0700, Greg KH wrote:
> > On Mon, Jun 17, 2013 at 10:59:37PM +0200, Oliver Schinagl wrote:
> 
> [..]
> 
> > > +static int __init sunxi_sid_probe(struct platform_device *pdev)
> > > +{
> > > +	u8 entropy[SID_SIZE];
> > > +	unsigned int i;
> > > +	struct resource *res;
> > > +	void __iomem *sid_reg_base;
> > > +	int ret;
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	sid_reg_base = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(sid_reg_base))
> > > +		return PTR_ERR(sid_reg_base);
> > > +	platform_set_drvdata(pdev, sid_reg_base);
> > > +
> > > +	ret = device_create_bin_file(&pdev->dev, &sid_bin_attr);
> > > +	if (ret)
> > > +		return ret;
> > 
> > You just raced with userspace, having the file show up after the device
> > was announced to users that it was there.  Please use the proper device
> > file api to add default attributes to prevent this from happening.
> 
> Sorry if the question looks dumb, but what kind of race can we generate
> here?

Userspace gets told about the device from the driver core, udev runs and
reads all of the attributes, then your probe function comes along and
adds a new attribute.  Userspace will then not know about it at all.

> The device_create_bin_file is the last call that we make (if we except
> the entropy stuff, but it doesn't really matter here), so after we
> created the file, we have everything properly initialised so that our
> functions can be called, right?
> 
> And another dumb question for you, what is the "proper device file API"
> you are referring to ? :)

Please read Documentation/driver_model/device.txt and see the section on
Attributes for what to do.  If you have specific questions after reading
that, please let me know.

thanks,

greg k-h
