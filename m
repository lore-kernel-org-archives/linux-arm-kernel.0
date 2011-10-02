From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  2 Oct 2011 16:57:01 +0800
Subject: [PATCH 2/2] ARM: smp: Add a localtimer handler callable from C code
In-Reply-To: <1317545821-23194-1-git-send-email-shawn.guo@linaro.org>
References: <1317545821-23194-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317545821-23194-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to handle localtimer directly from C code instead of
assembly code, introduce handle_local_timer(), which is modeled after
handle_IRQ().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/include/asm/localtimer.h |    4 ++++
 arch/arm/kernel/smp.c             |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..3306f28 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -22,6 +22,10 @@ void percpu_timer_setup(void);
  */
 asmlinkage void do_local_timer(struct pt_regs *);
 
+/*
+ * Called from C code
+ */
+void handle_local_timer(struct pt_regs *);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 2e49f18..0949007 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -480,6 +480,11 @@ static void ipi_timer(void)
 #ifdef CONFIG_LOCAL_TIMERS
 asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
 {
+	handle_local_timer(regs);
+}
+
+void handle_local_timer(struct pt_regs *regs)
+{
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	int cpu = smp_processor_id();
 
-- 
1.7.4.1
