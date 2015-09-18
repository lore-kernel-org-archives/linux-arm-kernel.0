From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2015 13:29:37 +0100
Subject: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
In-Reply-To: <55FBEFBA.6000606@arm.com>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
 <1442566550.8145.156.camel@mhfsdcap03> <55FBEFBA.6000606@arm.com>
Message-ID: <20150918122937.GE21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 12:04:26PM +0100, Robin Murphy wrote:
> Specifically, the problem case for that is when phys_addr_t is 64-bit but
> dma_addr_t is 32-bit. The cast in __arm_lpae_dma_addr is necessary to avoid
> a truncation warning when we make the DMA API calls, but we actually need
> the opposite in the comparison here - comparing the different types directly
> allows integer promotion to kick in appropriately so we don't lose the top
> half of the larger address. Otherwise, you'd never spot the difference
> between, say, your original page at 0x88c0000000 and a bounce-buffered copy
> that happened to end up mapped to 0xc0000000.

Hmm.  Thinking about this, I think we ought to add to arch/arm/mm/Kconfig:

 config ARCH_PHYS_ADDR_T_64BIT
 	def_bool ARM_LPAE
 
 config ARCH_DMA_ADDR_T_64BIT
 	bool
+	select ARCH_PHYS_ADDR_T_64BIT

I seem to remember that you're quite right that dma_addr_t <= phys_addr_t
but dma_addr_t must never be bigger than phys_addr_t.

-- 
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
