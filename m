From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Dec 2014 09:45:08 +0000
Subject: using DMA-API on ARM
In-Reply-To: <5481794E.4050406@broadcom.com>
References: <5481794E.4050406@broadcom.com>
Message-ID: <20141205094507.GP11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 10:22:22AM +0100, Arend van Spriel wrote:
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
> 
> """
> the hardware should guarantee that the device and the CPU can access the
> data in parallel and will see updates made by each other without any
> explicit software flushing.
> """
> 
> So it seems incorrect that we would need to do a dma_sync for this
> memory. That we do need it seems like this memory can end up in
> cache(?), or whatever happens, in some rare condition. Is there anyway
> to investigate this situation either through DMA-API or some low-level
> ARM specific functions.

It's been a long while since I looked at the code, and the code for
dma_alloc_coherent() has completely changed since then with the
addition of CMA.  I'm afraid that anything I would say about it would
not be accurate without research into the possible paths through that
code - it's no longer just a simple allocator.

What you say is correct however: the memory should not have any cache
lines associated with it, if it does, there's a bug somewhere.

Also, the memory will be weakly ordered, which means that writes to such
memory can be reordered.  If ordering matters, barriers should be used.
rmb() and wmb() can be used for this.

(Added Marek for comment on dma_alloc_coherent(), Will for comment on
barrier stuff.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
