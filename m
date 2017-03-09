From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  9 Mar 2017 10:51:18 -0800
Subject: [PATCH 1/3] ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable
 peripherals
In-Reply-To: <20170309185120.1713-1-f.fainelli@gmail.com>
References: <20170309185120.1713-1-f.fainelli@gmail.com>
Message-ID: <20170309185120.1713-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Cooper <alcooperx@gmail.com>

Some Host Controller hardware blocks, like the OHCI, EHCI and SDIO
controllers, have hardware blocks that are not capable of doing 64 bit
DMA. These host controllers fail on boards with >3GB of memory because
the memory above 3GB is located physically >= 0x100000000 and can only
be accessed using 64 DMA. The way Linux is currently configured for
BRCMSTB systems, the memory given to drivers for DMA through functions
like dma_alloc_coherent() comes from CMA memory and CMA memory is taken
from the top of physical memory. When these drivers get a DMA buffer
with an address >=0x100000000, they end up dropping the upper 32 bit of
the address causing the hardware to DMA to incorrect memory, typically
BMEM (custom memory carveout). This issue was discovered on a
BCM97449SSV_DDR4 system with 4GB or memory.

The fix is to enable CONFIG_ZONE_DMA. On ARM systems this makes sure
that all DMA memory is located within the first 32 bits of address
space.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index a0e66d8200c5..403db76e3497 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -199,6 +199,7 @@ config ARCH_BRCMSTB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
+	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
 	select SOC_BUS
 	help
-- 
2.9.3
