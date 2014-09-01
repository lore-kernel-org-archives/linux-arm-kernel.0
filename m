From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Sep 2014 18:27:11 +0100
Subject: [RFC PATCH for Juno 1/2] net: smsc911x add support for probing
 from ACPI
In-Reply-To: <21764799.KDNDm9XRax@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <20140901170447.GF608@arm.com> <21764799.KDNDm9XRax@wuerfel>
Message-ID: <20140901172711.GI608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 06:11:44PM +0100, Arnd Bergmann wrote:
> On Monday 01 September 2014 18:04:47 Catalin Marinas wrote:
> > On Mon, Sep 01, 2014 at 04:06:00PM +0100, Hanjun Guo wrote:
> > > +#ifdef CONFIG_ACPI
> > > +/* Configure some sensible defaults for ACPI mode */
> > > +static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
> > > +                                 acpi_handle *ahandle)
> > > +{
> > > +     if (!ahandle)
> > > +             return -ENOSYS;
> > > +
> > > +     config->phy_interface = PHY_INTERFACE_MODE_MII;
> > > +
> > > +     config->flags |= SMSC911X_USE_32BIT;
> > > +
> > > +     config->irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_HIGH;
> > > +
> > > +     config->irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL;
> > > +
> > > +     return 0;
> > > +}
> > > +#else
> > 
> > I don't like this and it shows issues we have with ACPI on certain ARM
> > platforms. You hard-code these values to match the Juno platform. What
> > if we get another SoC which has different configuration here? For DT, we
> > have the smsc911x_probe_config_dt() which reads the relevant information
> > from DT. I think this kind of configuration would be more suitable as
> > _DSD properties and sharing the similar names with DT (but we go back to
> > the question about who's in charge of the _DSD properties).
> 
> Good point, I totally missed that.
> 
> There is of course the possibility to set those values based on the
> acpi_device_id, but that is exactly the part that _DSD is trying to
> avoid.

I would prefer to avoid acpi_device_id checks. This would defeat the
alleged aim of ACPI to run newer hardware configuration with older
kernels.

> > >  static int smsc911x_drv_probe(struct platform_device *pdev)
> > >  {
> > >       struct device_node *np = pdev->dev.of_node;
> > > +     acpi_handle *ahandle = ACPI_HANDLE(&pdev->dev);
> > >       struct net_device *dev;
> > >       struct smsc911x_data *pdata;
> > >       struct smsc911x_platform_config *config = dev_get_platdata(&pdev->dev);
> > > @@ -2436,6 +2464,9 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
> > >       }
> > >  
> > >       retval = smsc911x_probe_config_dt(&pdata->config, np);
> > > +     if (retval)
> > > +             retval = smsc911x_probe_config_acpi(&pdata->config, ahandle);
> > > +
> > 
> > In most of the ACPI patches so far we check for ACPI first with DT as a
> > fall-back if ACPI is not enabled. This changes here.
> 
> Does this really make a difference?

Not the order (well, someone may think that if they unflatten the DT in
a vendor kernel even though it boot as ACPI, they could get away with a
mix of DT and ACPI ;)).

> > I would prefer
> > something which probes only ACPI if the ACPI is enabled (run-time, not
> > config) otherwise DT only. E.g.
> 
> (example missing?)

I was looking through the code and forgot. Something like:

	if (acpi_disabled)
		retval = smsc911x_probe_config_dt();
	else
		retval = smsc911x_probe_config_acpi();

> I think we should have the equivalent of of_have_populated_dt(), to
> check whether acpi is being used to boot, and have that new function
> be hardcoded to zero in case of !IS_ENABLED(CONFIG_ACPI).

I think you meant hardcoded to 1 when !ACPI. That would work as well.

-- 
Catalin
