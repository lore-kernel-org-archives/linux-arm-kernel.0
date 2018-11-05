From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 14:54:31 -0800
Subject: [PATCH v4 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
Message-ID: <20181105225431.24485-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARC, ARM, ARM64 and Unicore32 are all capable of parsing the "initrd="
command line parameter to allow specifying the physical address and size
of an initrd. Move that parsing into init/do_mounts_initrd.c such that
we no longer duplicate that logic.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arc/mm/init.c       | 25 +++++--------------------
 arch/arm/mm/init.c       | 17 -----------------
 arch/arm64/mm/init.c     | 18 ------------------
 arch/unicore32/mm/init.c | 18 ------------------
 init/do_mounts_initrd.c  | 17 +++++++++++++++++
 5 files changed, 22 insertions(+), 73 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index f8fe5668b30f..43bf4c3a1290 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -78,24 +78,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 		base, TO_MB(size), !in_use ? "Not used":"");
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(start + size);
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 /*
  * First memory setup routine called from setup_arch()
  * 1. setup swapper's mm @init_mm
@@ -140,8 +122,11 @@ void __init setup_arch_memory(void)
 	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
+	if (phys_initrd_size) {
+		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		initrd_start = (unsigned long)__va(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
+	}
 #endif
 
 	early_init_fdt_reserve_self();
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a3b6f1f1cbaf..478ea8b7db87 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -51,23 +51,6 @@ unsigned long __init __clear_cr(unsigned long mask)
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	phys_addr_t start;
-	unsigned long size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-
 static int __init parse_tag_initrd(const struct tag *tag)
 {
 	pr_warn("ATAG_INITRD is deprecated; "
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a66ffcde5f13..7474093363bc 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,24 +61,6 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 02aa2c0b295e..85ef2c624090 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -30,24 +30,6 @@
 
 #include "mm.h"
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 /*
  * This keeps memory configuration data used by a couple memory
  * initialization functions, as well as show_mem() for the skipping
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 45865b72f4ea..732d21f4a637 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -27,6 +27,23 @@ static int __init no_initrd(char *str)
 
 __setup("noinitrd", no_initrd);
 
+static int __init early_initrd(char *p)
+{
+	phys_addr_t start;
+	unsigned long size;
+	char *endp;
+
+	start = memparse(p, &endp);
+	if (*endp == ',') {
+		size = memparse(endp + 1, NULL);
+
+		phys_initrd_start = start;
+		phys_initrd_size = size;
+	}
+	return 0;
+}
+early_param("initrd", early_initrd);
+
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
-- 
2.17.1
