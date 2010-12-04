From: tony@atomide.com (Tony Lindgren)
Date: Fri, 03 Dec 2010 16:20:36 -0800
Subject: [PATCH 1/4] ARM: Add asm_irq_base and asm_irq_flags for entry-armv.S
	macros
In-Reply-To: <20101204001435.28853.29616.stgit@baageli.muru.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
Message-ID: <20101204002036.28853.9320.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way we can use the SoC specific code to detect what we're
running on.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/irq.h   |    2 ++
 arch/arm/kernel/entry-armv.S |   13 +++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 2721a58..2610c59 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -20,6 +20,8 @@
 #ifndef __ASSEMBLY__
 struct irqaction;
 struct pt_regs;
+extern void __iomem *asm_irq_base;
+extern unsigned int asm_irq_flags;
 extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c09e357..37cdb27 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -63,6 +63,19 @@
 
 	.endm
 
+/*
+ * Allow machine specific code to initialize asm_irq_base and asm_irq_flags
+ * for use in get_irqnr_preamble and get_irqnr_and_base macros
+ */
+	.pushsection .data
+	.globl	asm_irq_base
+asm_irq_base:
+	.long	0
+	.globl	asm_irq_flags
+asm_irq_flags:
+	.long	0
+	.popsection
+
 #ifdef CONFIG_KPROBES
 	.section	.kprobes.text,"ax",%progbits
 #else
