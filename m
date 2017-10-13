From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Oct 2017 10:58:26 -0700
Subject: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <2453698.N4jfPaHx71@aspire.rjw.lan>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
 <20170911151029.25185-2-jeffy.chen@rock-chips.com>
 <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com>
 <2453698.N4jfPaHx71@aspire.rjw.lan>
Message-ID: <20171013175825.GR4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [171013 06:32]:
> [+cc Tony]
> 
> On Friday, October 13, 2017 5:04:41 AM CEST Bjorn Helgaas wrote:
> > [+cc Rafael, linux-pm]
> > On Mon, Sep 11, 2017 at 11:10:27PM +0800, Jeffy Chen wrote:
> > > Add support for PCIE_WAKE pin in rockchip pcie driver.
...
> > > @@ -995,6 +996,15 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
> > >  		return err;
> > >  	}
> > >  
> > > +	/* Must init wakeup before setting dedicated wakeup irq. */
> > > +	device_init_wakeup(dev, true);
> > > +	irq = platform_get_irq_byname(pdev, "wakeup");
> > > +	if (irq >= 0) {
> > > +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> > 
> > I'm a little skeptical about dev_pm_set_dedicated_wake_irq(), not
> > because I know anything at all about it, but because there are only
> > five callers in the whole tree, three of which are in UART code, and
> > none in anything resembling PCI code.

Well it should work for any device that can provide an out of band wakeup
interrupt such as a dedicated GPIO line.

> > Is Rockchip really that special, or are we going about this the wrong
> > way?

Maybe this can be set up in a generic way somewhere similar to what
the I2C bus is doing?

See i2c_device_probe() for dev_pm_set_dedicated_wake_irq() in
drivers/i2c/i2c-core-base.c.

Regards,

Tony
