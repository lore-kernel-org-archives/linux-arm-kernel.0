From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 20 Jan 2015 16:05:42 +0200
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops into
 arch_setup_dma_ops
In-Reply-To: <20150119124934.GD7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2804479.ZFl06ysk3j@avalon> <20150119124934.GD7312@ulmo.nvidia.com>
Message-ID: <1668598.fJABSYM31J@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Monday 19 January 2015 13:49:36 Thierry Reding wrote:
> On Fri, Jan 16, 2015 at 01:18:21AM +0200, Laurent Pinchart wrote:
> [...]
> 
> > The second way is to implement a mechanism to let drivers signal that they
> > want to handle DMA mappings themselves. As the mappings need in the
> > general case to be created before the probe function is called we can't
> > signal this by calling a function in probe(). A new flag field for struct
> > device_driver is a possible solution. This would however require delaying
> > the creation of DMA mappings until right before probe time. Attaching to
> > the IOMMU could be pushed to right before probe() as well, which would
> > have the added benefit of making IOMMU driver implementable as real
> > platform drivers.
> 
> Right. This is a pretty important point, too. One of the things that
> we've been working on is suspend/resume. Now if you don't have a struct
> device you can't easily implement suspend/resume. You'd have to play
> tricks like using syscore_ops, which then leads to potentially problems
> with suspend/resume ordering. It also means we have to keep around
> global variables for driver-private data because there's no struct
> device to attach it to.
> 
> By properly encoding the dependencies via deferred probe we get the
> proper ordering and we can use the regular driver model with all the
> goodies that we've come up with over the years.

Marek's patch set to port the Exynos IOMMU driver on Will's patches uses 
of_platform_device_create() in the init handler registered with 
IOMMU_OF_DECLARE() to create a platform device for the IOMMU. I've initially 
considered this as a dubious hack, but on the other hand it avoids modifying 
the whole IOMMU driver to get rid of struct device, making it easier to move 
to a deferred probe approach later if needed (and possible and desired).

-- 
Regards,

Laurent Pinchart
