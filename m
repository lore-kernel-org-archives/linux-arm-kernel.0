From: Liviu.Dudau@arm.com (Liviu.Dudau at arm.com)
Date: Wed, 4 Nov 2015 14:24:13 +0000
Subject: PCIe host controller behind IOMMU on ARM
In-Reply-To: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Message-ID: <20151104142412.GS963@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 01:57:48PM +0000, Phil Edworthy wrote:
> Hi,
> 
> I am trying to hook up a PCIe host controller that sits behind an IOMMU,
> but having some problems.
> 
> I'm using the pcie-rcar PCIe host controller and it works fine without
> the IOMMU, and I can attach the IOMMU to the controller such that any calls
> to dma_alloc_coherent made by the controller driver uses the iommu_ops
> version of dma_ops.
> 
> However, I can't see how to make the endpoints to utilise the dma_ops that
> the controller uses. Shouldn't the endpoints inherit the dma_ops from the
> controller? 

No, not directly.

> Any pointers for this?

You need to understand the process through which a driver for endpoint get
an address to be passed down to the device. Have a look at
Documentation/DMA-API-HOWTO.txt, there is a nice explanation there.
(Hint: EP driver needs to call dma_map_single).

Also, you need to make sure that the bus address that ends up being set into
the endpoint gets translated correctly by the host controller into an address
that the IOMMU can then translate into physical address.

Best regards,
Liviu


> 
> Thanks
> Phil
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
