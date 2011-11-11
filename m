From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Nov 2011 13:24:15 +0000
Subject: [PATCH v8 16/16] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <20111111114613.GF23243@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-17-git-send-email-catalin.marinas@arm.com>
 <20111110225737.GX12913@n2100.arm.linux.org.uk>
 <20111111114613.GF23243@arm.com>
Message-ID: <20111111132415.GD12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 11:46:14AM +0000, Catalin Marinas wrote:
> So we could change this to:
> 
> config ARCH_DMA_ADDR_T_64BIT
> 	depends on ARM_LPAE
> 
> and let platforms select it.

Actually, even this is conceptually wrong.  You really need to get away
from the thought that a dma address in any way is encapsulated within
the machine physical address.

They're two separate things.  For example, you could have an ARMv4 based
system (so, 32-bit address bus) connected to a PCI bridge which supports
64-bit addressing.  This PCI bridge could map system memory into PCI
space greater than 4GB (ok, there are down-sides to doing this, but this
is just an example to illustrate the point).  This would therefore require
a 64-bit dma_addr_t.

The size of dma_addr_t has very little to do with the page table format
or even the host address bus width, and is more to do with bus and
system setup than host CPU setup.

So, I think that we can have:

config ARCH_DMA_ADDR_T_64BIT
	bool

and we just leave it at that - if a platform needs 64-bit DMA addresses,
then selecting this symbol would be the correct approach.
