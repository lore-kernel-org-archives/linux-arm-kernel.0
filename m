From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 17 Feb 2011 20:26:55 -0500 (EST)
Subject: [PATCH] ARM: fold lookup_machine_type() into setup_machine()
Message-ID: <alpine.LFD.2.00.1102172023350.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Since commit 6fc31d54 there is no callers for lookup_machine_type()
other than setup_machine(). And if the former fails it won't return,
therefore the error path in the later is dead code.  Let's clean
things up by merging them together.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---

This is meant for the p2v-stable branch.

 arch/arm/kernel/setup.c |   48 ++++++++++++++++------------------------------
 1 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 773b5cd..f43f041 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -325,28 +325,6 @@ static void __init early_print(const char *str, ...)
 	printk("%s", buf);
 }
 
-static struct machine_desc * __init lookup_machine_type(unsigned int type)
-{
-	extern struct machine_desc __arch_info_begin[], __arch_info_end[];
-	struct machine_desc *p;
-
-	for (p = __arch_info_begin; p < __arch_info_end; p++)
-		if (type == p->nr)
-			return p;
-
-	early_print("\n"
-		"Error: unrecognized/unsupported machine ID (r1 = 0x%08x).\n\n"
-		"Available machine support:\n\nID (hex)\tNAME\n", type);
-
-	for (p = __arch_info_begin; p < __arch_info_end; p++)
-		early_print("%08x\t%s\n", p->nr, p->name);
-
-	early_print("\nPlease check your kernel config and/or bootloader.\n");
-
-	while (true)
-		/* can't use cpu_relax() here as it may require MMU setup */;
-}
-
 static void __init feat_v6_fixup(void)
 {
 	int id = read_cpuid_id();
@@ -463,21 +441,29 @@ void cpu_init(void)
 
 static struct machine_desc * __init setup_machine(unsigned int nr)
 {
-	struct machine_desc *list;
+	extern struct machine_desc __arch_info_begin[], __arch_info_end[];
+	struct machine_desc *p;
 
 	/*
 	 * locate machine in the list of supported machines.
 	 */
-	list = lookup_machine_type(nr);
-	if (!list) {
-		printk("Machine configuration botched (nr %d), unable "
-		       "to continue.\n", nr);
-		while (1);
-	}
+	for (p = __arch_info_begin; p < __arch_info_end; p++)
+		if (nr == p->nr) {
+			printk("Machine: %s\n", p->name);
+			return p;
+		}
 
-	printk("Machine: %s\n", list->name);
+	early_print("\n"
+		"Error: unrecognized/unsupported machine ID (r1 = 0x%08x).\n\n"
+		"Available machine support:\n\nID (hex)\tNAME\n", nr);
+
+	for (p = __arch_info_begin; p < __arch_info_end; p++)
+		early_print("%08x\t%s\n", p->nr, p->name);
 
-	return list;
+	early_print("\nPlease check your kernel config and/or bootloader.\n");
+
+	while (true)
+		/* can't use cpu_relax() here as it may require MMU setup */;
 }
 
 static int __init arm_add_memory(unsigned long start, unsigned long size)
