From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 17:21:42 +0000
Subject: [PATCH v7 16/16] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <1312988619-16804-17-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-17-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111102172142.GB12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:39PM +0100, Catalin Marinas wrote:
> +config ARCH_DMA_ADDR_T_64BIT
> +	def_bool ARM_LPAE
> +

I think this should be selected only when we have a DMA engine supporting
64-bit addresses.  Technically LPAE itself doesn't give us that assurance.

If you have this kind of a setup:

CPU <==++==> RAM
       ||
     IOMMU
       |
   DMA device

where == and || means >32-bit addressing, and | means 32-bit addressing.

In such a setup, having dma_addr_t be 64-bit is pointless because it
should never see 64-bit addresses (the DMA API should deal with the
IOMMU and provide a list of DMA addresses to be placed into RAM for
the DMA device which takes account of the mappings setup in the IOMMU.)

So, I think 64-bit dma_addr_t should be a property of the DMA devices
present in the system rather than whether the CPUs MMU can deal with
>32-bit addresses or not.
