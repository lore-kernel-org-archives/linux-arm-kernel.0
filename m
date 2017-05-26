From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 26 May 2017 17:04:49 +0300
Subject: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <20170525150540.GJ22219@n2100.armlinux.org.uk>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <7413479.FJ3cKQnUFA@avalon> <20170525150540.GJ22219@n2100.armlinux.org.uk>
Message-ID: <1593204.iWar1lSZel@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thursday 25 May 2017 16:05:41 Russell King - ARM Linux wrote:
> On Wed, May 24, 2017 at 02:26:13PM +0300, Laurent Pinchart wrote:
> > Again, the patch I propose is the simplest v4.12-rc fix I can think of,
> > short of reverting your complete IOMMU probe deferral patch series. Let's
> > focus on the v4.12-rc fix, and then discuss how to move forward in v4.13
> > and beyond.
>
> Except, I don't think it fixes the problem that Sricharan is trying to
> fix, namely that of DMA ops that have been setup, torn down, and are
> trying to be re-setup again.

You're right, it's two separate problems, and we need to fix them both.

> The issue here is that results in a stale setup, because the dma_ops are
> left in-place from the first iommu setup, but the iommu mapping has been
> disposed of.
> 
> Your patch only avoids the problem of tearing down someone else's DMA
> ops.  We need a combination of both patches together.

Yes exactly. I should read e-mails to the end before starting typing the reply 
:-)

> What needs to happen for Sricharan's problem to be resolved is:
> 
> 1. move all of __arm_iommu_detach_device() into arm_iommu_detach_device().
> 2. replace the __arm_iommu_detach_device() call in
> arm_teardown_iommu_dma_ops() with arm_iommu_detach_device().
> 
> as I don't see any need to have a different order in
> arm_teardown_iommu_dma_ops().

-- 
Regards,

Laurent Pinchart
