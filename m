From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2018 16:47:56 -0700
Subject: [PATCH 2/3] gpio: omap: Remove custom PM calls and use cpu_pm
 instead
In-Reply-To: <35a1dccf-2b15-2d61-9210-7f3893c27795@ti.com>
References: <20180920193532.7714-1-tony@atomide.com>
 <20180920193532.7714-3-tony@atomide.com>
 <35a1dccf-2b15-2d61-9210-7f3893c27795@ti.com>
Message-ID: <20180920234756.GC5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180920 23:05]:
> On 09/20/2018 02:35 PM, Tony Lindgren wrote:
> > +static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct gpio_bank *bank = platform_get_drvdata(pdev);
> > +	unsigned long flags;
> > +	int error = 0;
> > +
> > +	raw_spin_lock_irqsave(&bank->lock, flags);
> > +	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
> > +	if (bank->irq_usage) {
> > +		error = -EBUSY;
> 
> Sry, I didn't get how will it work with suspend to ram?
> omap_device will call this handler and, seems, abort suspend always
> if gpio bank has gpios requested as IRQ. Am I missing smth?

Heh yeah we have _od_suspend_noirq() call pm_generic_suspend_noirq()
which will succeed. But note how after that omap_device_idle() gets
called only if pm_generic_runtime_suspend() == 0 and we still allow
supend with no error.

So for gpio interrupts there's nothing that needs to be done at that
point and the cpu_pm notifier will take care of things just before
suspend.

Do you have any better ideas?

Regards,

Tony
