From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 11 Jul 2012 10:39:48 +0100
Subject: [PATCH v2] arm: Handle >4GB memory sizes in device tree and
 mem=size@start option
Message-ID: <1341999588-32544-1-git-send-email-peter.maydell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory regions which are passed to arm_add_memory() from
device tree blobs via early_init_dt_add_memory_arch() can
have sizes which are larger than will fit in a 32 bit integer,
so switch to using a phys_addr_t to hold them, to avoid
silently dropping the top 32 bits of the size. Similarly, use
phys_addr_t in early_mem() so that mem=size at start command line
options specifying more than 4GB behave sensibly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * fixed spacing round '-'
 * made early_mem() handle large sizes too

 arch/arm/include/asm/setup.h |    4 ++--
 arch/arm/kernel/setup.c      |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 23ebc0c..24d284a 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -196,7 +196,7 @@ static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 
 struct membank {
 	phys_addr_t start;
-	unsigned long size;
+	phys_addr_t size;
 	unsigned int highmem;
 };
 
@@ -217,7 +217,7 @@ extern struct meminfo meminfo;
 #define bank_phys_end(bank)	((bank)->start + (bank)->size)
 #define bank_phys_size(bank)	(bank)->size
 
-extern int arm_add_memory(phys_addr_t start, unsigned long size);
+extern int arm_add_memory(phys_addr_t start, phys_addr_t size);
 extern void early_print(const char *str, ...);
 extern void dump_machine_table(void);
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e15d83b..a81dcec 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -508,7 +508,7 @@ void __init dump_machine_table(void)
 		/* can't use cpu_relax() here as it may require MMU setup */;
 }
 
-int __init arm_add_memory(phys_addr_t start, unsigned long size)
+int __init arm_add_memory(phys_addr_t start, phys_addr_t size)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
 
@@ -538,7 +538,7 @@ int __init arm_add_memory(phys_addr_t start, unsigned long size)
 	}
 #endif
 
-	bank->size = size & PAGE_MASK;
+	bank->size = size & ~(phys_addr_t)(PAGE_SIZE - 1);
 
 	/*
 	 * Check whether this memory region has non-zero size or
@@ -558,7 +558,7 @@ int __init arm_add_memory(phys_addr_t start, unsigned long size)
 static int __init early_mem(char *p)
 {
 	static int usermem __initdata = 0;
-	unsigned long size;
+	phys_addr_t size;
 	phys_addr_t start;
 	char *endp;
 
-- 
1.7.9.5
