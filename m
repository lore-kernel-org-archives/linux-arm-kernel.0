From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 31 Aug 2011 20:16:18 +0300
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
In-Reply-To: <201108311856.26969.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
	<20110831130642.GQ12940@amd.com>
	<201108311856.26969.laurent.pinchart@ideasonboard.com>
Message-ID: <CAK=WgbZeOaMduf6xDb2j6OzbDBC4c8Qd2q0zfYf-VeG6Tbcwhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent, Joerg,

On Wed, Aug 31, 2011 at 7:56 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 31 August 2011 15:06:42 Roedel, Joerg wrote:
>> Do you mean the parts of the pages you map to the device that are not in
>> the requested range (basically everything before offset and all after
>> size)?
>> This issue exists in other iommu drivers as well. It is inherent to how
>> the dma-api is defined and how the iommu hardware works.
>> The dma-api can work on byte granularity while the hardware usually only
>> works on page granularity.
>
> True, but if we implement address rounding transparently in the IOMMU layer
> Ohad's concern can be valid, depending on whether the device is trusted. If we
> decide to push address rounding to the drivers that decision can be made on a
> per-device basis. However, drivers are usually not aware of what granularity
> the IOMMU works on, so that wouldn't be straightforward and clean.

I think the confusion lies in the fact that omap's iovmm should be
treated as the DMA-API (which will soon replace it altogether anyway)
and not as an IOMMU driver, and in that sense, Laurent's patch does
sound reasonable.

However, one needs to keep this in mind (e.g. map only page-aligned
buffers ?) when using the upcoming iommu-based DMA-API with untrusted
devices (such as remote processors running arbitrary code). It is
completely wrong to allow these devices access to random physical
memory regions. We might want to come up with a way to prevent this
from happening...

Thanks,
Ohad.
