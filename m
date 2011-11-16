From: p-combes@ti.com (Patrick Combes)
Date: Wed, 16 Nov 2011 15:39:00 +0100
Subject: [RFC][PATCH] gpiolib: add irq_wake (power-management) sysfs file
In-Reply-To: <20111115172053.GB9581@n2100.arm.linux.org.uk>
References: <1321004406-15663-1-git-send-email-p-combes@ti.com>
 <20111115131636.GA31028@sirena.org.uk>
 <20111115172053.GB9581@n2100.arm.linux.org.uk>
Message-ID: <20111116143857.GB5847@una0919255>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 05:20:53PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2011 at 01:16:37PM +0000, Mark Brown wrote:
> > On Fri, Nov 11, 2011 at 10:40:06AM +0100, Patrick Combes wrote:
> > > +	else if (sysfs_streq(buf, "enable") || sysfs_streq(buf, "1"))
> > > +		status = enable_irq_wake(gpio_to_irq(gpio));
> > > +	else if (sysfs_streq(buf, "disable") || sysfs_streq(buf, "0"))
> > > +		status = disable_irq_wake(gpio_to_irq(gpio));
> > > +	else
> > > +		status = -EINVAL;
> > 
> > ...this doesn't do anything to stop userspace doing multiple enables and
> > disables.
> 
> It doesn't check whether gpio_to_irq(gpio) returns something sane either.
> It should be doing something like this before taking the mutex:
> 
> 	irq = gpio_to_irq(gpio);
> 	if (irq <= 0)
> 		return irq < 0 ? irq : -EINVAL;
> 
> and then doing (enable|disable)_irq_wake() on irq.

Ok I add this check
