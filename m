From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Oct 2015 16:10:06 +0200
Subject: [PATCH v2 6/6] vfio: platform: move get/put reset at open/release
In-Reply-To: <5628E41F.5050602@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
 <4304536.D7eNHjlsvD@wuerfel> <5628E41F.5050602@linaro.org>
Message-ID: <9413126.UTMuRq7fA0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 October 2015 15:26:55 Eric Auger wrote:
> >> @@ -181,6 +182,8 @@ static int vfio_platform_open(void *device_data)
> >>                 if (ret)
> >>                         goto err_irq;
> >>  
> >> +               vfio_platform_get_reset(vdev);
> >> +
> >>                 if (vdev->reset)
> >>                         vdev->reset(vdev);
> >>
> > 
> > This needs some error handling to ensure that the open() fails
> > if there is no reset handler.
> 
> Is that really what we want? The code was meant to allow the use case
> where the VFIO platform driver would be used without such reset module.
> 
> I think the imperious need for a reset module depends on the device and
> more importantly depends on the IOMMU mapping. With QEMU VFIO
> integration this is needed because the whole VM memory is IOMMU mapped
> but in a simpler user-space driver context, we might live without.
> 
> Any thought?

I would think we need a reset driver for any device that can start DMA,
otherwise things can go wrong as soon as you attach it to a different domain
while there is ongoing DMA.

Maybe we could just allow devices to be attached without a reset handler,
but then disallow DMA on them?

	Arnd
