From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 May 2017 16:05:41 +0100
Subject: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <7413479.FJ3cKQnUFA@avalon>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <20170523224216.GI22219@n2100.armlinux.org.uk>
 <c4ad7341-fa9f-81b7-a41c-417144c4f842@codeaurora.org>
 <7413479.FJ3cKQnUFA@avalon>
Message-ID: <20170525150540.GJ22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 02:26:13PM +0300, Laurent Pinchart wrote:
> Again, the patch I propose is the simplest v4.12-rc fix I can think of, short 
> of reverting your complete IOMMU probe deferral patch series. Let's focus on 
> the v4.12-rc fix, and then discuss how to move forward in v4.13 and beyond.

Except, I don't think it fixes the problem that Sricharan is trying to
fix, namely that of DMA ops that have been setup, torn down, and are
trying to be re-setup again.  The issue here is that results in a stale
setup, because the dma_ops are left in-place from the first iommu setup,
but the iommu mapping has been disposed of.

Your patch only avoids the problem of tearing down someone else's DMA
ops.  We need a combination of both patches together.

What needs to happen for Sricharan's problem to be resolved is:

1. move all of __arm_iommu_detach_device() into arm_iommu_detach_device().
2. replace the __arm_iommu_detach_device() call in arm_teardown_iommu_dma_ops()
   with arm_iommu_detach_device().

as I don't see any need to have a different order in
arm_teardown_iommu_dma_ops().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
