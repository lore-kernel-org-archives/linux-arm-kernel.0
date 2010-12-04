From: tony@atomide.com (Tony Lindgren)
Date: Fri, 03 Dec 2010 16:20:39 -0800
Subject: [PATCH 2/4] omap2+: Use asm_irq_base for entry-macro.S
In-Reply-To: <20101204001435.28853.29616.stgit@baageli.muru.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
Message-ID: <20101204002039.28853.68667.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way we can use the generic omap SoC detection code instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   37 +++---------------------
 arch/arm/mach-omap2/io.c                       |   20 +++++++++++++
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 06e64e1..c29728c 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -38,41 +38,14 @@
  */
 
 #ifdef MULTI_OMAP2
-		.pushsection .data
-omap_irq_base:	.word	0
-		.popsection
 
-		/* Configure the interrupt base on the first interrupt */
+		/*
+		 * Configure the interrupt base on the first interrupt.
+		 * See also omap_irq_base_init for setting asm_irq_base.
+		 */
 		.macro  get_irqnr_preamble, base, tmp
-9:
-		ldr	\base, =omap_irq_base	@ irq base address
+		ldr	\base, =asm_irq_base	@ irq base address
 		ldr	\base, [\base, #0]	@ irq base value
-		cmp	\base, #0		@ already configured?
-		bne	9997f			@ nothing to do
-
-		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
-		and	\tmp, \tmp, #0x000f0000	@ only check architecture
-		cmp	\tmp, #0x00070000	@ is v6?
-		beq	2400f			@ found v6 so it's omap24xx
-		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
-		and	\tmp, \tmp, #0x000000f0	@ check cortex 8 or 9
-		cmp	\tmp, #0x00000080	@ cortex A-8?
-		beq	3400f			@ found A-8 so it's omap34xx
-		cmp	\tmp, #0x00000090	@ cortex A-9?
-		beq	4400f			@ found A-9 so it's omap44xx
-2400:		ldr	\base, =OMAP2_IRQ_BASE
-		ldr	\tmp, =omap_irq_base
-		str	\base, [\tmp, #0]
-		b	9b
-3400:		ldr	\base, =OMAP3_IRQ_BASE
-		ldr	\tmp, =omap_irq_base
-		str	\base, [\tmp, #0]
-		b	9b
-4400:		ldr	\base, =OMAP4_IRQ_BASE
-		ldr	\tmp, =omap_irq_base
-		str	\base, [\tmp, #0]
-		b	9b
-9997:
 		.endm
 
 		/* Check the pending interrupts. Note that base already set */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a1939b1..7ac1d31 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -46,6 +46,7 @@
 #include "clockdomains.h"
 
 #include <plat/omap_hwmod.h>
+#include <plat/multi.h>
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -311,6 +312,23 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
 
+/*
+ * Initialize asm_irq_base for entry-macro.S
+ */
+static inline void omap_irq_base_init(void)
+{
+#ifdef MULTI_OMAP2
+	if (cpu_is_omap242x())
+		asm_irq_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
+	else if (cpu_is_omap34xx())
+		asm_irq_base = OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE);
+	else if (cpu_is_omap44xx())
+		asm_irq_base = OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE);
+	else
+		pr_err("Could not initialize asm_irq_base\n");
+#endif
+}
+
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
 {
@@ -352,4 +370,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 	gpmc_init();
+
+	omap_irq_base_init();
 }
