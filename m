From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 10 Nov 2012 14:58:47 +0400
Subject: [PATCH v2 08/17] ARM: clps711x: Implement usage "SPARSE_IRQ" kernel
 option for a platform
In-Reply-To: <1352545136-29089-1-git-send-email-shc_work@mail.ru>
References: <1352545136-29089-1-git-send-email-shc_work@mail.ru>
Message-ID: <1352545136-29089-9-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                               |    1 +
 arch/arm/mach-clps711x/autcpu12.c              |    1 +
 arch/arm/mach-clps711x/cdb89712.c              |    1 +
 arch/arm/mach-clps711x/clep7312.c              |    1 +
 arch/arm/mach-clps711x/common.h                |    1 +
 arch/arm/mach-clps711x/edb7211.c               |    1 +
 arch/arm/mach-clps711x/fortunet.c              |    1 +
 arch/arm/mach-clps711x/include/mach/clps711x.h |   21 +++++++++++
 arch/arm/mach-clps711x/include/mach/irqs.h     |   46 ------------------------
 arch/arm/mach-clps711x/p720t.c                 |    1 +
 10 files changed, 29 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/irqs.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef4e357..90fb335 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -378,6 +378,7 @@ config ARCH_CLPS711X
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
 	select NEED_MACH_MEMORY_H
+	select SPARSE_IRQ
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index 46bbb1d..cd33e78 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -71,6 +71,7 @@ static void __init autcpu12_init(void)
 MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
 	.atag_offset	= 0x20000,
+	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
index 8d58236..b11d1db 100644
--- a/arch/arm/mach-clps711x/cdb89712.c
+++ b/arch/arm/mach-clps711x/cdb89712.c
@@ -138,6 +138,7 @@ static void __init cdb89712_init(void)
 MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
 	.atag_offset	= 0x100,
+	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.timer		= &clps711x_timer,
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
index 39718f8..f7b6f0a 100644
--- a/arch/arm/mach-clps711x/clep7312.c
+++ b/arch/arm/mach-clps711x/clep7312.c
@@ -42,6 +42,7 @@ static void __init clep7312_init(void)
 MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	/* Maintainer: Nobody */
 	.atag_offset	= 0x0100,
+	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 83cfece..9757b3e 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -4,6 +4,7 @@
  * Common bits.
  */
 
+#define CLPS711X_NR_IRQS	(30)
 #define CLPS711X_NR_GPIO	(4 * 8 + 3)
 #define CLPS711X_GPIO(port,bit)	((port) * 8 + (bit))
 
diff --git a/arch/arm/mach-clps711x/edb7211.c b/arch/arm/mach-clps711x/edb7211.c
index 65d0668..450f66f 100644
--- a/arch/arm/mach-clps711x/edb7211.c
+++ b/arch/arm/mach-clps711x/edb7211.c
@@ -94,6 +94,7 @@ static void __init edb7211_init(void)
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	/* Maintainer: Jon McClintock */
 	.atag_offset	= VIDEORAM_SIZE + 0x100,
+	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
 	.map_io		= edb7211_map_io,
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
index 16db051..ded7911 100644
--- a/arch/arm/mach-clps711x/fortunet.c
+++ b/arch/arm/mach-clps711x/fortunet.c
@@ -80,6 +80,7 @@ static void __init fortunet_init(void)
 
 MACHINE_START(FORTUNET, "ARM-FortuNet")
 	/* Maintainer: FortuNet Inc. */
+	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fortunet_fixup,
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index aee352c..1f4728d 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -277,4 +277,25 @@
 #define MEMCFG_WAITSTATE_2_0	(14 << 2)
 #define MEMCFG_WAITSTATE_1_0	(15 << 2)
 
+/* INTSR1 Interrupts */
+#define IRQ_CSINT		(4)
+#define IRQ_EINT1		(5)
+#define IRQ_EINT2		(6)
+#define IRQ_EINT3		(7)
+#define IRQ_TC1OI		(8)
+#define IRQ_TC2OI		(9)
+#define IRQ_RTCMI		(10)
+#define IRQ_TINT		(11)
+#define IRQ_UTXINT1		(12)
+#define IRQ_URXINT1		(13)
+#define IRQ_UMSINT		(14)
+#define IRQ_SSEOTI		(15)
+
+/* INTSR2 Interrupts */
+#define IRQ_KBDINT		(16 + 0)
+#define IRQ_SS2RX		(16 + 1)
+#define IRQ_SS2TX		(16 + 2)
+#define IRQ_UTXINT2		(16 + 12)
+#define IRQ_URXINT2		(16 + 13)
+
 #endif /* __MACH_CLPS711X_H */
diff --git a/arch/arm/mach-clps711x/include/mach/irqs.h b/arch/arm/mach-clps711x/include/mach/irqs.h
deleted file mode 100644
index 1ea56db..0000000
--- a/arch/arm/mach-clps711x/include/mach/irqs.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/irqs.h
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * Interrupts from INTSR1
- */
-#define IRQ_CSINT			4
-#define IRQ_EINT1			5
-#define IRQ_EINT2			6
-#define IRQ_EINT3			7
-#define IRQ_TC1OI			8
-#define IRQ_TC2OI			9
-#define IRQ_RTCMI			10
-#define IRQ_TINT			11
-#define IRQ_UTXINT1			12
-#define IRQ_URXINT1			13
-#define IRQ_UMSINT			14
-#define IRQ_SSEOTI			15
-
-/*
- * Interrupts from INTSR2
- */
-#define IRQ_KBDINT			(16+0)	/* bit 0 */
-#define IRQ_SS2RX			(16+1)	/* bit 1 */
-#define IRQ_SS2TX			(16+2)	/* bit 2 */
-#define IRQ_UTXINT2			(16+12)	/* bit 12 */
-#define IRQ_URXINT2			(16+13)	/* bit 13 */
-
-#define NR_IRQS				30
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 2f46b63..8c4af58 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -142,6 +142,7 @@ static void __init p720t_init_late(void)
 MACHINE_START(P720T, "ARM-Prospector720T")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_p720t,
 	.map_io		= p720t_map_io,
 	.init_early	= p720t_init_early,
-- 
1.7.8.6
