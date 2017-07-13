From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jul 2017 10:04:23 +0100
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <20170713070718.GA3871@mmlinux>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
 <5235ccf4-9dc2-a4aa-280b-18a0ab5a42bf@arm.com>
 <20170713070718.GA3871@mmlinux>
Message-ID: <20170713090423.GA31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 09:07:19AM +0200, michael.moese at men.de wrote:
> Ok, I hope I am correct. I alloc my memory using dma_alloc_coherent()
> once, the dma_handle is passed to the device, with no other dma_map*()
> or dma_sync_*() calls needed?

Correct.

> Yesterday I observed some strange behavior  when I did some debug prints in 
> the driver, printing me the result from phys_to_virt() of my
> virtual address and the dma_handle. I know these may be different, but,
> when I dump the memory (from userspace using mmap), I can see the data
> at the adress of my dma_handle, but the memory the driver has the
> pointer for has different contents. I don't understand this.

phys_to_virt() and virt_to_phys() are only defined for the linear map
region.

DMA coherent allocations may or may not return addresses in the linear
region, which means virt_to_phys() on a virtual address returned from
dma_alloc_coherent() is not defined.

DMA addresses are not physical addresses, they are device addresses -
this is an important distinction when IOMMUs or address translators are
in the path between the device and memory.  phys_to_virt() must not be
used with dma_addr_t data types.

You must always use the two addresses returned from dma_alloc_coherent()
and never try to translate them - the DMA address is for programming
into the hardware, and the virtual address for CPU accesses.  If you do
try to pass these to the various translators (like virt_to_phys()) the
result is undefined.

Moreover, passing the dma_addr_t returned from dma_alloc_coherent() to
the dma_sync_*() functions also results in undefined behaviour, and
potential data corruption.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
