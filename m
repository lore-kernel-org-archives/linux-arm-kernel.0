From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Mar 2012 22:03:00 -0600
Subject: [PATCH v4 4/4] ARM: iop13xx: use runtime ioremap hook
In-Reply-To: <1331006580-3579-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331006580-3579-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331006580-3579-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert iop13xx platforms to use run-time ioremap hook instead of the
compile time hook. The custom ioremap is still needed for 64-bit address
handling.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-iop13xx/include/mach/io.h |    7 -------
 arch/arm/mach-iop13xx/io.c              |   18 ++++++++++--------
 arch/arm/mach-iop13xx/iq81340mc.c       |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c       |    1 +
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index dffb234..2a69fc0 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -26,16 +26,9 @@
 #define __mem_isa(a) (a)
 
 extern void __iomem * __iop13xx_io(unsigned long io_addr);
-extern void __iomem *__iop13xx_ioremap(unsigned long cookie, size_t size,
-	unsigned int mtype);
-extern void __iop13xx_iounmap(void __iomem *addr);
-
 extern u32 iop13xx_atue_mem_base;
 extern u32 iop13xx_atux_mem_base;
 extern size_t iop13xx_atue_mem_size;
 extern size_t iop13xx_atux_mem_size;
 
-#define __arch_ioremap	__iop13xx_ioremap
-#define __arch_iounmap	__iop13xx_iounmap
-
 #endif
diff --git a/arch/arm/mach-iop13xx/io.c b/arch/arm/mach-iop13xx/io.c
index 48642e6..6dd5b49 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -40,8 +40,8 @@ void * __iomem __iop13xx_io(unsigned long io_addr)
 }
 EXPORT_SYMBOL(__iop13xx_io);
 
-void * __iomem __iop13xx_ioremap(unsigned long cookie, size_t size,
-	unsigned int mtype)
+static void __iomem *__iop13xx_ioremap_caller(unsigned long cookie,
+	size_t size, unsigned int mtype, void *caller)
 {
 	void __iomem * retval;
 
@@ -76,17 +76,14 @@ void * __iomem __iop13xx_ioremap(unsigned long cookie, size_t size,
 		break;
 	default:
 		retval = __arm_ioremap_caller(cookie, size, mtype,
-				__builtin_return_address(0));
+				caller);
 	}
 
 	return retval;
 }
-EXPORT_SYMBOL(__iop13xx_ioremap);
 
-void __iop13xx_iounmap(void __iomem *addr)
+static void __iop13xx_iounmap(volatile void __iomem *addr)
 {
-	extern void __iounmap(volatile void __iomem *addr);
-
 	if (iop13xx_atue_mem_base)
 		if (addr >= (void __iomem *) iop13xx_atue_mem_base &&
 	 	    addr < (void __iomem *) (iop13xx_atue_mem_base +
@@ -110,4 +107,9 @@ void __iop13xx_iounmap(void __iomem *addr)
 skip:
 	return;
 }
-EXPORT_SYMBOL(__iop13xx_iounmap);
+
+void __init iop13xx_init_early(void)
+{
+	arch_ioremap_caller = __iop13xx_ioremap_caller;
+	arch_iounmap = __iop13xx_iounmap;
+}
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index abaee88..5c96b73 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -92,6 +92,7 @@ static struct sys_timer iq81340mc_timer = {
 MACHINE_START(IQ81340MC, "Intel IQ81340MC")
 	/* Maintainer: Dan Williams <dan.j.williams@intel.com> */
 	.atag_offset    = 0x100,
+	.init_early     = iop13xx_init_early,
 	.map_io         = iop13xx_map_io,
 	.init_irq       = iop13xx_init_irq,
 	.timer          = &iq81340mc_timer,
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index 690916a..aa4dd75 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -94,6 +94,7 @@ static struct sys_timer iq81340sc_timer = {
 MACHINE_START(IQ81340SC, "Intel IQ81340SC")
 	/* Maintainer: Dan Williams <dan.j.williams@intel.com> */
 	.atag_offset    = 0x100,
+	.init_early     = iop13xx_init_early,
 	.map_io         = iop13xx_map_io,
 	.init_irq       = iop13xx_init_irq,
 	.timer          = &iq81340sc_timer,
-- 
1.7.5.4
