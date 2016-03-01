From: minghuan.lian@nxp.com (Minghuan Lian)
Date: Tue, 1 Mar 2016 11:03:18 +0000
Subject: [PATCH 2/2 v3] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <56D41A04.8030302@arm.com>
References: <1454403648-5551-1-git-send-email-Minghuan.Lian@nxp.com>
 <1454403648-5551-2-git-send-email-Minghuan.Lian@nxp.com>
 <56C4AE17.4050301@arm.com>
 <VI1PR04MB1615735FD9B40547228B7B51E8A60@VI1PR04MB1615.eurprd04.prod.outlook.com>
 <56D41A04.8030302@arm.com>
Message-ID: <VI1PR04MB1615FC4AF3790E22107E7AE5E8BB0@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Please see my comments inline.

Thanks,
Minghaun

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Monday, February 29, 2016 6:14 PM
> To: Minghuan Lian <minghuan.lian@nxp.com>;
> linux-arm-kernel at lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>; Jason Cooper
> <jason@lakedaemon.net>; Roy Zang <roy.zang@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Yang-Leo Li
> <leoyang.li@nxp.com>; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 2/2 v3] irqchip/Layerscape: Add SCFG MSI controller
> support
> 
> On 25/02/16 03:21, Minghuan Lian wrote:
> > Hi Marc,
> >
> > I am sorry for the delayed response due to the Chinese Spring Festival holiday.
> > Thank you very much for the review.
> > Please see my comments inline.
> >
> > Thanks,
> > Minghuan
> >
> 
> [...]
> 
> >>> +static int ls_scfg_msi_probe(struct platform_device *pdev) {
> >>> +	struct ls_scfg_msi *msi_data;
> >>> +	struct resource *res;
> >>> +	int ret;
> >>> +
> >>> +	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data),
> GFP_KERNEL);
> >>> +	if (!msi_data)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> +	msi_data->regs = devm_ioremap_resource(&pdev->dev, res);
> >>> +	if (IS_ERR(msi_data->regs)) {
> >>> +		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
> >>> +		return PTR_ERR(msi_data->regs);
> >>> +	}
> >>> +	msi_data->msiir_addr = res->start;
> >>> +
> >>> +	msi_data->irq = platform_get_irq(pdev, 0);
> >>> +	if (msi_data->irq <= 0) {
> >>> +		dev_err(&pdev->dev, "failed to get MSI irq\n");
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	msi_data->pdev = pdev;
> >>> +	msi_data->nr_irqs = MSI_MAX_IRQS;
> >>
> >> So this is hardcoded, always. Why do you need a nr_irqs variable at all?
> > [Lian Minghuan-B31939] Currently, nr_irqs is always 32, but in the
> > future, the MSI controller may be extended to support more IRQs. And,
> > we may set nr_irqs the value of less than 32 to reserve some IRQs for
> > special usage. So nr_irqs can bring flexibility
> 
> You have to choose: either this is configurable and you describe it in
> DT, or this is not and you drop this field from the structure.
> 
> As for the "reserved interrupts", that would need to be described too.
> 
[Minghuan Lian] I will drop this field in next version.
The old version of LS1021a only supports one MSI interrupt. So the driver needs to change nr_irq to 1.
Anyway, this issue has been fixed. Now, all the Layerscape SoC supports 32 MSI interrupts.

> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
