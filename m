From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:00:53 +0100
Subject: [PATCH 02/16] arm: add set_handle_irq() to register the parent IRQ
 controller handler function
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow irqchip drivers to register their IRQ handling
function as the parent IRQ controller handler function, we provide a
convenience function. This will avoid poking directly into the global
handle_arch_irq variable, and ensures that the user gets warned if
we're trying to register a second IRQ controller as the parent one.

Suggested by Arnd Bergmann.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/include/asm/mach/irq.h |    1 +
 arch/arm/kernel/irq.c           |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index 15cb035..18c8830 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -22,6 +22,7 @@ extern int show_fiq_list(struct seq_file *, int);
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
 extern void (*handle_arch_irq)(struct pt_regs *);
+extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #endif
 
 /*
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 8961650..f135dab 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -117,6 +117,16 @@ void __init init_IRQ(void)
 	machine_desc->init_irq();
 }
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
+{
+	if (WARN_ON(handle_arch_irq))
+		return;
+
+	handle_arch_irq = handle_irq;
+}
+#endif
+
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-- 
1.7.9.5
