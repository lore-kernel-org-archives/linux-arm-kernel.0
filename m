From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 18 Dec 2014 22:36:14 +0200
Subject: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from
 dt-specific callback instead of initcall
In-Reply-To: <5219064.gvW43bShnl@wuerfel>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1418828005.3347.7.camel@pengutronix.de> <5219064.gvW43bShnl@wuerfel>
Message-ID: <1518515.QutUfiWrAf@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday 17 December 2014 16:56:53 Arnd Bergmann wrote:
> On Wednesday 17 December 2014 15:53:25 Lucas Stach wrote:
> > Am Mittwoch, den 17.12.2014, 15:27 +0100 schrieb Arnd Bergmann:
> >> On Wednesday 17 December 2014 01:24:42 Laurent Pinchart wrote:
> >>> If we forbid the IOMMU driver from being compiled as a module can't we
> >>> just rely on deferred probing ? The bus master driver will just be
> >>> reprobed after the IOMMU gets probed, like for other devices.
> >>> 
> >>> This could fail in case the IOMMU device permanently fails to probe.
> >>> There would be something very wrong in the system in that case,
> >>> Enabling the bus masters totally transparently without IOMMU support
> >>> could not be such a good idea.
> >> 
> >> I believe in the majority of cases today, the IOMMU is entirely
> >> optional. There are valid reasons for not including the IOMMU driver in
> >> the kernel, e.g. when you know that all the machines with that driver
> >> can DMA to all of their RAM and you want to avoid the overhead of IOTLB
> >> misses.
> > 
> > This is similar to the problems we discussed with the componentized
> > device framework and in the end everybody agreed on a simple rule:
> > if the device node is enabled in the DT there must be a driver bound to
> > it before other devices depending on this node can be probed.
> > 
> > If we apply the same logic to the IOMMU situation we get two
> > possibilities to allow bypassing the IOMMU:
> > 1. completely disable the IOMMU node in the DT
> > 2. leave node enabled in DT, but add a bypass property
> > 
> > Obviously the second option still requires to have the IOMMU driver
> > available, but is more flexible. Right now everything depends on the
> > IOMMU being in passthrough mode at reset with no driver bound. If a
> > device comes around where this isn't the case thing will break with the
> > current assumptions or the first option.
> > 
> > Having the IOMMU node enabled in DT with no driver available to the
> > kernel seems like an invalid configuration which should be expected to
> > break. Exactly the same thing as with componentized devices...
> 
> One differences here is that for the IOMMU, we should generally be able
> to fall back to swiotlb

Or to nothing at all if the device can DMA to the allocated memory directly.

> (currently only on ARM64, not ARM32, until someone adds support). I can see
> your point regarding machines that have a mandatory IOMMU with no fallback
> when there is no driver, but we can support them by making the iommu driver
> selected through Kconfig for that platform, while still allowing other
> platforms to work with drivers left out of the kernel.

The question is how to tell the kernel not to wait for an IOMMU that will 
never be there. Would a kernel command line argument be an acceptable solution 
or do we need something more automatic ?

-- 
Regards,

Laurent Pinchart
