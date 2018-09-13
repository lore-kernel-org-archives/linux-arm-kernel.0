From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 13 Sep 2018 17:11:19 +0000
Subject: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
In-Reply-To: <20180912011003.GA14928@darwi-kernel>
References: <1536701697-23949-4-git-send-email-jollys@xilinx.com>
 <20180912011003.GA14928@darwi-kernel>
Message-ID: <CY1PR02MB2138E4213DF88A2CEDAFED2CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ahmed,

Thanks for the review. I will take care of suggested changes in next version.

Thanks,
Jolly Shah


> -----Original Message-----
> From: Ahmed S. Darwish [mailto:darwish.07 at gmail.com]
> Sent: Tuesday, September 11, 2018 6:10 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> geert+renesas at glider.be; bjorn.andersson at linaro.org;
> sean.wang at mediatek.com; m.szyprowski at samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt at kernel.org; mark.rutland at arm.com; Rajan
> Vaja <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
> 
> Hi!
> 
> [ Thanks a lot for upstreaming this.. ]
> 
> On Tue, Sep 11, 2018 at 02:34:57PM -0700, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add ZynqMP PM driver. PM driver provides power management support for
> > ZynqMP.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> 
> [...]
> 
> > +static irqreturn_t zynqmp_pm_isr(int irq, void *data) {
> > +	u32 payload[CB_PAYLOAD_SIZE];
> > +
> > +	zynqmp_pm_get_callback_data(payload);
> > +
> > +	/* First element is callback API ID, others are callback arguments */
> > +	if (payload[0] == PM_INIT_SUSPEND_CB) {
> > +		if (work_pending(&zynqmp_pm_init_suspend_work-
> >callback_work))
> > +			goto done;
> > +
> > +		/* Copy callback arguments into work's structure */
> > +		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
> > +		       sizeof(zynqmp_pm_init_suspend_work->args));
> > +
> > +		queue_work(system_unbound_wq,
> > +			   &zynqmp_pm_init_suspend_work->callback_work);
> 
> We already have devm_request_threaded_irq() which can does this
> automatically for us.
> 
> Use that method to register the ISR instead, then if there's more work to do, just
> do the memcpy and return IRQ_WAKE_THREAD.
> 
> > +	}
> > +
> > +done:
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * zynqmp_pm_init_suspend_work_fn() - Initialize suspend
> > + * @work:	Pointer to work_struct
> > + *
> > + * Bottom-half of PM callback IRQ handler.
> > + */
> > +static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
> > +{
> > +	struct zynqmp_pm_work_struct *pm_work =
> > +		container_of(work, struct zynqmp_pm_work_struct,
> callback_work);
> > +
> > +	if (pm_work->args[0] ==
> ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
> 
> we_really_seem_to_love_long_40_col_names_for_some_reason
> 
> > +		orderly_poweroff(true);
> > +	} else if (pm_work->args[0] ==
> > +		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
> 
> Ditto
> 
> [...]
> 
> > +/**
> > + * zynqmp_pm_sysfs_init() - Initialize PM driver sysfs interface
> > + * @dev:	Pointer to device structure
> > + *
> > + * Return: 0 on success, negative error code otherwise  */ static int
> > +zynqmp_pm_sysfs_init(struct device *dev) {
> > +	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr); }
> > +
> 
> Sysfs file is created in platform driver's probe(), but is not removed anywhere in
> the code.
> 
> What happens if this is built as a module? Am I missing something obvious?
> 
> Moreover, what's the wisdom of creating a one-liner function with a huge six-
> line comment that:
> 
>     a) _purely_ wraps sysfs_create_file(); no extra logic
>     b) is called only once
>     c) and not passed as a function pointer anywhere
> 
> IMO Such one-liner translators obfuscate the code and review process with no
> apparent gain..
> 
> > +/**
> > + * zynqmp_pm_probe() - Probe existence of the PMU Firmware
> > + *		       and initialize debugfs interface
> > + *
> > + * @pdev:	Pointer to the platform_device structure
> > + *
> > + * Return: Returns 0 on success, negative error code otherwise  */
> 
> Again, huge 8-line comment that provide no value.
> 
> If anyone wants to know what a platform driver probe() does, he or she better
> check the primary references at:
> 
>     - Documentation/driver-model/platform.txt
>     - include/linux/platform_device.h
> 
> and not the comment above..
> 
> > +static int zynqmp_pm_probe(struct platform_device *pdev) {
> > +	int ret, irq;
> > +	u32 pm_api_version;
> > +
> > +	const struct zynqmp_eemi_ops *eemi_ops =
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops-
> >init_finalize)
> > +		return -ENXIO;
> > +
> > +	eemi_ops->init_finalize();
> > +	eemi_ops->get_api_version(&pm_api_version);
> > +
> > +	/* Check PM API version number */
> > +	if (pm_api_version < ZYNQMP_PM_VERSION)
> > +		return -ENODEV;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq <= 0)
> > +		return -ENXIO;
> > +
> > +	ret = devm_request_irq(&pdev->dev, irq, zynqmp_pm_isr,
> IRQF_SHARED,
> > +			       dev_name(&pdev->dev), pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
> > +			irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	zynqmp_pm_init_suspend_work =
> > +		devm_kzalloc(&pdev->dev, sizeof(struct
> zynqmp_pm_work_struct),
> > +			     GFP_KERNEL);
> > +	if (!zynqmp_pm_init_suspend_work)
> > +		return -ENOMEM;
> > +
> > +	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
> > +		  zynqmp_pm_init_suspend_work_fn);
> > +
> 
> Let's use devm_request_threaded_irq(). Then we can completely remove the
> work_struct, INIT_WORK(), and queuue_work() bits.
> 
> > +	ret = zynqmp_pm_sysfs_init(&pdev->dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> 
> Just return 0 please. BTW ret was declared without initialization.
> 
> > +}
> > +
> > +static const struct of_device_id pm_of_match[] = {
> > +	{ .compatible = "xlnx,zynqmp-power", },
> > +	{ /* end of table */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, pm_of_match);
> > +
> > +static struct platform_driver zynqmp_pm_platform_driver = {
> > +	.probe = zynqmp_pm_probe,
> > +	.driver = {
> > +		.name = "zynqmp_power",
> > +		.of_match_table = pm_of_match,
> > +	},
> > +};
> 
> .remove with a basic sysfs_remove_file() is needed.
> 
> Thanks,
> 
> --
> Darwi
> http://darwish.chasingpointers.com
