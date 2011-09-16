From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:23 -0400
Subject: [PATCH 12/19] ARM: mach-kirkwood: remove arch specific special
	handling for ioremap
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-13-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-kirkwood/include/mach/io.h |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
index 1aaddc364f..49dd0cb5e1 100644
--- a/arch/arm/mach-kirkwood/include/mach/io.h
+++ b/arch/arm/mach-kirkwood/include/mach/io.h
@@ -19,31 +19,6 @@ static inline void __iomem *__io(unsigned long addr)
 					+ KIRKWOOD_PCIE_IO_VIRT_BASE);
 }
 
-static inline void __iomem *
-__arch_ioremap(unsigned long paddr, size_t size, unsigned int mtype)
-{
-	void __iomem *retval;
-	unsigned long offs = paddr - KIRKWOOD_REGS_PHYS_BASE;
-	if (mtype == MT_DEVICE && size && offs < KIRKWOOD_REGS_SIZE &&
-	    size <= KIRKWOOD_REGS_SIZE && offs + size <= KIRKWOOD_REGS_SIZE) {
-		retval = (void __iomem *)KIRKWOOD_REGS_VIRT_BASE + offs;
-	} else {
-		retval = __arm_ioremap(paddr, size, mtype);
-	}
-
-	return retval;
-}
-
-static inline void
-__arch_iounmap(void __iomem *addr)
-{
-	if (addr < (void __iomem *)KIRKWOOD_REGS_VIRT_BASE ||
-	    addr >= (void __iomem *)(KIRKWOOD_REGS_VIRT_BASE + KIRKWOOD_REGS_SIZE))
-		__iounmap(addr);
-}
-
-#define __arch_ioremap		__arch_ioremap
-#define __arch_iounmap		__arch_iounmap
 #define __io(a)			__io(a)
 #define __mem_pci(a)		(a)
 
-- 
1.7.7-rc0
