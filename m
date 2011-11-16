From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:27 -0500
Subject: [PATCH 09/23] ARM: mach-orion5x: remove arch specific special handling
 for ioremap
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-10-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-orion5x/include/mach/io.h |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
index c5196101a2..e9d9afdc26 100644
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ b/arch/arm/mach-orion5x/include/mach/io.h
@@ -15,31 +15,6 @@
 
 #define IO_SPACE_LIMIT		0xffffffff
 
-static inline void __iomem *
-__arch_ioremap(unsigned long paddr, size_t size, unsigned int mtype)
-{
-	void __iomem *retval;
-	unsigned long offs = paddr - ORION5X_REGS_PHYS_BASE;
-	if (mtype == MT_DEVICE && size && offs < ORION5X_REGS_SIZE &&
-	    size <= ORION5X_REGS_SIZE && offs + size <= ORION5X_REGS_SIZE) {
-		retval = (void __iomem *)ORION5X_REGS_VIRT_BASE + offs;
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
-	if (addr < (void __iomem *)ORION5X_REGS_VIRT_BASE ||
-	    addr >= (void __iomem *)(ORION5X_REGS_VIRT_BASE + ORION5X_REGS_SIZE))
-		__iounmap(addr);
-}
-
-#define __arch_ioremap		__arch_ioremap
-#define __arch_iounmap		__arch_iounmap
 #define __io(a)			__typesafe_io(a)
 #define __mem_pci(a)		(a)
 
-- 
1.7.7.1.431.g10b2a
