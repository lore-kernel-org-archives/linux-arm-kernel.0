From: neidhard.kim@lge.com (Jongsung Kim)
Date: Tue, 16 Aug 2016 21:55:17 +0900
Subject: [PATCH] arm: module-plts: improve algorithm for counting PLTs
Message-ID: <1471352117-19113-1-git-send-email-neidhard.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current count_plts() uses O(n^2) algorithm for counting distinct
PLTs. It's good and fast enough when handling relatively small
number of relocs. But the time for counting grows so fast by its
nature. A Cortex-A53 operating at 1GHz takes about 10 seconds to
count 4,819 distinct PLTs from 257,394 relocs. It can be serious
for embedded systems those usually want to boot fast.

This patch introduces faster O(n) algorithm for counting unique
PLTs using hash-table. The following table compares the time (in
usecs) for counting distinct PLTs from relocs (using Cortex-A53
@1GHz mentioned above):

	--------------------------------------
	  relocs    PLTs      O(n^2)     O(n)
	--------------------------------------
	      15       1           1       27
	      30       6           1       29
	      60      14           5       31
	     120      26          15       32
	     240      47          51       36
	     480      88         216       50
	     960     125         560       67
	   1,920     191       1,476      106
	   3,840     253       5,731      179
	   7,680     431      21,226      347
	  15,360     637      88,211      698
	  30,720   1,291     331,626    1,369
	  61,440   1,902     803,964    2,917
	 122,880   3,320   4,129,439    6,428
	 245,760   4,646   8,837,064   13,024
	======================================

The time increases near-linearly, and the time to handling same
257,394 relocs is reduced to < 20msec from 10 seconds. (< 0.2%)

With very small number of PLTs, O(n^2) counting is still faster
than O(n) counting, because O(n) counting needs additional O(n)
memory space allocation. In these cases, however, the difference
looks very short and negligible.

This patch does not replaces original O(n^2) counting algorithm
with introduced O(n) algorithm, to use it as fall-back algorithm
when required memory allocation fails.

Reported-by: Chanho Min <chanho.min@lge.com>
Suggested-by: Youngho Shin <youngho.shin@lge.com>
Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
Reviewed-by: Namhyung Kim <namhyung.kim@lge.com>
---
 arch/arm/kernel/module-plts.c | 111 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 0c7efc3..dae7459 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -9,6 +9,8 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
 
 #include <asm/cache.h>
 #include <asm/opcodes.h>
@@ -25,11 +27,26 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
+#define PLT_HASH_SHIFT		10
+#define PLT_HASH_SIZE		(1 << PLT_HASH_SHIFT)
+#define PLT_HASH_MASK		(PLT_HASH_SIZE - 1)
+
 struct plt_entries {
 	u32	ldr[PLT_ENT_COUNT];
 	u32	lit[PLT_ENT_COUNT];
 };
 
+struct plt_hash_entry {
+	struct plt_hash_entry *next;
+	Elf32_Rel const *plt;
+};
+
+struct plt_hash_table {
+	struct plt_hash_entry *table[PLT_HASH_SIZE];
+	size_t used;
+	struct plt_hash_entry entry[0];
+};
+
 static bool in_init(const struct module *mod, u32 addr)
 {
 	return addr - (u32)mod->init_layout.base < mod->init_layout.size;
@@ -100,7 +117,7 @@ static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num,
 }
 
 /* Count how many PLT entries we may need */
-static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
+static unsigned int _count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
 {
 	unsigned int ret = 0;
 	int i;
@@ -129,6 +146,98 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
 	return ret;
 }
 
+static unsigned int hash_plt(Elf32_Rel const *plt, Elf32_Addr base, u32 mask)
+{
+	u32 const *loc = (u32 *)(base + plt->r_offset);
+	u32 hash = (plt->r_info >> 8) ^ (*loc & mask);
+	return hash & PLT_HASH_MASK;
+}
+
+static bool
+same_plts(Elf32_Rel const *a, Elf32_Rel const *b, Elf32_Addr base, u32 mask)
+{
+	u32 const *loc1;
+	u32 const *loc2;
+
+	if (a->r_info != b->r_info)
+		return false;
+
+	loc1 = (u32 *)(base + a->r_offset);
+	loc2 = (u32 *)(base + b->r_offset);
+
+	return ((*loc1 ^ *loc2) & mask) == 0;
+}
+
+static int hash_insert_plt(struct plt_hash_table *table, Elf32_Rel const *plt,
+			   Elf32_Addr base, u32 mask)
+{
+	unsigned int hash = hash_plt(plt, base, mask);
+	struct plt_hash_entry *entry;
+
+	for (entry = table->table[hash]; entry; entry = entry->next)
+		if (same_plts(entry->plt, plt, base, mask))
+			return 0;
+
+	entry = &table->entry[table->used++];
+	entry->next = table->table[hash];
+	entry->plt = plt;
+	table->table[hash] = entry;
+
+	return 1;
+}
+
+static size_t count_plts(Elf32_Addr base, Elf32_Rel const *rel, int num)
+{
+	struct plt_hash_table *table;
+	size_t plts;
+	u32 mask;
+	int i;
+
+	/* count PLTs first to optimize memory usage */
+	for (plts = i = 0; i < num; i++) {
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_ARM_CALL:
+		case R_ARM_PC24:
+		case R_ARM_JUMP24:
+#ifdef CONFIG_THUMB2_KERNEL
+		case R_ARM_THM_CALL:
+		case R_ARM_THM_JUMP24:
+#endif
+			plts++;
+			break;
+		}
+	}
+
+	table = vzalloc(sizeof(struct plt_hash_table) +
+			sizeof(struct plt_hash_entry) * plts);
+	if (!table) {
+		/* fall-back to O(n^2) counting on memory shortage */
+		return _count_plts(base, rel, num);
+	}
+
+	for (plts = i = 0; i < num; i++) {
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_ARM_CALL:
+		case R_ARM_PC24:
+		case R_ARM_JUMP24:
+			mask = __opcode_to_mem_arm(0x00ffffff);
+			plts += hash_insert_plt(table, &rel[i], base, mask);
+			break;
+#ifdef CONFIG_THUMB2_KERNEL
+		case R_ARM_THM_CALL:
+		case R_ARM_THM_JUMP24:
+			mask = __opcode_to_mem_thumb32(0x07ff2fff);
+			plts += hash_insert_plt(table, &rel[i], base, mask);
+			break;
+#endif
+		}
+	}
+
+	vfree(table);
+
+	return plts;
+}
+
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-- 
2.7.4
