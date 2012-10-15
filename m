From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 15 Oct 2012 14:51:33 -0700
Subject: [PATCH 09/10] ARM: FIQ: Make show_fiq_list() return void
In-Reply-To: <20121015214954.GA3352@lizard>
References: <20121015214954.GA3352@lizard>
Message-ID: <1350337894-9744-9-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return value is never checked, so we can turn show_fiq_list() into
returning void.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/include/asm/mach/irq.h | 4 ++--
 arch/arm/kernel/fiq.c           | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index 420d211..8be5ba9 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -19,10 +19,10 @@ struct seq_file;
  */
 #ifdef CONFIG_FIQ
 extern void init_FIQ(void);
-extern int show_fiq_list(struct seq_file *, int);
+extern void show_fiq_list(struct seq_file *, int);
 #else
 static inline void init_FIQ(void) {}
-static inline int show_fiq_list(struct seq_file *p, int prec) { return 0; }
+static inline void show_fiq_list(struct seq_file *p, int prec) {}
 #endif
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 7be2e74..9bf3a60 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -69,13 +69,11 @@ static struct fiq_handler default_owner = {
 
 static struct fiq_handler *current_fiq = &default_owner;
 
-int show_fiq_list(struct seq_file *p, int prec)
+void show_fiq_list(struct seq_file *p, int prec)
 {
 	if (current_fiq != &default_owner)
 		seq_printf(p, "%*s:              %s\n", prec, "FIQ",
 			current_fiq->name);
-
-	return 0;
 }
 
 void set_fiq_handler(void *start, unsigned int length)
-- 
1.7.12.3
