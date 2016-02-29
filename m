From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 29 Feb 2016 10:46:49 +0000
Subject: [PATCH 0/2] arm64, cma, gicv3-its: Use CMA for allocation of
 large device tables
In-Reply-To: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
References: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <56D42199.7040207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 25/02/16 11:02, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This series implements the use of CMA for allocation of large device
> tables for the arm64 gicv3 interrupt controller.
> 
> There are 2 patches, the first is for early activation of cma, which
> needs to be done before interrupt initialization to make it available
> to the gicv3. The second implements the use of CMA to allocate
> gicv3-its device tables.
> 
> This solves the problem where mem allocation is limited to 4MB. A
> previous patch sent to the list to address this that instead increases
> FORCE_MAX_ZONEORDER becomes obsolete.

I think you're looking at the problem the wrong way. Instead of going
through CMA directly, I'd rather go through the normal DMA API
(dma_alloc_coherent), which can itself try CMA (should it be enabled).

That will give you all the benefit of the CMA allocation, and also make
the driver more robust. I meant to do this for a while, and never found
the time. Any chance you could have a look?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
