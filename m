From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Mar 2010 10:41:45 +0200
Subject: [PATCH, RESEND] imx: make IMX_IO_ADDRESS assembly compatible
In-Reply-To: <f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
References: <f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
Message-ID: <84a2844cbb84d061f848657c1d2cafca86a22de5.1268728618.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX_IO_ADDRESS macro may be used directly on indirectly in assembly code.
Make it assembly compatible by using the IOMEM helper macro.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

Fixed the unsigned long cast. Please ignore the previous patch.

 arch/arm/plat-mxc/include/mach/hardware.h |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index ebadf4a..6bb0928 100644
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
+	(((unsigned long) ((addr) - (base)) < size) ?	\
+	(addr) - (base) + (virt) : 0))
+#endif
+
+#define IMX_IO_ADDRESS(addr, module)				\
+	IOMEM(addr, module ## _BASE_ADDR, module ## _SIZE,	\
+	module ## _BASE_ADDR_VIRT)
 
 #ifdef CONFIG_ARCH_MX5
 #include <mach/mx51.h>
-- 
1.7.0
