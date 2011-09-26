From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:21 +0100
Subject: [PATCH v2 02/16] ARM: smp: Add an IPI handler callable from C code
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to handle IPI directly from C code instead of
assembly code, introduce handle_IPI(), which is modeled after handle_IRQ().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/smp.h |    5 +++++
 arch/arm/kernel/smp.c      |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 7c2299f..1e5717a 100644
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
index fcca40b..5e060ea 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -603,6 +603,11 @@ static void ipi_cpu_stop(unsigned int cpu)
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
1.7.0.4
