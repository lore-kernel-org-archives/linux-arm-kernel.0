From: oss@buserror.net (Scott Wood)
Date: Mon, 12 Sep 2016 18:25:14 -0500
Subject: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <HE1PR04MB08892D8354E38EC32F549E98F8FF0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-6-git-send-email-yangbo.lu@nxp.com>
 <1473392840.30217.170.camel@buserror.net>
 <HE1PR04MB08892D8354E38EC32F549E98F8FF0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Message-ID: <1473722714.30217.196.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-09-12 at 06:39 +0000, Y.B. Lu wrote:
> Hi Scott,
> 
> Thanks for your review :)
> See my comment inline.
> 
> > 
> > -----Original Message-----
> > From: Scott Wood [mailto:oss at buserror.net]
> > Sent: Friday, September 09, 2016 11:47 AM
> > To: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Arnd
> > Bergmann
> > Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> > clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> > foundation.org; netdev at vger.kernel.org; Mark Rutland; Rob Herring;
> > Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> > Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie
> > Subject: Re: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
> > 
> > On Tue, 2016-09-06 at 16:28 +0800, Yangbo Lu wrote:
> > > 
> > > The global utilities block controls power management, I/O device
> > > enabling, power-onreset(POR) configuration monitoring, alternate
> > > function selection for multiplexed signals,and clock control.
> > > 
> > > This patch adds a driver to manage and access global utilities block.
> > > Initially only reading SVR and registering soc device are supported.
> > > Other guts accesses, such as reading RCW, should eventually be moved
> > > into this driver as well.
> > > 
> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > Signed-off-by: Scott Wood <oss@buserror.net>
> > Don't put my signoff on patches that I didn't put it on
> > myself. ?Definitely don't put mine *after* yours on patches that were
> > last modified by you.
> > 
> > If you want to mention that the soc_id encoding was my suggestion, then
> > do so explicitly.
> > 
> [Lu Yangbo-B47093] I found your 'signoff' on this patch at below link.
> http://patchwork.ozlabs.org/patch/649211/
> 
> So, let me just change the order in next version ?
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

No. ?This isn't my patch so my signoff shouldn't be on it.

> [Lu Yangbo-B47093] It's a good idea to move die into .family I think.
> In my opinion, it's better to keep svr and name in soc_id just like your
> suggestion above.
> > 
> > 	{
> > 		.soc_id = "svr:0x85490010,name:T1023E,",
> > 		.family = "QorIQ T1024",
> > 	}
> The user probably don?t like to learn the svr value. What they want is just
> to match the soc they use.
> It's convenient to use name+rev for them to match a soc.

What the user should want 99% of the time is to match the die (plus revision),
not the soc.

> Regarding shrinking the table, I think it's hard to use svr+mask. Because I
> find many platforms use different masks.
> We couldn?t know the mask according svr value.

The mask would be part of the table:

{
	{
		.die = "T1024",
		.svr = 0x85400000,
		.mask = 0xfff00000,
	},
	{
		.die = "T1040",
		.svr = 0x85200000,
		.mask = 0xfff00000,
	},
	{
		.die = "LS1088A",
		.svr = 0x87030000,
		.mask = 0xffff0000,
	},
	...
}

There's a small risk that we get the mask wrong and a different die is created
that matches an existing table, but it doesn't seem too likely, and can easily
be fixed with a kernel update if it happens.

BTW, aren't ls2080a and ls2085a the same die? ?And is there no non-E version
of LS2080A/LS2040A?

> > > +	do {
> > > +		if (!matches->soc_id)
> > > +			return NULL;
> > > +		if (glob_match(svr_match, matches->soc_id))
> > > +			break;
> > > +	} while (matches++);
> > Are you expecting "matches++" to ever evaluate as false?
> [Lu Yangbo-B47093] Yes, this is used to match the soc we use in qoriq_soc
> array until getting true.?
> We need to get the name and die information defined in array.

I'm not asking whether the glob_match will ever return true. ?I'm saying that
"matches++" will never become NULL.

> > > +	/* Register soc device */
> > > +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > +	if (!soc_dev_attr) {
> > > +		ret = -ENOMEM;
> > > +		goto out_unmap;
> > > +	}
> > Couldn't this be statically allocated?
> [Lu Yangbo-B47093] Do you mean we define this struct statically ?
> 
> static struct soc_device_attribute soc_dev_attr;

Yes.

> > > +
> > > +	soc_dev = soc_device_register(soc_dev_attr);
> > > +	if (IS_ERR(soc_dev)) {
> > > +		ret = -ENODEV;
> > Why are you changing the error code?
> [Lu Yangbo-B47093] What error code should we use ? :)

ret = PTR_ERR(soc_dev);

+	}
> > > +	return 0;
> > > +out:
> > > +	kfree(soc_dev_attr->machine);
> > > +	kfree(soc_dev_attr->family);
> > > +	kfree(soc_dev_attr->soc_id);
> > > +	kfree(soc_dev_attr->revision);
> > > +	kfree(soc_dev_attr);
> > > +out_unmap:
> > > +	iounmap(guts->regs);
> > > +out_free:
> > > +	kfree(guts);
> > devm
> [Lu Yangbo-B47093] What's the devm meaning here :)

If you allocate these with devm_kzalloc(), devm_kasprintf(), devm_kstrdup(),
etc. then they will be freed automatically when the device is unbound.

> ?
> > 
> > 
> > > 
> > > +static int fsl_guts_remove(struct platform_device *dev) {
> > > +	kfree(soc_dev_attr->machine);
> > > +	kfree(soc_dev_attr->family);
> > > +	kfree(soc_dev_attr->soc_id);
> > > +	kfree(soc_dev_attr->revision);
> > > +	kfree(soc_dev_attr);
> > > +	soc_device_unregister(soc_dev);
> > > +	iounmap(guts->regs);
> > > +	kfree(guts);
> > > +	return 0;
> > > +}
> > Don't free the memory before you unregister the device that uses it (moot
> > if you use devm).
> [Lu Yangbo-B47093] The soc.c driver mentions that.
> Ensure soc_dev->attr is freed prior to calling soc_device_unregister.

That comment is wrong. ?Freeing the memory first creates a race condition that
could result in accessing freed memory, if something accesses the soc device
in parallel with unbinding.

-Scott
