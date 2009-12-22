From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 02/11] arm: use generic infrastructure for early params
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.246097.171417450949.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM setup code includes its own parser for early params, there's
also one in the generic init code.

This patch removes __early_init (and related code) from
arch/arm/kernel/setup.c, and changes users to the generic early_init
macro instead.

The generic macro takes a char * argument, rather than char **, so we
need to update the parser functions a little.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/setup.h      |   12 -----
 arch/arm/kernel/setup.c           |   62 +++++++-----------------------
 arch/arm/kernel/vmlinux.lds.S     |    3 -
 arch/arm/mach-footbridge/common.c |    7 +--
 arch/arm/mm/init.c                |   12 +++--
 arch/arm/mm/mmu.c                 |   41 ++++++++++---------
 6 files changed, 48 insertions(+), 89 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 1e2ab1b..3b6f461 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -221,18 +221,6 @@ extern struct meminfo meminfo;
 #define bank_phys_end(bank)	((bank)->start + (bank)->size)
 #define bank_phys_size(bank)	(bank)->size
 
-/*
- * Early command line parameters.
- */
-struct early_params {
-	const char *arg;
-	void (*fn)(char **p);
-};
-
-#define __early_param(name,fn)					\
-static struct early_params __early_##fn __used			\
-__attribute__((__section__(".early_param.init"))) = { name, fn }
-
 #define COMMAND_LINE_SIZE 1024
 
 extern char cmd_line[COMMAND_LINE_SIZE];
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 015803a..4206286 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -417,10 +417,11 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
  * Pick out the memory size.  We look for mem=size at start,
  * where start and size are "size[KkMm]"
  */
-static void __init early_mem(char **p)
+static int __init early_mem(char *p)
 {
 	static int usermem __initdata = 0;
 	unsigned long size, start;
+	char *endp;
 
 	/*
 	 * If the user specifies memory size, we
@@ -433,52 +434,15 @@ static void __init early_mem(char **p)
 	}
 
 	start = PHYS_OFFSET;
-	size  = memparse(*p, p);
-	if (**p == '@')
-		start = memparse(*p + 1, p);
+	size  = memparse(p, &endp);
+	if (*endp == '@')
+		start = memparse(endp + 1, NULL);
 
 	arm_add_memory(start, size);
-}
-__early_param("mem=", early_mem);
 
-/*
- * Initial parsing of the command line.
- */
-static void __init parse_cmdline(char **cmdline_p, char *from)
-{
-	char c = ' ', *to = cmd_line;
-	int len = 0;
-
-	for (;;) {
-		if (c == ' ') {
-			extern struct early_params __early_begin, __early_end;
-			struct early_params *p;
-
-			for (p = &__early_begin; p < &__early_end; p++) {
-				int arglen = strlen(p->arg);
-
-				if (memcmp(from, p->arg, arglen) == 0) {
-					if (to != cmd_line)
-						to -= 1;
-					from += arglen;
-					p->fn(&from);
-
-					while (*from != ' ' && *from != '\0')
-						from++;
-					break;
-				}
-			}
-		}
-		c = *from++;
-		if (!c)
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*to++ = c;
-	}
-	*to = '\0';
-	*cmdline_p = cmd_line;
+	return 0;
 }
+early_param("mem", early_mem);
 
 static void __init
 setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
@@ -739,9 +703,15 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data   = (unsigned long) _edata;
 	init_mm.brk	   = (unsigned long) _end;
 
-	memcpy(boot_command_line, from, COMMAND_LINE_SIZE);
-	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
-	parse_cmdline(cmdline_p, from);
+	/* parse_early_param needs a boot_command_line */
+	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+
+	/* populate cmd_line too for later use, preserving boot_command_line */
+	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = cmd_line;
+
+	parse_early_param();
+
 	paging_init(mdesc);
 	request_standard_resources(&meminfo, mdesc);
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index aecf87d..1975c76 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -46,9 +46,6 @@ SECTIONS
 		__setup_start = .;
 			*(.init.setup)
 		__setup_end = .;
-		__early_begin = .;
-			*(.early_param.init)
-		__early_end = .;
 		__initcall_start = .;
 			INITCALLS
 		__initcall_end = .;
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index b97f529..8a4a8d8 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -32,12 +32,13 @@ unsigned int mem_fclk_21285 = 50000000;
 
 EXPORT_SYMBOL(mem_fclk_21285);
 
-static void __init early_fclk(char **arg)
+static int __init early_fclk(char *arg)
 {
-	mem_fclk_21285 = simple_strtoul(*arg, arg, 0);
+	mem_fclk_21285 = simple_strtoul(arg, NULL, 0);
+	return 0;
 }
 
-__early_param("mem_fclk_21285=", early_fclk);
+early_param("mem_fclk_21285", early_fclk);
 
 static int __init parse_tag_memclk(const struct tag *tag)
 {
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 52c40d1..4d3c90f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -32,19 +32,21 @@
 static unsigned long phys_initrd_start __initdata = 0;
 static unsigned long phys_initrd_size __initdata = 0;
 
-static void __init early_initrd(char **p)
+static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
+	char *endp;
 
-	start = memparse(*p, p);
-	if (**p == ',') {
-		size = memparse((*p) + 1, p);
+	start = memparse(p, &endp);
+	if (*endp == ',') {
+		size = memparse(endp + 1, NULL);
 
 		phys_initrd_start = start;
 		phys_initrd_size = size;
 	}
+	return 0;
 }
-__early_param("initrd=", early_initrd);
+early_param("initrd", early_initrd);
 
 static int __init parse_tag_initrd(const struct tag *tag)
 {
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ea67be0..7c07a16 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -100,18 +100,17 @@ static struct cachepolicy cache_policies[] __initdata = {
  * writebuffer to be turned off.  (Note: the write
  * buffer should not be on and the cache off).
  */
-static void __init early_cachepolicy(char **p)
+static int __init early_cachepolicy(char *p)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cache_policies); i++) {
 		int len = strlen(cache_policies[i].policy);
 
-		if (memcmp(*p, cache_policies[i].policy, len) == 0) {
+		if (memcmp(p, cache_policies[i].policy, len) == 0) {
 			cachepolicy = i;
 			cr_alignment &= ~cache_policies[i].cr_mask;
 			cr_no_alignment &= ~cache_policies[i].cr_mask;
-			*p += len;
 			break;
 		}
 	}
@@ -130,36 +129,37 @@ static void __init early_cachepolicy(char **p)
 	}
 	flush_cache_all();
 	set_cr(cr_alignment);
+	return 0;
 }
-__early_param("cachepolicy=", early_cachepolicy);
+early_param("cachepolicy", early_cachepolicy);
 
-static void __init early_nocache(char **__unused)
+static int __init early_nocache(char *__unused)
 {
 	char *p = "buffered";
 	printk(KERN_WARNING "nocache is deprecated; use cachepolicy=%s\n", p);
-	early_cachepolicy(&p);
+	early_cachepolicy(p);
+	return 0;
 }
-__early_param("nocache", early_nocache);
+early_param("nocache", early_nocache);
 
-static void __init early_nowrite(char **__unused)
+static int __init early_nowrite(char *__unused)
 {
 	char *p = "uncached";
 	printk(KERN_WARNING "nowb is deprecated; use cachepolicy=%s\n", p);
-	early_cachepolicy(&p);
+	early_cachepolicy(p);
+	return 0;
 }
-__early_param("nowb", early_nowrite);
+early_param("nowb", early_nowrite);
 
-static void __init early_ecc(char **p)
+static int __init early_ecc(char *p)
 {
-	if (memcmp(*p, "on", 2) == 0) {
+	if (memcmp(p, "on", 2) == 0)
 		ecc_mask = PMD_PROTECTION;
-		*p += 2;
-	} else if (memcmp(*p, "off", 3) == 0) {
+	else if (memcmp(p, "off", 3) == 0)
 		ecc_mask = 0;
-		*p += 3;
-	}
+	return 0;
 }
-__early_param("ecc=", early_ecc);
+early_param("ecc", early_ecc);
 
 static int __init noalign_setup(char *__unused)
 {
@@ -671,9 +671,9 @@ static unsigned long __initdata vmalloc_reserve = SZ_128M;
  * bytes. This can be used to increase (or decrease) the vmalloc
  * area - the default is 128m.
  */
-static void __init early_vmalloc(char **arg)
+static int __init early_vmalloc(char *arg)
 {
-	vmalloc_reserve = memparse(*arg, arg);
+	vmalloc_reserve = memparse(arg, NULL);
 
 	if (vmalloc_reserve < SZ_16M) {
 		vmalloc_reserve = SZ_16M;
@@ -688,8 +688,9 @@ static void __init early_vmalloc(char **arg)
 			"vmalloc area is too big, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
+	return 0;
 }
-__early_param("vmalloc=", early_vmalloc);
+early_param("vmalloc", early_vmalloc);
 
 #define VMALLOC_MIN	(void *)(VMALLOC_END - vmalloc_reserve)
 
