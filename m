From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:16 +0100
Subject: [PATCH 06/16] ARM: iop13xx: Make PCIBIOS_MIN_* constants.
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020316.GY15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iop13xx does a dance with PCIBIOS_MIN_* by defining them to global
variables iop13xx_pcibios_min_{io,mem} so that they can be conditionally
assigned, but that isn't ever done -- iop13xx_pci_init() never sets
iop13xx_pcibios_min_io, leaving it at its default value of zero, and
unconditionally sets iop13xx_pcibios_min_mem to IOP13XX_PCIX_LOWER_MEM_BA.

So, just define these statically.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-iop13xx/include/mach/hardware.h |    6 ++----
 arch/arm/mach-iop13xx/pci.c                   |    5 -----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/hardware.h b/arch/arm/mach-iop13xx/include/mach/hardware.h
index ba81e50..8e8ec74 100644
--- a/arch/arm/mach-iop13xx/include/mach/hardware.h
+++ b/arch/arm/mach-iop13xx/include/mach/hardware.h
@@ -3,14 +3,12 @@
 #include <asm/types.h>
 
 #ifndef __ASSEMBLY__
-extern unsigned long iop13xx_pcibios_min_io;
-extern unsigned long iop13xx_pcibios_min_mem;
 extern u16 iop13xx_dev_id(void);
 extern void iop13xx_set_atu_mmr_bases(void);
 #endif
 
-#define PCIBIOS_MIN_IO      (iop13xx_pcibios_min_io)
-#define PCIBIOS_MIN_MEM     (iop13xx_pcibios_min_mem)
+#define PCIBIOS_MIN_IO      0x00000000
+#define PCIBIOS_MIN_MEM     IOP13XX_PCIX_LOWER_MEM_BA
 
 /*
  * Generic chipset bits
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 773ea0c..f21ef82 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -39,8 +39,6 @@ u32 iop13xx_atue_mem_base;
 u32 iop13xx_atux_mem_base;
 size_t iop13xx_atue_mem_size;
 size_t iop13xx_atux_mem_size;
-unsigned long iop13xx_pcibios_min_io = 0;
-unsigned long iop13xx_pcibios_min_mem = 0;
 
 EXPORT_SYMBOL(iop13xx_atue_mem_base);
 EXPORT_SYMBOL(iop13xx_atux_mem_base);
@@ -970,9 +968,6 @@ void __init iop13xx_pci_init(void)
 	/* clear pre-existing south bridge errors */
 	__raw_writel(__raw_readl(IOP13XX_XBG_BECSR) & 3, IOP13XX_XBG_BECSR);
 
-	/* Setup the Min Address for PCI memory... */
-	iop13xx_pcibios_min_mem = IOP13XX_PCIX_LOWER_MEM_BA;
-
 	/* if Linux is given control of an ATU
 	 * clear out its prior configuration,
 	 * otherwise do not touch the registers
-- 
1.7.1
