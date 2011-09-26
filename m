From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:24 +0100
Subject: [PATCH v2 05/16] ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the VExpress platform to be using the gic_handle_irq
function as its primary interrupt handler.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                  |    1 +
 arch/arm/mach-vexpress/include/mach/entry-macro.S |    2 --
 arch/arm/mach-vexpress/v2m.c                      |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6c31cc2..d3e246c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -295,6 +295,7 @@ config ARCH_VEXPRESS
 	select ICST
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
diff --git a/arch/arm/mach-vexpress/include/mach/entry-macro.S b/arch/arm/mach-vexpress/include/mach/entry-macro.S
index 73c1129..a14f9e6 100644
--- a/arch/arm/mach-vexpress/include/mach/entry-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/entry-macro.S
@@ -1,5 +1,3 @@
-#include <asm/hardware/entry-macro-gic.S>
-
 	.macro	disable_fiq
 	.endm
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 47bca2a..d540a1b 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -24,6 +24,7 @@
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
 #include <asm/hardware/sp810.h>
+#include <asm/hardware/gic.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
@@ -457,5 +458,6 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
 	.timer		= &v2m_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= v2m_init,
 MACHINE_END
-- 
1.7.0.4
