From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Mon, 12 Sep 2016 06:39:45 +0000
Subject: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <1473392840.30217.170.camel@buserror.net>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-6-git-send-email-yangbo.lu@nxp.com>
 <1473392840.30217.170.camel@buserror.net>
Message-ID: <HE1PR04MB08892D8354E38EC32F549E98F8FF0@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

Thanks for your review :)
See my comment inline.

> -----Original Message-----
> From: Scott Wood [mailto:oss at buserror.net]
> Sent: Friday, September 09, 2016 11:47 AM
> To: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Arnd
> Bergmann
> Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> foundation.org; netdev at vger.kernel.org; Mark Rutland; Rob Herring;
> Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie
> Subject: Re: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
> 
> On Tue, 2016-09-06 at 16:28 +0800, Yangbo Lu wrote:
> > The global utilities block controls power management, I/O device
> > enabling, power-onreset(POR) configuration monitoring, alternate
> > function selection for multiplexed signals,and clock control.
> >
> > This patch adds a driver to manage and access global utilities block.
> > Initially only reading SVR and registering soc device are supported.
> > Other guts accesses, such as reading RCW, should eventually be moved
> > into this driver as well.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > Signed-off-by: Scott Wood <oss@buserror.net>
> 
> Don't put my signoff on patches that I didn't put it on
> myself. ?Definitely don't put mine *after* yours on patches that were
> last modified by you.
> 
> If you want to mention that the soc_id encoding was my suggestion, then
> do so explicitly.
> 

[Lu Yangbo-B47093] I found your 'signoff' on this patch at below link.
http://patchwork.ozlabs.org/patch/649211/

So, let me just change the order in next version ?
Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

> > +/* SoC attribute definition for QorIQ platform */ static const struct
> > +soc_device_attribute qoriq_soc[] = { #ifdef CONFIG_PPC
> > +	/*
> > +	?* Power Architecture-based SoCs T Series
> > +	?*/
> > +
> > +	/* SoC: T1024/T1014/T1023/T1013 Rev: 1.0 */
> > +	{ .soc_id	= "svr:0x85400010,name:T1024,die:T1024",
> > +	??.revision	= "1.0",
> > +	},
> > +	{ .soc_id	= "svr:0x85480010,name:T1024E,die:T1024",
> > +	??.revision	= "1.0",
> > +	},
> 
> Revision could be computed from the low 8 bits of SVR (just as you do for
> unknown SVRs).
>
 
[Lu Yangbo-B47093] Yes, you're right. Will remove it here.

> We could move the die name into .family:
> 
> 	{
> 		.soc_id = "svr:0x85490010,name:T1023E,",
> 		.family = "QorIQ T1024",
> 	}
> 
> I see you dropped svre (and the trailing comma), though I guess the vast
> majority of potential users will be looking at .family. ?In which case do
> we even need name? ?If we just make the soc_id be "svr:0xnnnnnnnn" then
> we could shrink the table to an svr+mask that identifies each die. ?I'd
> still want to keep the "svr:" even if we're giving up on the general
> tagging system, to make it clear what the number refers to, and to
> provide some defense against users who match only against soc_id rather
> than soc_id+family. ?Or we could go further and format soc_id as "QorIQ
> SVR 0xnnnnnnnn" so that soc_id-only matches are fully acceptable rather
> than just less dangerous.

[Lu Yangbo-B47093] It's a good idea to move die into .family I think.
In my opinion, it's better to keep svr and name in soc_id just like your suggestion above.
> 	{
> 		.soc_id = "svr:0x85490010,name:T1023E,",
> 		.family = "QorIQ T1024",
> 	}
The user probably don?t like to learn the svr value. What they want is just to match the soc they use.
It's convenient to use name+rev for them to match a soc.

Regarding shrinking the table, I think it's hard to use svr+mask. Because I find many platforms use different masks.
We couldn?t know the mask according svr value.

> 
> > +static const struct soc_device_attribute *fsl_soc_device_match(
> > +	unsigned int svr, const struct soc_device_attribute *matches) {
> > +	char svr_match[50];
> > +	int n;
> > +
> > +	n = sprintf(svr_match, "*%08x*", svr);
> 
> n = sprintf(svr_match, "svr:0x%08x,*", svr);
> 
> (according to the current encoding)
> 

[Lu Yangbo-B47093] Ok. Will do that.

> > +
> > +	do {
> > +		if (!matches->soc_id)
> > +			return NULL;
> > +		if (glob_match(svr_match, matches->soc_id))
> > +			break;
> > +	} while (matches++);
> 
> Are you expecting "matches++" to ever evaluate as false?

[Lu Yangbo-B47093] Yes, this is used to match the soc we use in qoriq_soc array until getting true. 
We need to get the name and die information defined in array.

> 
> > +	/* Register soc device */
> > +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > +	if (!soc_dev_attr) {
> > +		ret = -ENOMEM;
> > +		goto out_unmap;
> > +	}
> 
> Couldn't this be statically allocated?

[Lu Yangbo-B47093] Do you mean we define this struct statically ?

static struct soc_device_attribute soc_dev_attr;

> 
> > +
> > +	machine = of_flat_dt_get_machine_name();
> > +	if (machine)
> > +		soc_dev_attr->machine = kasprintf(GFP_KERNEL, "%s",
> > machine);
> > +
> > +	soc_dev_attr->family = kasprintf(GFP_KERNEL, "QorIQ");
> > +
> > +	svr = fsl_guts_get_svr();
> > +	fsl_soc = fsl_soc_device_match(svr, qoriq_soc);
> > +	if (fsl_soc) {
> > +		soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
> > +						?fsl_soc->soc_id);
> 
> You can use kstrdup() if you're just copying the string as is.

[Lu Yangbo-B47093] Ok. Will do that.

> 
> > +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%s",
> > +						???fsl_soc->revision);
> > +	} else {
> > +		soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%08x",
> > svr);
> 
> 	kasprintf(GFP_KERNEL, "svr:0x%08x,", svr);

[Lu Yangbo-B47093] Sorry, will add that.

> 
> 
> > +
> > +	soc_dev = soc_device_register(soc_dev_attr);
> > +	if (IS_ERR(soc_dev)) {
> > +		ret = -ENODEV;
> 
> Why are you changing the error code?

[Lu Yangbo-B47093] What error code should we use ? :)

> 
> > +		goto out;
> > +	} else {
> 
> Unnecessary "else".

[Lu Yangbo-B47093] Oh.. Correct!

> 
> > +		pr_info("Detected: %s\n", soc_dev_attr->machine);
> 
> Machine: %s

[Lu Yangbo-B47093] Ok. Will do that.

> 
> > +		pr_info("Detected SoC family: %s\n", soc_dev_attr->family);
> > +		pr_info("Detected SoC ID: %s, revision: %s\n",
> > +			soc_dev_attr->soc_id, soc_dev_attr->revision);
> 
> s/Detected //g

[Lu Yangbo-B47093] Ok, will do that.

> 
> 
> > +	}
> > +	return 0;
> > +out:
> > +	kfree(soc_dev_attr->machine);
> > +	kfree(soc_dev_attr->family);
> > +	kfree(soc_dev_attr->soc_id);
> > +	kfree(soc_dev_attr->revision);
> > +	kfree(soc_dev_attr);
> > +out_unmap:
> > +	iounmap(guts->regs);
> > +out_free:
> > +	kfree(guts);
> 
> devm

[Lu Yangbo-B47093] What's the devm meaning here :)
 
> 
> > +static int fsl_guts_remove(struct platform_device *dev) {
> > +	kfree(soc_dev_attr->machine);
> > +	kfree(soc_dev_attr->family);
> > +	kfree(soc_dev_attr->soc_id);
> > +	kfree(soc_dev_attr->revision);
> > +	kfree(soc_dev_attr);
> > +	soc_device_unregister(soc_dev);
> > +	iounmap(guts->regs);
> > +	kfree(guts);
> > +	return 0;
> > +}
> 
> Don't free the memory before you unregister the device that uses it (moot
> if you use devm).

[Lu Yangbo-B47093] The soc.c driver mentions that.
Ensure soc_dev->attr is freed prior to calling soc_device_unregister.

> 
> >
> > +#ifdef CONFIG_FSL_GUTS
> > +unsigned int fsl_guts_get_svr(void);
> > +#endif
> 
> Don't ifdef prototypes (unless you're going to provide a stub
> alternative).

[Lu Yangbo-B47093] Ok, will remove ifdef.

> 
> -Scott
