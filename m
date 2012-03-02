From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:18 -0600
Subject: [PATCH v3 06/30] ARM: iop13xx: use runtime ioremap hook
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-7-git-send-email-robherring2@gmail.com>
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
 arch/arm/mach-iop13xx/io.c              |   10 ++++++++--
 arch/arm/mach-iop13xx/iq81340mc.c       |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c       |    1 +
 4 files changed, 10 insertions(+), 9 deletions(-)

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
index 48642e6..d63585e 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -40,7 +40,7 @@ void * __iomem __iop13xx_io(unsigned long io_addr)
 }
 EXPORT_SYMBOL(__iop13xx_io);
 
-void * __iomem __iop13xx_ioremap(unsigned long cookie, size_t size,
+void __iomem * __iop13xx_ioremap(unsigned long cookie, size_t size,
 	unsigned int mtype)
 {
 	void __iomem * retval;
@@ -83,7 +83,7 @@ void * __iomem __iop13xx_ioremap(unsigned long cookie, size_t size,
 }
 EXPORT_SYMBOL(__iop13xx_ioremap);
 
-void __iop13xx_iounmap(void __iomem *addr)
+void __iop13xx_iounmap(volatile void __iomem *addr)
 {
 	extern void __iounmap(volatile void __iomem *addr);
 
@@ -111,3 +111,9 @@ skip:
 	return;
 }
 EXPORT_SYMBOL(__iop13xx_iounmap);
+
+void __init iop13xx_init_early(void)
+{
+	arch_ioremap = __iop13xx_ioremap;
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
