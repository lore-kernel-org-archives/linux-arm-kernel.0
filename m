From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 4 Jun 2014 12:01:23 -0700
Subject: [PATCH 1/1] device.h: arm,dma-iommu: Move out dma_iommu_mapping
 struct
In-Reply-To: <CAD15agbiuXiiAp62R-NeLeX3rgNftmyb+wGiSVx-FgtcXzxpHA@mail.gmail.com>
References: <1401869506-48129-1-git-send-email-ritesh.harjani@gmail.com>
 <1401869506-48129-2-git-send-email-ritesh.harjani@gmail.com>
 <20140604175145.GD20812@kroah.com>
 <CAD15agbiuXiiAp62R-NeLeX3rgNftmyb+wGiSVx-FgtcXzxpHA@mail.gmail.com>
Message-ID: <20140604190123.GC30884@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 12:16:28AM +0530, Ritesh Harjani wrote:
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -705,6 +705,10 @@ struct device {
> >>       /* arch specific additions */
> >>       struct dev_archdata     archdata;
> >>
> >> +#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
> >> +     struct dma_iommu_mapping        *mapping;
> >> +#endif
> >> +
> >>       struct device_node      *of_node; /* associated device tree node */
> >>       struct acpi_dev_node    acpi_node; /* associated ACPI device node */
> >>
> >
> > Are you sure this will not break the build on systems that enable that
> > option, yet do not include iommu-helper.h?
> 
> They need to include iommu-helper.h wherever they are using this
> structure members. Until then no this should
> not break the build I think for the case you mentioned.

Try it and find out :)

> That's how it was done in arch/arm/include/asm/device.h

Perhaps something else was pulling in that .h file?  device.h is used
_everywhere_ you can not assume someone will have included another .h
file before it.

> Do I need to do this in diff way ?

Yes, just predefine the structure in the .h file.

And do you really need the #ifdef?

thanks,

greg k-h
