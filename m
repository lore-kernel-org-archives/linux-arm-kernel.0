From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 17:32 +0200
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <20140901152854.GJ2953@xora-haswell.xora.org.uk>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <2861461.8zNpLC3I2n@wuerfel> <20140901152854.GJ2953@xora-haswell.xora.org.uk>
Message-ID: <40491090.z7F1jbVZzH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 16:28:54 Graeme Gregory wrote:
> On Mon, Sep 01, 2014 at 05:17:51PM +0200, Arnd Bergmann wrote:
> > On Monday 01 September 2014 23:06:00 Hanjun Guo wrote:
> > > +#ifdef CONFIG_ACPI
> > > +/* Configure some sensible defaults for ACPI mode */
> > > +static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
> > > +                                   acpi_handle *ahandle)
> > > +{
> > > +       if (!ahandle)
> > > +               return -ENOSYS;
> > > +
> > > +       config->phy_interface = PHY_INTERFACE_MODE_MII;
> > > 
> > 
> > Please remove the #ifdef and use 
> > 
> >       if (!IS_ENABLED(CONFIG_ACPI) || !ahandle)
> > 
> > to check for ACPI support. This should result in the same object code
> > in all cases, but give better compile-time coverage when ACPI is
> > disabled.
> > 
> struct acpi_handle does not exist in the case !CONFIG_ACPI

That should be easy to fix, and a good idea in general, independent
of this patch.
We generally make function declarations and type definitions visible
(possibly empty) for disabled subsystems so the code using them
silently goes away when that subsystem is disabled.

	Arnd
