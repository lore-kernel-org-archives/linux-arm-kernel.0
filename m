From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  2 Oct 2011 16:57:00 +0800
Subject: [PATCH 1/2] ARM: smp: Add an IPI handler callable from C code
In-Reply-To: <1317545821-23194-1-git-send-email-shawn.guo@linaro.org>
References: <1317545821-23194-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317545821-23194-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to be able to handle IPI directly from C code instead of
assembly code, introduce handle_IPI(), which is modeled after handle_IRQ().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/smp.h |    5 +++++
 arch/arm/kernel/smp.c      |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 674ebcd..0a17b62 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -33,6 +33,11 @@ extern void show_ipi_list(struct seq_file *, int);
 asmlinkage void do_IPI(int ipinr, struct pt_regs *regs);
 
 /*
+ * Called from C code, this handles an IPI.
+ */
+void handle_IPI(int ipinr, struct pt_regs *regs);
+
+/*
  * Setup the set of possible CPUs (via set_cpu_possible)
  */
 extern void smp_init_cpus(void);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3f12ce9..2e49f18 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -587,6 +587,11 @@ static void ipi_cpu_stop(unsigned int cpu)
  */
 asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
 {
+	handle_IPI(ipinr, regs);
+}
+
+void handle_IPI(int ipinr, struct pt_regs *regs)
+{
 	unsigned int cpu = smp_processor_id();
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-- 
1.7.4.1
