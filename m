From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 Mar 2012 15:45:16 -0600
Subject: [PATCH v5 6/7] ARM: ebsa110: use runtime ioremap hook
In-Reply-To: <1331070317-9598-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331070317-9598-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert ebsa110 platforms to use run-time ioremap hook instead of the
compile time hook.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-ebsa110/core.c            |   15 +++++++++++++++
 arch/arm/mach-ebsa110/include/mach/io.h |    9 ---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 804c912..e0b831e 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -119,6 +119,20 @@ static void __init ebsa110_map_io(void)
 	iotable_init(ebsa110_io_desc, ARRAY_SIZE(ebsa110_io_desc));
 }
 
+static void __iomem *ebsa110_ioremap(unsigned long cookie, size_t size,
+				     unsigned int flags)
+{
+	return (void __iomem *)cookie;
+}
+
+static void ebsa110_iounmap(volatile void __iomem *io_addr)
+{}
+
+static void __init ebsa110_init_early(void)
+{
+	arch_ioremap_caller = ebsa110_ioremap;
+	arch_iounmap = ebsa110_iounmap;
+}
 
 #define PIT_CTRL		(PIT_BASE + 0x0d)
 #define PIT_T2			(PIT_BASE + 0x09)
@@ -315,6 +329,7 @@ MACHINE_START(EBSA110, "EBSA110")
 	.reserve_lp2	= 1,
 	.restart_mode	= 's',
 	.map_io		= ebsa110_map_io,
+	.init_early	= ebsa110_init_early,
 	.init_irq	= ebsa110_init_irq,
 	.timer		= &ebsa110_timer,
 	.restart	= ebsa110_restart,
diff --git a/arch/arm/mach-ebsa110/include/mach/io.h b/arch/arm/mach-ebsa110/include/mach/io.h
index 44679db..11bb079 100644
--- a/arch/arm/mach-ebsa110/include/mach/io.h
+++ b/arch/arm/mach-ebsa110/include/mach/io.h
@@ -62,15 +62,6 @@ void __writel(u32 val, void __iomem *addr);
 #define writew(v,b)		__writew(v,b)
 #define writel(v,b)		__writel(v,b)
 
-static inline void __iomem *__arch_ioremap(unsigned long cookie, size_t size,
-					   unsigned int flags)
-{
-	return (void __iomem *)cookie;
-}
-
-#define __arch_ioremap		__arch_ioremap
-#define __arch_iounmap(cookie)	do { } while (0)
-
 extern void insb(unsigned int port, void *buf, int sz);
 extern void insw(unsigned int port, void *buf, int sz);
 extern void insl(unsigned int port, void *buf, int sz);
-- 
1.7.5.4
