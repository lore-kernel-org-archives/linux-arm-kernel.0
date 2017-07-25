From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Jul 2017 17:25:47 +0200
Subject: [PATCH v2] ARM: sa1100/pxa: fix MTD_XIP build
Message-ID: <20170725152616.4143857-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 3169663ac5902 "ARM: sa11x0/pxa: convert OS timer registers
to IOMEM", the definition of the OSCR macro was changed to be an
__iomem pointer, but the same register is also used by the XIP
code. This patch does the corresponding change here as well.

On PXA, the IRQ register definitions were removed even earlier, in
commit 5d284e353eb1 ("ARM: pxa: avoid accessing interrupt registers
directly"). This patch unfortunately brings some of that back. An
earlier version of my patch moved the code into an external function,
which could not work for CONFIG_XIP_KERNEL+CONFIG_MTD_XIP, so this
restores something close to the original code.

Link: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241716.html
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
---

v2: add back outer () as Robert suggested
---
 arch/arm/mach-pxa/include/mach/mtd-xip.h    | 10 +++++++---
 arch/arm/mach-sa1100/include/mach/mtd-xip.h |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mtd-xip.h b/arch/arm/mach-pxa/include/mach/mtd-xip.h
index 990d2bf2fb45..9bf4ea6a6f74 100644
--- a/arch/arm/mach-pxa/include/mach/mtd-xip.h
+++ b/arch/arm/mach-pxa/include/mach/mtd-xip.h
@@ -17,11 +17,15 @@
 
 #include <mach/regs-ost.h>
 
-#define xip_irqpending()	(ICIP & ICMR)
+/* restored July 2017, this did not build since 2011! */
+
+#define ICIP			io_p2v(0x40d00000)
+#define ICMR			io_p2v(0x40d00004)
+#define xip_irqpending()	(readl(ICIP) & readl(ICMR))
 
 /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
+#define xip_currtime()		readl(OSCR)
+#define xip_elapsed_since(x)	(signed)((readl(OSCR) - (x)) / 4)
 
 /*
  * xip_cpu_idle() is used when waiting for a delay equal or larger than
diff --git a/arch/arm/mach-sa1100/include/mach/mtd-xip.h b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
index b3d684098fbf..cb76096a2e36 100644
--- a/arch/arm/mach-sa1100/include/mach/mtd-xip.h
+++ b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
@@ -20,7 +20,7 @@
 #define xip_irqpending()	(ICIP & ICMR)
 
 /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
+#define xip_currtime()		readl_relaxed(OSCR)
+#define xip_elapsed_since(x)	(signed)((readl_relaxed(OSCR) - (x)) / 4)
 
 #endif /* __ARCH_SA1100_MTD_XIP_H__ */
-- 
2.9.0
