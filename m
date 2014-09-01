From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 1 Sep 2014 16:28:54 +0100
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <2861461.8zNpLC3I2n@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <2861461.8zNpLC3I2n@wuerfel>
Message-ID: <20140901152854.GJ2953@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 05:17:51PM +0200, Arnd Bergmann wrote:
> On Monday 01 September 2014 23:06:00 Hanjun Guo wrote:
> > +#ifdef CONFIG_ACPI
> > +/* Configure some sensible defaults for ACPI mode */
> > +static int smsc911x_probe_config_acpi(struct smsc911x_platform_config *config,
> > +                                   acpi_handle *ahandle)
> > +{
> > +       if (!ahandle)
> > +               return -ENOSYS;
> > +
> > +       config->phy_interface = PHY_INTERFACE_MODE_MII;
> > 
> 
> Please remove the #ifdef and use 
> 
> 	if (!IS_ENABLED(CONFIG_ACPI) || !ahandle)
> 
> to check for ACPI support. This should result in the same object code
> in all cases, but give better compile-time coverage when ACPI is
> disabled.
> 
struct acpi_handle does not exist in the case !CONFIG_ACPI

> Also, -ENOSYS is probably the wrong return value. I think you mean
> -ENXIO.
> 
Yes that would make sense thanks.

Not sure if we are planning to actually upstream this patch, I guess it
depends if ARM start shipping Junos with the ACPI tables loaded on them.

Graeme
