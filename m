From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 22 Jul 2014 19:01:09 +0100
Subject: [PATCH v3] platform: Make platform_bus device a platform device
In-Reply-To: <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
References: <20140722173713.GA8959@kroah.com>
 <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1406052069.25343.93.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 18:55 +0100, Pawel Moll wrote:
> * replaced references to platform_bus.dev with NULL
>   in places where it shouldn't make any difference

So now the leftovers...

> diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
> index 1b4366a..48c3817 100644
> --- a/arch/arm/mach-imx/devices/devices.c
> +++ b/arch/arm/mach-imx/devices/devices.c
> @@ -24,12 +24,12 @@
> 
>  struct device mxc_aips_bus = {
>         .init_name      = "mxc_aips",
> -       .parent         = &platform_bus,
> +       .parent         = &platform_bus.dev,
>  };
> 
>  struct device mxc_ahb_bus = {
>         .init_name      = "mxc_ahb",
> -       .parent         = &platform_bus,
> +       .parent         = &platform_bus.dev,
>  };
> 
>  int __init mxc_device_init(void)

Seems that the author meant to have those two bus devices hanging from
the platform_bus in device hierarchy. Seems fair enough to me.

> diff --git a/drivers/char/tile-srom.c b/drivers/char/tile-srom.c
> index bd37747..4e4b7a2 100644
> --- a/drivers/char/tile-srom.c
> +++ b/drivers/char/tile-srom.c
> @@ -350,7 +350,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
>                        SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
>                 return -EIO;
> 
> -       dev = device_create(srom_class, &platform_bus,
> +       dev = device_create(srom_class, &platform_bus.dev,
>                             MKDEV(srom_major, index), srom, "%d", index);
>         return PTR_ERR_OR_ZERO(dev);
>  }

Again, non-platform device placed in the hierarchy.

> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 7e834fb..9a2b0d0 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -137,7 +137,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                 dev_err(&pdev->dev, "Invalid iomem size!\n");
> 
>         /* Some PCI-based MFD need the parent here */
> -       if (pdev->dev.parent != &platform_bus && !np)
> +       if (pdev->dev.parent != &platform_bus.dev && !np)
>                 host = sdhci_alloc_host(pdev->dev.parent,
>                         sizeof(struct sdhci_pltfm_host) + priv_size);
>         else

Special treatment for non-platform devices.

> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 3cbb57a..c14c36f 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -218,7 +218,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>                 goto fail;
> 
>         if (!shost->shost_gendev.parent)
> -               shost->shost_gendev.parent = dev ? dev : &platform_bus;
> +               shost->shost_gendev.parent = dev ? dev : &platform_bus.dev;
>         if (!dma_dev)
>                 dma_dev = shost->shost_gendev.parent;
> 

shost_gendev is a generic (as in struct device, non-platform one)
device, that is being explicitly placed in the hierarchy.

So it makes it 4, not 3 ;-) places where referencing platform_bus
*maybe* makes some sense.

Pawel
