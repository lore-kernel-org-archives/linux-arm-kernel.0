From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 24 Jul 2015 20:43:12 +0000
Subject: [PATCH 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <55B29D3B.8030402@gmail.com>
References: <1437757979-25889-1-git-send-email-shenwei.wang@freescale.com>
 <55B29D3B.8030402@gmail.com>
Message-ID: <BL2PR03MB370E7898F6A83C726BEF60083810@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 2015?7?24? 15:17
> To: Wang Shenwei-B38339; gregkh at linuxfoundation.org; arnd at arndb.de
> Cc: Huang Yongcai-B20788; linux-arm-kernel at lists.infradead.org;
> computersforpeace at gmail.com
> Subject: Re: [PATCH 1/1] misc: sram: add dev_pm_ops to support module power
> > +	/* Save necessary regs */
> > +	clk_enable(sram->clk);
> > +	memcpy(sram->power_off_save,
> sram->virt_base,gen_pool_size(sram->pool));
> > +	clk_disable(sram->clk);
> 
> memcpy_fromio()?
> 

memcpy is safe to call here, and it should be more efficient.

> > +
> > +	clk_enable(sram->clk);
> > +	memcpy(sram->virt_base, sram->power_off_save,
> > +gen_pool_size(sram->pool));
> 
> memcpy_toio()?
> 

When system goes to suspend state, it will flush the cache in the end. Memcpy here is 
more efficient.

> >  	struct sram_dev *sram;
> > @@ -203,6 +235,12 @@ static int sram_probe(struct platform_device
> > *pdev)
> >
> >  	platform_set_drvdata(pdev, sram);
> >
> > +	if (of_get_property(pdev->dev.of_node, "can-power-gate", NULL))
> 
> Since this is a boolean you could use of_property_read_bool()
> 

Yes, of_property_read_bool is better. Will adopt it.

> > +	{
> > +		sram->power_off_save = devm_kzalloc(&pdev->dev,
> > +				gen_pool_size(sram->pool), GFP_KERNEL);
> 
> Parenthesis not needed.

Will remove it.

> 
> This will only work with SRAM sizes which are small enough they can be serviced
> by kzalloc() allocations. The problem is that you might actually need
> direct-mapped memory but what if you have larger SRAMs that are several MB?
> Maybe there should be a check here to prevent that.
> 

Yes, it will be a problem. I think vmalloc should be used here.

> > +static const struct dev_pm_ops sram_pm_ops = {
> > +	.suspend_noirq = sram_suspend_noirq,
> > +	.resume_noirq = sram_resume_noirq,
> > +};
> 
> You may have to enclose this within an ifdef CONFIG_PM_SLEEP/endif statement
> not to cause warnings if CONFIG_PM_SLEEP is disabled.
> --

The "struct dev_pm_ops *pm" is always a member of device_driver, and it has no
relation with the CONFIG_PM_XXX.

Thanks,
Shenwei

> Florian
