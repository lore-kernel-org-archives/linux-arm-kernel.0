From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 15 Oct 2012 14:51:29 -0700
Subject: [PATCH 05/10] ARM: FIQ: Remove enable_fiq() and disable_fiq() calls
In-Reply-To: <20121015214954.GA3352@lizard>
References: <20121015214954.GA3352@lizard>
Message-ID: <1350337894-9744-5-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no users left, so these can be removed.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/include/asm/fiq.h |  2 --
 arch/arm/kernel/fiq.c      | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index d493d0b..a293be4 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -36,8 +36,6 @@ struct fiq_handler {
 extern int claim_fiq(struct fiq_handler *f);
 extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
-extern void enable_fiq(int fiq);
-extern void disable_fiq(int fiq);
 
 /* helpers defined in fiqasm.S: */
 extern void __set_fiq_regs(unsigned long const *regs);
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 2adda11..29b93b8 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -122,28 +122,13 @@ void release_fiq(struct fiq_handler *f)
 	while (current_fiq->fiq_op(current_fiq->dev_id, 0));
 }
 
-static int fiq_start;
-
-void enable_fiq(int fiq)
-{
-	enable_irq(fiq + fiq_start);
-}
-
-void disable_fiq(int fiq)
-{
-	disable_irq(fiq + fiq_start);
-}
-
 EXPORT_SYMBOL(set_fiq_handler);
 EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(claim_fiq);
 EXPORT_SYMBOL(release_fiq);
-EXPORT_SYMBOL(enable_fiq);
-EXPORT_SYMBOL(disable_fiq);
 
 void __init init_FIQ(int start)
 {
 	no_fiq_insn = *(unsigned long *)0xffff001c;
-	fiq_start = start;
 }
-- 
1.7.12.3
