From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Fri, 28 Oct 2016 06:00:03 +0000
Subject: [v13, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <1477629956.6812.15.camel@buserror.net>
References: <1477625554-46700-1-git-send-email-yangbo.lu@nxp.com>
 <1477625554-46700-6-git-send-email-yangbo.lu@nxp.com>
 <1477629956.6812.15.camel@buserror.net>
Message-ID: <DB6PR0401MB2536E2CE7B604554F52AF3AFF8AD0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> owner at vger.kernel.org] On Behalf Of Scott Wood
> Sent: Friday, October 28, 2016 12:46 PM
> To: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Arnd
> Bergmann
> Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> foundation.org; netdev at vger.kernel.org; Greg Kroah-Hartman; Mark Rutland;
> Rob Herring; Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil;
> Bhupesh Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B.
> Xie; M.H. Lian
> Subject: Re: [v13, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
> 
> On Fri, 2016-10-28 at 11:32 +0800, Yangbo Lu wrote:
> > +	guts->regs = of_iomap(np, 0);
> > +	if (!guts->regs)
> > +		return -ENOMEM;
> > +
> > +	/* Register soc device */
> > +	machine = of_flat_dt_get_machine_name();
> > +	if (machine)
> > +		soc_dev_attr.machine = devm_kstrdup(dev, machine,
> > GFP_KERNEL);
> > +
> > +	svr = fsl_guts_get_svr();
> > +	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> > +	if (soc_die) {
> > +		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
> > +						?????"QorIQ %s", soc_die-
> > >die);
> > +	} else {
> > +		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
> > "QorIQ");
> > +	}
> > +	soc_dev_attr.soc_id = devm_kasprintf(dev, GFP_KERNEL,
> > +					?????"svr:0x%08x", svr);
> > +	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
> > +					???????SVR_MAJ(svr), SVR_MIN(svr));
> > +
> > +	soc_dev = soc_device_register(&soc_dev_attr);
> > +	if (IS_ERR(soc_dev))
> > +		return PTR_ERR(soc_dev);
> 
> ioremap leaks on this error path. ?Use devm_ioremap_resource().
> 

[Lu Yangbo-B47093] Ok. I have fixed it in v14. Thanks :)

> -Scott
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
