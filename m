From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:11 -0600
Subject: [PATCH v4 02/19] arm: add set_handle_irq() to register the parent IRQ
 controller handler function
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

In order to allow irqchip drivers to register their IRQ handling
function as the parent IRQ controller handler function, we provide a
convenience function. This will avoid poking directly into the global
handle_arch_irq variable.

Suggested by Arnd Bergmann.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
[Rob Herring: remove warning. 1st one to initialize wins.]
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Olof Johansson <olof@lixom.net>
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
index 8961650..8e4ef4c 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -117,6 +117,16 @@ void __init init_IRQ(void)
 	machine_desc->init_irq();
 }
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
+{
+	if (handle_arch_irq)
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
1.7.10.4
