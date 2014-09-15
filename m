From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Sep 2014 10:24:56 +0100
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <20140915040844.12D19C40A02@trevor.secretlab.ca>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <2861461.8zNpLC3I2n@wuerfel>
 <20140901152854.GJ2953@xora-haswell.xora.org.uk>
 <20140915040844.12D19C40A02@trevor.secretlab.ca>
Message-ID: <20140915092456.GB1577@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 05:08:44AM +0100, Grant Likely wrote:
> On Mon, 1 Sep 2014 16:28:54 +0100, Graeme Gregory <graeme.gregory@linaro.org> wrote:
> > On Mon, Sep 01, 2014 at 05:17:51PM +0200, Arnd Bergmann wrote:
> > > On Monday 01 September 2014 23:06:00 Hanjun Guo wrote:
> > > > +#ifdef CONFIG_ACPI
> > > > +/* Configure some sensible defaults for ACPI mode */
> > > > +static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
> > > > +                                   acpi_handle *ahandle)
> > > > +{
> > > > +       if (!ahandle)
> > > > +               return -ENOSYS;
> > > > +
> > > > +       config->phy_interface = PHY_INTERFACE_MODE_MII;
> > > > 
> > > 
> > > Please remove the #ifdef and use 
> > > 
> > > 	if (!IS_ENABLED(CONFIG_ACPI) || !ahandle)
> > > 
> > > to check for ACPI support. This should result in the same object code
> > > in all cases, but give better compile-time coverage when ACPI is
> > > disabled.
> > > 
> > struct acpi_handle does not exist in the case !CONFIG_ACPI
> > 
> > > Also, -ENOSYS is probably the wrong return value. I think you mean
> > > -ENXIO.
> > > 
> > Yes that would make sense thanks.
> > 
> > Not sure if we are planning to actually upstream this patch, I guess it
> > depends if ARM start shipping Junos with the ACPI tables loaded on them.
> 
> I think we do want this upstreamed. Juno is intended to be a readily
> available reference platform, regardless of the firmware loaded when
> shipped. There will be users who use it as a test platform for ACPI
> development.

The patches for Juno are not intrusive. The only problem I have is
giving the wrong example on how to deal with the platform-specific
device information like this patch. I would much prefer to use _DSD
(once we agree on how to do this) than hard-coding information based on
the ACPI device id (you would need one for each SoC). I don't think we
have reached an agreement yet:

https://lkml.kernel.org/g/4816592.tj3on6vUaC at wuerfel

-- 
Catalin
