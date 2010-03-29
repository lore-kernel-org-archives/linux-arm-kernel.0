From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:35 +0300
Subject: [RFC 09/10] arm: implement reserve memory early parameter
In-Reply-To: <4973ec4f4071a967bcb4f8d72bbe950204fcc83a.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<49c5365fe4f794390ca2a4de75365953e211ab3f.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<4973ec4f4071a967bcb4f8d72bbe950204fcc83a.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implemented mem=size$start early parameter which makes it possible to reserve
some memory from the kernel. This can be used for dump capture kernels to
preserve any memory used by the primary kernel.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/include/asm/setup.h |    4 ++++
 arch/arm/kernel/setup.c      |   22 ++++++++++++++++------
 arch/arm/mm/init.c           |   25 +++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index f392fb4..9910300 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -203,6 +203,10 @@ struct membank {
 	unsigned long size;
 	unsigned short node;
 	unsigned short highmem;
+
+#define MEMBANK_FREE		0
+#define MEMBANK_RESERVED	1
+	unsigned int flags;
 };
 
 struct meminfo {
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 25a1664..08de8b7 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -387,7 +387,8 @@ static struct machine_desc * __init setup_machine(unsigned int nr)
 	return list;
 }
 
-static int __init arm_add_memory(unsigned long start, unsigned long size)
+static int __init arm_add_memory(unsigned long start, unsigned long size,
+				 unsigned long flags)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
 
@@ -405,6 +406,7 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
 	bank->start = PAGE_ALIGN(start);
 	bank->size  = size & PAGE_MASK;
 	bank->node  = PHYS_TO_NID(start);
+	bank->flags = flags;
 
 	/*
 	 * Check whether this memory region has non-zero size or
@@ -418,13 +420,17 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
 }
 
 /*
- * Pick out the memory size.  We look for mem=size at start,
+ * Pick out the memory size.  We look for mem=size at start or mem=size$start,
  * where start and size are "size[KkMm]"
+ *
+ * If '$' is used as a separator, it is interpreted as reserve this memory. This
+ * can be usefull for example when we are running dump capture kernel and want
+ * to reserve any memory used by the primary kernel.
  */
 static int __init early_mem(char *p)
 {
 	static int usermem __initdata = 0;
-	unsigned long size, start;
+	unsigned long size, start, flags = 0;
 	char *endp;
 
 	/*
@@ -439,10 +445,14 @@ static int __init early_mem(char *p)
 
 	start = PHYS_OFFSET;
 	size  = memparse(p, &endp);
-	if (*endp == '@')
+	if (*endp == '@') {
+		start = memparse(endp + 1, NULL);
+	} else if (*endp == '$') {
 		start = memparse(endp + 1, NULL);
+		flags = MEMBANK_RESERVED;
+	}
 
-	arm_add_memory(start, size);
+	arm_add_memory(start, size, flags);
 
 	return 0;
 }
@@ -536,7 +546,7 @@ __tagtable(ATAG_CORE, parse_tag_core);
 
 static int __init parse_tag_mem32(const struct tag *tag)
 {
-	return arm_add_memory(tag->u.mem.start, tag->u.mem.size);
+	return arm_add_memory(tag->u.mem.start, tag->u.mem.size, 0);
 }
 
 __tagtable(ATAG_MEM, parse_tag_mem32);
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7829cb5..41fdcd0 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -274,8 +274,29 @@ static void __init bootmem_init_node(int node, struct meminfo *mi,
 
 	for_each_nodebank(i, mi, node) {
 		struct membank *bank = &mi->bank[i];
-		if (!bank->highmem)
-			free_bootmem_node(pgdat, bank_phys_start(bank), bank_phys_size(bank));
+		unsigned long start, size;
+
+		if (bank->highmem)
+			continue;
+
+		start = bank_phys_start(bank);
+		size = bank_phys_size(bank);
+
+		free_bootmem_node(pgdat, start, size);
+
+		if (bank->flags & MEMBANK_RESERVED) {
+			int err;
+
+			err = reserve_bootmem_node(pgdat, start, size,
+						   BOOTMEM_EXCLUSIVE);
+			if (err)
+				continue;
+
+			printk(KERN_INFO
+				"reserved memory: "
+				"[0x%08lx - 0x%08lx] (%4ld MB)\n",
+				start, start + size - 1, size >> 20);
+		}
 	}
 
 	/*
-- 
1.5.6.5
