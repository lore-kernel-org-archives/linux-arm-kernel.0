From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 12 Jul 2011 04:57:59 +0530
Subject: [PATCH v14 05/12] OMAP: dmtimer: platform driver
In-Reply-To: <20110711231055.GA8312@google.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
	<1310383759-19059-6-git-send-email-tarun.kanti@ti.com>
	<20110711231055.GA8312@google.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BE7806F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Todd Poynor [mailto:toddpoynor at google.com]
> Sent: Tuesday, July 12, 2011 4:41 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap at vger.kernel.org; Hilman, Kevin; Shilimkar, Santosh;
> tony at atomide.com; linux-arm-kernel at lists.infradead.org; Gopinath, Thara
> Subject: Re: [PATCH v14 05/12] OMAP: dmtimer: platform driver
> 
> On Mon, Jul 11, 2011 at 04:59:12PM +0530, Tarun Kanti DebBarma wrote:
> > Add dmtimer platform driver functions which include:
> > (1) platform driver initialization
> > (2) driver probe function
> > (3) driver remove function
> >
> ...
> > +	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> > +	if (!timer) {
> > +		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
> > +			__func__);
> > +		ret = -ENOMEM;
> > +		goto err_release_ioregion;
> > +	}
> > +
> > +	timer->io_base = ioremap(mem->start, resource_size(mem));
> > +	if (!timer->io_base) {
> > +		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
> > +		ret = -ENOMEM;
> > +		goto err_free_mem;
> > +	}
> > +
> > +	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
> > +		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
> > +		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
> > +	} else {
> > +		timer->func_offset = 0;
> > +		timer->intr_offset = 0;
> 
> Don't need to init kzalloc'ed fields to zero.
Yes, I will remove.

> 
> > +	}
> > +
> > +	timer->id = pdev->id;
> > +	timer->irq = irq->start;
> > +	timer->pdev = pdev;
> > +	timer->reserved = 0;
> 
> And here.
Yes.
> 
> > +err_free_pdev:
> > +	kfree(pdata);
> 
> pdata wasn't allocated here, shouldn't be freed here.
Yes, I will correct the error handling labels appropriately.

> 
> > +	platform_device_unregister(pdev);
> 
> The platform device wasn't registered here.
Oops... I will remove. Thanks.

> 
> ...
> > +static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
> > +{
> > +	struct omap_dm_timer *timer, *tmp;
> > +	unsigned long flags;
> > +	int ret = -EINVAL;
> > +
> > +	spin_lock_irqsave(&dm_timer_lock, flags);
> > +	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
> 
> 
> Don't need list_for_each_entry_safe, you have the lock protecting list
> modifications held and IRQs off.
Ok.

> 
> > +		if (timer->pdev->id == pdev->id) {
> > +			kfree(timer->pdev->dev.platform_data);
> 
> 
> Not allocated by this driver.
In fact it gets automatically freed. I will remove.

> 
> > +			platform_device_del(timer->pdev);
> 
> 
> Not added by this driver.
Ok.
--
Tarun
> 
> > +			list_del(&timer->node);
> > +			kfree(timer);
> 
> 
> Todd
