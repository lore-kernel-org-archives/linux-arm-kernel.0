From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 May 2015 14:31:09 +0100
Subject: [RFC/PATCH 8/9] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <1431644410-2997-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1431644410-2997-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20150528133109.GJ31001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, May 15, 2015 at 12:00:09AM +0100, Laurent Pinchart wrote:
> Failures to look up an IOMMU when parsing the DT iommus property need to
> be handled separately from the .of_xlate() failures to support deferred
> probing.
> 
> The lack of a registered IOMMU can be caused by the lack of a driver for
> the IOMMU, the IOMMU device probe not having been performed yet, having
> been deferred, or having failed.
> 
> The first case occurs when the device tree describes the bus master and
> IOMMU topology correctly but no device driver exists for the IOMMU yet
> or the device driver has not been compiled in. Return NULL, the caller
> will configure the device without an IOMMU.
> 
> The second and third cases are handled by deferring the probe of the bus
> master device which will eventually get reprobed after the IOMMU.
> 
> The last case is currently handled by deferring the probe of the bus
> master device as well. A mechanism to either configure the bus master
> device without an IOMMU or to fail the bus master device probe depending
> on whether the IOMMU is optional or mandatory would be a good
> enhancement.

I appreciate that you're just looking to handle early initialisation
failures here, but do you have any thoughts on how to deal with failures
later on when e.g. the DMA-mapping API is trying to create IOMMU domains.

One potential problem I foresee is if we try to add all devices to a common
DMA domain, we may get -ENOSPC-style failures due to limited resources on
the IOMMU. In this case, we'd probably want to fall-back to non-IOMMU DMA
ops, but that in-turn could have consequences on things like dma-coherent.

It's all a bit murky, so I'd be glad to hear any thoughts you might have
around this.

Anyway, this patch looks fine:

  Acked-by: Will Deacon <will.deacon@arm.com>

but we should consider how all of this will get used too.

Will
