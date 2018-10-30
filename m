From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 30 Oct 2018 16:07:21 -0700
Subject: [PATCH v2 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Message-ID: <20181030230721.28429-7-f.fainelli@gmail.com>
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
index ba145065c579..369d3d699929 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -79,24 +79,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
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
@@ -141,8 +123,11 @@ void __init setup_arch_memory(void)
 	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
+	if (phys_initrd_size) {
+		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		initrd_start = __va(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
+	}
 #endif
 
 	early_init_fdt_reserve_self();
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4bfa08e27319..58ec68709606 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -52,23 +52,6 @@ unsigned long __init __clear_cr(unsigned long mask)
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
index e95cee656a55..9045afacd10b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,24 +62,6 @@
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
index f2f815d46846..99acdb829a7e 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -31,24 +31,6 @@
 
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
