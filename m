From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 22 Jul 2014 11:15:05 -0700
Subject: [PATCH v3] platform: Make platform_bus device a platform device
In-Reply-To: <1406052069.25343.93.camel@hornet>
References: <20140722173713.GA8959@kroah.com>
 <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
 <1406052069.25343.93.camel@hornet>
Message-ID: <20140722181505.GA9898@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 07:01:09PM +0100, Pawel Moll wrote:
> On Tue, 2014-07-22 at 18:55 +0100, Pawel Moll wrote:
> > * replaced references to platform_bus.dev with NULL
> >   in places where it shouldn't make any difference
> 
> So now the leftovers...
> 
> > diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
> > index 1b4366a..48c3817 100644
> > --- a/arch/arm/mach-imx/devices/devices.c
> > +++ b/arch/arm/mach-imx/devices/devices.c
> > @@ -24,12 +24,12 @@
> > 
> >  struct device mxc_aips_bus = {
> >         .init_name      = "mxc_aips",
> > -       .parent         = &platform_bus,
> > +       .parent         = &platform_bus.dev,
> >  };
> > 
> >  struct device mxc_ahb_bus = {
> >         .init_name      = "mxc_ahb",
> > -       .parent         = &platform_bus,
> > +       .parent         = &platform_bus.dev,
> >  };
> > 
> >  int __init mxc_device_init(void)
> 
> Seems that the author meant to have those two bus devices hanging from
> the platform_bus in device hierarchy. Seems fair enough to me.

No, not at all, this is a different bus, put the root bus at the root of
the sysfs tree, not at some "arbritrary" point on a platform device.

> > diff --git a/drivers/char/tile-srom.c b/drivers/char/tile-srom.c
> > index bd37747..4e4b7a2 100644
> > --- a/drivers/char/tile-srom.c
> > +++ b/drivers/char/tile-srom.c
> > @@ -350,7 +350,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
> >                        SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
> >                 return -EIO;
> > 
> > -       dev = device_create(srom_class, &platform_bus,
> > +       dev = device_create(srom_class, &platform_bus.dev,
> >                             MKDEV(srom_major, index), srom, "%d", index);
> >         return PTR_ERR_OR_ZERO(dev);
> >  }
> 
> Again, non-platform device placed in the hierarchy.

Again, not ok.  If it's a platform device, it's a platform device, and
make it one.  If it isn't, like this one, make it a virtual device and
pass NULL here.

> > diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> > index 7e834fb..9a2b0d0 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -137,7 +137,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
> >                 dev_err(&pdev->dev, "Invalid iomem size!\n");
> > 
> >         /* Some PCI-based MFD need the parent here */
> > -       if (pdev->dev.parent != &platform_bus && !np)
> > +       if (pdev->dev.parent != &platform_bus.dev && !np)
> >                 host = sdhci_alloc_host(pdev->dev.parent,
> >                         sizeof(struct sdhci_pltfm_host) + priv_size);
> >         else
> 
> Special treatment for non-platform devices.

Ugh, why should you care?  I don't understand the logic here.

> > diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> > index 3cbb57a..c14c36f 100644
> > --- a/drivers/scsi/hosts.c
> > +++ b/drivers/scsi/hosts.c
> > @@ -218,7 +218,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
> >                 goto fail;
> > 
> >         if (!shost->shost_gendev.parent)
> > -               shost->shost_gendev.parent = dev ? dev : &platform_bus;
> > +               shost->shost_gendev.parent = dev ? dev : &platform_bus.dev;
> >         if (!dma_dev)
> >                 dma_dev = shost->shost_gendev.parent;
> > 
> 
> shost_gendev is a generic (as in struct device, non-platform one)
> device, that is being explicitly placed in the hierarchy.

Then make it a virtual device, as that's what it is, replace this with
NULL.

> So it makes it 4, not 3 ;-) places where referencing platform_bus
> *maybe* makes some sense.

Nope, see above :)

thanks,

greg k-h
