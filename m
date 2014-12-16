From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 16 Dec 2014 14:07:11 +0200
Subject: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
 instead of initcall
In-Reply-To: <1681211.YVY9bd22gV@wuerfel>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <20141215181323.GX20738@arm.com> <1681211.YVY9bd22gV@wuerfel>
Message-ID: <24892200.rsOlz53AM6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday 16 December 2014 12:40:28 Arnd Bergmann wrote:
> On Monday 15 December 2014 18:13:23 Will Deacon wrote:
> >>>> IOMMUs are not as low-level as system interrupt controllers or
> >>>> system clocks. I'm beginning to agree with Thierry that they should
> >>>> be treated as normal platform devices as they're not required
> >>>> earlier than probe time of their bus master devices.
> >>> 
> >>> Well, I think you'd have to propose patches for discussion since I'm
> >>> certainly not wed to the current approach; I just want something that
> >>> allows of_{dma,iommu}_configure to run with the information it needs.
> >> 
> >> Do we need of_dma_configure() to run when the device is created, or
> >> could we postpone it to just before probe time ?
> > 
> > I'm not sure I can answer that one... Arnd?
> 
> I believe we could postpone it to probe time, but I'd rather not.
> The way I see the arguments in favor, we have mainly cosmetic arguments:
> 
> - Doing it at probe time would eliminate the ugly section magic hack
> - iommu drivers could be implemented as loadable modules with platform
>   drivers, for consistency with most other drivers

The main argument, from my point of view, is that handling IOMMUs are normal 
platform devices allow using all the kernel infrastructure that depends on a 
struct device. The dev_* print helpers are nice to have, but what would make a 
big difference is the ability to use runtime PM.

> On the other hand, I see:
> 
> - DMA configuration is traditionally done at device creation time, and
>   changing that is more likely to introduce bugs than leaving it
>   where it is.
> - On a lot of machines, the IOMMU is optional, and the probe function
>   cannot know the difference between an IOMMU driver that is left out
>   of the kernel and one that will be initialized later, using a fixed
>   entry point for initializing the IOMMU makes the behavior consistent

I'm not advocating for IOMMU support being built as a loadable module. It 
might be nice from a development point of view, but that's about it.

> There is a third option in theory, which is to only enable the IOMMU
> as part of dma_set_mask(). I've done that in the past on powerpc, but
> the new approach seems cleaner.

-- 
Regards,

Laurent Pinchart
