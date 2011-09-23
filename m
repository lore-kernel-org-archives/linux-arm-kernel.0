From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:28 +0100
Subject: [RFC PATCH 10/14] ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1316796692-15964-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the cns3xxx platform to be using the gic_handle_irq
function as its primary interrupt handler.

Cc: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                 |    1 +
 arch/arm/mach-cns3xxx/cns3420vb.c                |    2 ++
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S |    2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e32a4d3..70a947e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -334,6 +334,7 @@ config ARCH_CNS3XXX
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 55f7b4b..594852f 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/partitions.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -201,5 +202,6 @@ MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
 	.map_io		= cns3420_map_io,
 	.init_irq	= cns3xxx_init_irq,
 	.timer		= &cns3xxx_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= cns3420_init,
 MACHINE_END
diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index d87bfc3..01c57df 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -8,8 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <asm/hardware/entry-macro-gic.S>
-
 		.macro	disable_fiq
 		.endm
 
-- 
1.7.0.4
