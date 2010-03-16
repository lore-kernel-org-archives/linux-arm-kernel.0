From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Mar 2010 08:35:37 +0200
Subject: [PATCH 1/3] imx: make IMX_IO_ADDRESS assembly compatible
In-Reply-To: <20100311105637.GE16376@n2100.arm.linux.org.uk>
References: <20100311105637.GE16376@n2100.arm.linux.org.uk>
Message-ID: <f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX_IO_ADDRESS macro may be used directly on indirectly in assembly code.
Make it assembly compatible by using the IOMEM helper macro.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/hardware.h |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index ebadf4a..f75a5cc 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -22,10 +22,18 @@
 
 #include <asm/sizes.h>
 
-#define IMX_IO_ADDRESS(addr, module)					\
-	((void __force __iomem *)					\
-	 (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
-	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
+#ifdef __ASSEMBLER__
+#define IOMEM(addr,base,size,virt)	((addr) - (base) + (virt))
+#else
+#define IOMEM(addr,base,size,virt)			\
+	((void __force __iomem *)			\
+	((unsigned long) ((addr) - (base)) < size) ?	\
+	(addr) - (base) + (virt) : 0)
+#endif
+
+#define IMX_IO_ADDRESS(addr, module)				\
+	IOMEM(addr, module ## _BASE_ADDR, module ## _SIZE,	\
+	module ## _BASE_ADDR_VIRT)
 
 #ifdef CONFIG_ARCH_MX5
 #include <mach/mx51.h>
-- 
1.7.0
