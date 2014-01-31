From: balbi@ti.com (Felipe Balbi)
Date: Fri, 31 Jan 2014 15:32:05 -0600
Subject: [RFC/PATCH] base: platform: add generic clock handling for
 platform-bus
In-Reply-To: <20140131200434.GR27282@n2100.arm.linux.org.uk>
References: <1391191965-31102-1-git-send-email-balbi@ti.com>
 <20140131200434.GR27282@n2100.arm.linux.org.uk>
Message-ID: <20140131213205.GB2502@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 31, 2014 at 08:04:35PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 31, 2014 at 12:12:45PM -0600, Felipe Balbi wrote:
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 3a94b79..86aeb5b 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -484,6 +484,21 @@ static int platform_drv_probe(struct device *_dev)
> >  	if (ACPI_HANDLE(_dev))
> >  		acpi_dev_pm_attach(_dev, true);
> >  
> > +	dev->fck = devm_clk_get(_dev, "fck");
> > +	dev->ick = devm_clk_get(_dev, "ick");
> > +
> > +	if (!IS_ERR(dev->fck))
> > +		clk_prepare_enable(dev->fck);
> > +	else
> > +		dev->fck = NULL;
> > +
> > +	if (!IS_ERR(dev->ick))
> > +		clk_prepare_enable(dev->ick);
> > +	else
> > +		dev->ick = NULL;
> 
> If people are going to continue doing this (converting error values to
> NULL) can we please have a check in devm_clk_get() which prevents it
> returning NULL if the implementation happens to do so?
> 
> It's either that or we force all users to conform to the API which
> specifies that the error values are defined by IS_ERR() returning
> true and everything else must be considered as a potential valid return.

The idea here was just to avoid IS_ERR() checks every time we want to
enable/disable a clock since clk API already copes with NULL pointers.

This also helps with the fact that platform_bus is also used with
platforms which don't have (or otherwise don't need) any clock control
whatsoever, thus made it optional.

If everybody prefers duplication of IS_ERR() all over the place, that's
fine too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/af65712a/attachment.sig>
