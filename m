From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 24 Aug 2009 11:04:07 +0200
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090822081806.GD29382@infomag.iguana.be>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
Message-ID: <20090824090407.GA24894@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wim Van Sebroeck wrote:
> Hi Thierry,
> 
> > + * linux/drivers/watchdog/adx_wdt.c
> 
> Please change this to adx_wdt.c . If the tree get's moved then we don't want to review every driver to get this "fixed".
> 
> > +struct adx_wdt_nb {
> > +	struct adx_wdt *wdt;
> > +};
> 
> Is this being used?

No. I missed it when replacing the reboot/shutdown notifier code.

> > +static void adx_wdt_set_timeout(struct adx_wdt *wdt, unsigned long timeout)
> > +{
> > +	unsigned long flags;
> > +	unsigned int state;
> > +
> > +	spin_lock_irqsave(&wdt->lock, flags);
> > +	state = wdt->state;
> > +	adx_wdt_stop_locked(wdt);
> > +	writel(timeout, wdt->base + ADX_WDT_TIMEOUT);
> > +
> > +	if (state == WDT_STATE_START)
> > +		adx_wdt_start_locked(wdt);
> > +
> > +	wdt->timeout = timeout;
> > +	spin_unlock_irqrestore(&wdt->lock, flags);
> > +}
> 
> You implemented the timeout towards userspace indeed as seconds. Internally you are using milliseconds.
> I would prefer to see the conversion from seconds to milliseconds taking place in the adx_wdt_set_timeout function.
> This will make conversion to the new watchdog api easier.
> 
> I just thought about having the internal timeout routines being in milliseconds.
> Most watchdogs use seconds anyway, so that would mean a lot of multiply and divide by 1000 or additional code that isn't going to be a benefit. So I prefer to stick to seconds.

Okay. I've moved the conversion to the adx_wdt_set_timeout() function and all
other code now passes seconds to that function (I also renamed the parameter
to "seconds" to clarify this).

> > +static int adx_wdt_open(struct inode *inode, struct file *file)
> > +{
> > +	struct adx_wdt *wdt = platform_get_drvdata(adx_wdt_dev);
> > +
> > +	if (test_and_set_bit(0, &driver_open))
> > +		return -EBUSY;
> > +
> > +	adx_wdt_set_timeout(wdt, 30 * 1000);
> > +	adx_wdt_start(wdt);
> > +	file->private_data = wdt;
> > +
> > +	return nonseekable_open(inode, file);
> > +}
> 
> I prefer to have file->private_data = wdt; to be set before you start the watchdog.

Done.

> > +static int adx_wdt_ioctl(struct inode *inode, struct file *file,
> > +		unsigned int cmd, unsigned long arg)
> 
> we use unlocked_ioctl. Ths should thus be:
> static long adx_wdt_ioctl(struct file *file, unsigned int cmd,
> 						unsigned long arg)

Done.

> > +{
> > +	struct adx_wdt *wdt = file->private_data;
> > +	void __user *argp = (void __user *)arg;
> > +	unsigned long __user *p = argp;
> > +	unsigned long timeout = 0;
> > +	unsigned int options;
> > +	int ret = -EINVAL;
> > +
> > +	switch (cmd) {
> > +	case WDIOC_GETSUPPORT:
> > +		if (copy_to_user(argp, &adx_wdt_info, sizeof(adx_wdt_info)))
> > +			return -EFAULT;
> > +		else
> > +			return 0;
> > +
> > +	case WDIOC_GETSTATUS:
> > +	case WDIOC_GETBOOTSTATUS:
> > +		return put_user(!!(0), p);
> 
> Why not just "return put_user(0, p);"?

Done.

> > +static const struct file_operations adx_wdt_fops = {
> > +	.owner = THIS_MODULE,
> > +	.llseek = no_llseek,
> > +	.open = adx_wdt_open,
> > +	.release = adx_wdt_release,
> > +	.ioctl = adx_wdt_ioctl,
> 
> And then this becomes: .unlocked_ioctl = adx_wdt_ioctl,

Done.

> > +	.write = adx_wdt_write,
> > +};
> > +
> > +static struct miscdevice adx_wdt_miscdev = {
> > +	.minor = WATCHDOG_MINOR,
> > +	.name = "watchdog",
> > +	.fops = &adx_wdt_fops,
> > +};
> > +
> > +static irqreturn_t adx_wdt_interrupt(int irq, void *dev_id)
> > +{
> > +	struct adx_wdt *wdt = dev_id;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&wdt->lock, flags);
> > +	writel(wdt->timeout, wdt->base + ADX_WDT_TIMEOUT);
> > +	spin_unlock_irqrestore(&wdt->lock, flags);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> What's this for? a watchdog driver is controlled by userspace and not retriggered via an interrupt.
> It's userspace that needs to control wether or not we are in a stable situation or not.
> See discussion with Wan ZongShun 2 to 3 weeks ago.

The watchdog can also be programmed to only trigger an interrupt instead of
resetting the hardware on timeout. In that case the timeout register needns
to be written to clear the interrupt.

> > +
> > +static int __devinit adx_wdt_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *res;
> > +	struct adx_wdt *wdt;
> > +	int ret = 0;
> > +
> > +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > +	if (!wdt) {
> > +		dev_err(&pdev->dev, "cannot allocate WDT structure\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	spin_lock_init(&wdt->lock);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "cannot obtain I/O memory region\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	res = devm_request_mem_region(&pdev->dev, res->start,
> > +			res->end - res->start + 1, res->name);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "cannot request I/O memory region\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	wdt->base = devm_ioremap_nocache(&pdev->dev, res->start,
> > +			res->end - res->start + 1);
> > +	if (!wdt->base) {
> > +		dev_err(&pdev->dev, "cannot remap I/O memory region\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "cannot obtain IRQ\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	wdt->irq = res->start;
> > +
> > +	ret = devm_request_irq(&pdev->dev, wdt->irq, adx_wdt_interrupt,
> > +			IRQF_SHARED, WATCHDOG_NAME, wdt);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "cannot request IRQ\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	ret = misc_register(&adx_wdt_miscdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "cannot register miscdev on minor %d "
> > +				"(err=%d)\n", WATCHDOG_MINOR, ret);
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, wdt);
> > +	adx_wdt_dev = pdev;
> 
> Please put these 2 lines in front of the misc_register.

Done.

> > +
> > +	return 0;
> > +}
> > +
> > +static int __devexit adx_wdt_remove(struct platform_device *pdev)
> > +{
> > +	struct adx_wdt *wdt = platform_get_drvdata(pdev);
> > +
> > +	platform_set_drvdata(pdev, NULL);
> > +	misc_deregister(&adx_wdt_miscdev);
> > +	adx_wdt_stop(wdt);
> 
> and put the platform_set_drvdata after the adx_wdt_stop.

Done.

> > +
> > +	return 0;
> > +}
> > +
> 
> Thanks in advance,
> Wim.

Thanks for the review.
Thierry
