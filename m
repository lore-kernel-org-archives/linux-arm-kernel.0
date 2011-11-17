From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 17 Nov 2011 14:40:00 +0100
Subject: [PATCH] ARM: fix unwinding for XIP kernels
Message-ID: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linker places the unwind tables in readonly sections. So when using
an XIP kernel these are located in ROM and cannot be modified.

For that reason don't convert the symbol addresses during boot (or
module loading) but only when interpreting them in search_index().
Moreover several consts are added to catch future writes and rename the
member "addr" of struct unwind_idx to "addr_offset" to better match the
new semantic.

This fixes unwinding on XIP which compared prel31 offsets to absolute
addresses because the initial conversion from prel31 to absolute failed.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this is broken since unwinding was introduce in v2.6.30-rc1.

Best regards
Uwe

 arch/arm/include/asm/unwind.h |   15 ++----------
 arch/arm/kernel/setup.c       |    2 -
 arch/arm/kernel/unwind.c      |   48 ++++++++++++----------------------------
 3 files changed, 18 insertions(+), 47 deletions(-)

diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index a5edf42..2ae0e0a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -30,14 +30,14 @@ enum unwind_reason_code {
 };
 
 struct unwind_idx {
-	unsigned long addr;
+	unsigned long addr_offset;
 	unsigned long insn;
 };
 
 struct unwind_table {
 	struct list_head list;
-	struct unwind_idx *start;
-	struct unwind_idx *stop;
+	const struct unwind_idx *start;
+	const struct unwind_idx *stop;
 	unsigned long begin_addr;
 	unsigned long end_addr;
 };
@@ -49,15 +49,6 @@ extern struct unwind_table *unwind_table_add(unsigned long start,
 extern void unwind_table_del(struct unwind_table *tab);
 extern void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk);
 
-#ifdef CONFIG_ARM_UNWIND
-extern int __init unwind_init(void);
-#else
-static inline int __init unwind_init(void)
-{
-	return 0;
-}
-#endif
-
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_ARM_UNWIND
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7e7977a..cf9d71a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -893,8 +893,6 @@ void __init setup_arch(char **cmdline_p)
 {
 	struct machine_desc *mdesc;
 
-	unwind_init();
-
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index e7e8365..ad3f06f 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -67,7 +67,7 @@ EXPORT_SYMBOL(__aeabi_unwind_cpp_pr2);
 
 struct unwind_ctrl_block {
 	unsigned long vrs[16];		/* virtual register set */
-	unsigned long *insn;		/* pointer to the current instructions word */
+	const unsigned long *insn;	/* pointer to the current instructions word */
 	int entries;			/* number of entries left to interpret */
 	int byte;			/* current byte number in the instructions word */
 };
@@ -83,8 +83,8 @@ enum regs {
 	PC = 15
 };
 
-extern struct unwind_idx __start_unwind_idx[];
-extern struct unwind_idx __stop_unwind_idx[];
+extern const struct unwind_idx __start_unwind_idx[];
+extern const struct unwind_idx __stop_unwind_idx[];
 
 static DEFINE_SPINLOCK(unwind_lock);
 static LIST_HEAD(unwind_tables);
@@ -101,22 +101,22 @@ static LIST_HEAD(unwind_tables);
  * Binary search in the unwind index. The entries entries are
  * guaranteed to be sorted in ascending order by the linker.
  */
-static struct unwind_idx *search_index(unsigned long addr,
-				       struct unwind_idx *first,
-				       struct unwind_idx *last)
+static const struct unwind_idx *search_index(unsigned long addr,
+				       const struct unwind_idx *first,
+				       const struct unwind_idx *last)
 {
 	pr_debug("%s(%08lx, %p, %p)\n", __func__, addr, first, last);
 
-	if (addr < first->addr) {
+	if (addr < prel31_to_addr(&first->addr_offset)) {
 		pr_warning("unwind: Unknown symbol address %08lx\n", addr);
 		return NULL;
-	} else if (addr >= last->addr)
+	} else if (addr >= prel31_to_addr(&last->addr_offset))
 		return last;
 
 	while (first < last - 1) {
-		struct unwind_idx *mid = first + ((last - first + 1) >> 1);
+		const struct unwind_idx *mid = first + ((last - first + 1) >> 1);
 
-		if (addr < mid->addr)
+		if (addr < prel31_to_addr(&mid->addr_offset))
 			last = mid;
 		else
 			first = mid;
@@ -125,9 +125,9 @@ static struct unwind_idx *search_index(unsigned long addr,
 	return first;
 }
 
-static struct unwind_idx *unwind_find_idx(unsigned long addr)
+static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 {
-	struct unwind_idx *idx = NULL;
+	const struct unwind_idx *idx = NULL;
 	unsigned long flags;
 
 	pr_debug("%s(%08lx)\n", __func__, addr);
@@ -274,7 +274,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 int unwind_frame(struct stackframe *frame)
 {
 	unsigned long high, low;
-	struct unwind_idx *idx;
+	const struct unwind_idx *idx;
 	struct unwind_ctrl_block ctrl;
 
 	/* only go to a higher address on the stack */
@@ -399,7 +399,6 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
 				      unsigned long text_size)
 {
 	unsigned long flags;
-	struct unwind_idx *idx;
 	struct unwind_table *tab = kmalloc(sizeof(*tab), GFP_KERNEL);
 
 	pr_debug("%s(%08lx, %08lx, %08lx, %08lx)\n", __func__, start, size,
@@ -408,15 +407,11 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
 	if (!tab)
 		return tab;
 
-	tab->start = (struct unwind_idx *)start;
-	tab->stop = (struct unwind_idx *)(start + size);
+	tab->start = (const struct unwind_idx *)start;
+	tab->stop = (const struct unwind_idx *)(start + size);
 	tab->begin_addr = text_addr;
 	tab->end_addr = text_addr + text_size;
 
-	/* Convert the symbol addresses to absolute values */
-	for (idx = tab->start; idx < tab->stop; idx++)
-		idx->addr = prel31_to_addr(&idx->addr);
-
 	spin_lock_irqsave(&unwind_lock, flags);
 	list_add_tail(&tab->list, &unwind_tables);
 	spin_unlock_irqrestore(&unwind_lock, flags);
@@ -437,16 +432,3 @@ void unwind_table_del(struct unwind_table *tab)
 
 	kfree(tab);
 }
-
-int __init unwind_init(void)
-{
-	struct unwind_idx *idx;
-
-	/* Convert the symbol addresses to absolute values */
-	for (idx = __start_unwind_idx; idx < __stop_unwind_idx; idx++)
-		idx->addr = prel31_to_addr(&idx->addr);
-
-	pr_debug("unwind: ARM stack unwinding initialised\n");
-
-	return 0;
-}
-- 
1.7.7.1
