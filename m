From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Dec 2014 18:39:45 +0000
Subject: using DMA-API on ARM
In-Reply-To: <5481794E.4050406@broadcom.com>
References: <5481794E.4050406@broadcom.com>
Message-ID: <20141205183945.GE31222@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 09:22:22AM +0000, Arend van Spriel wrote:
> For our brcm80211 development we are working on getting brcmfmac driver
> up and running on a Broadcom ARM-based platform. The wireless device is
> a PCIe device, which is hooked up to the system behind a PCIe host
> bridge, and we transfer information between host and device using a
> descriptor ring buffer allocated using dma_alloc_coherent(). We mostly
> tested on x86 and seen no issue. However, on this ARM platform
> (single-core A9) we detect occasionally that the descriptor content is
> invalid. When this occurs we do a dma_sync_single_for_cpu() and this is
> retried a number of times if the problem persists. Actually, found out
> that someone made a mistake by using virt_to_dma(va) to get the
> dma_handle parameter. So probably we only provided a delay in the retry
> loop. After fixing that a single call to dma_sync_single_for_cpu() is
> sufficient. The DMA-API-HOWTO clearly states that:

Does your system have an L2 cache? What's the SoC topology, can PCIe see
such L2 cache (or snoop the L1 caches)?

Also, are you certain that dma_alloc_coherent() ends up creating a
non-cacheable mapping in Linux (this call translates to a function
pointer call which may or may not create non-cacheable memory, depending
on the "dma-coherent" property passed via DT).

-- 
Catalin
