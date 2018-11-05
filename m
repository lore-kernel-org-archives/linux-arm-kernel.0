From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 14:54:27 -0800
Subject: [PATCH v4 2/6] arch: Make phys_initrd_start and phys_initrd_size
 global variables
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
Message-ID: <20181105225431.24485-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make phys_initrd_start and phys_initrd_size global variables declared in
init/do_mounts_initrd.c such that we can later have generic code in
drivers/of/fdt.c populate those variables for us.

This requires both the ARM and unicore32 implementations to be properly
guarded against CONFIG_BLK_DEV_INITRD, and also initialize the variables
to the expected default values (unicore32).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c       |  5 ++---
 arch/unicore32/mm/init.c | 10 +++++++---
 include/linux/initrd.h   |  3 +++
 init/do_mounts_initrd.c  |  3 +++
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 32e4845af2b6..438625764ccd 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -50,9 +50,7 @@ unsigned long __init __clear_cr(unsigned long mask)
 }
 #endif
 
-static phys_addr_t phys_initrd_start __initdata = 0;
-static unsigned long phys_initrd_size __initdata = 0;
-
+#ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
 	phys_addr_t start;
@@ -89,6 +87,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
 }
 
 __tagtable(ATAG_INITRD2, parse_tag_initrd2);
+#endif
 
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index cf4eb9481fd6..02aa2c0b295e 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -30,9 +30,7 @@
 
 #include "mm.h"
 
-static unsigned long phys_initrd_start __initdata = 0x01000000;
-static unsigned long phys_initrd_size __initdata = SZ_8M;
-
+#ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
@@ -48,6 +46,7 @@ static int __init early_initrd(char *p)
 	return 0;
 }
 early_param("initrd", early_initrd);
+#endif
 
 /*
  * This keeps memory configuration data used by a couple memory
@@ -156,6 +155,11 @@ void __init uc32_memblock_init(struct meminfo *mi)
 	memblock_reserve(__pa(_text), _end - _text);
 
 #ifdef CONFIG_BLK_DEV_INITRD
+	if (!phys_initrd_size) {
+		phys_initrd_start = 0x01000000;
+		phys_initrd_size = SZ_8M;
+	}
+
 	if (phys_initrd_size) {
 		memblock_reserve(phys_initrd_start, phys_initrd_size);
 
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 84b423044088..14beaff9b445 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -21,4 +21,7 @@ extern int initrd_below_start_ok;
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
+extern phys_addr_t phys_initrd_start;
+extern unsigned long phys_initrd_size;
+
 extern unsigned int real_root_dev;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d1a5d885ce13..45865b72f4ea 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -16,6 +16,9 @@ int initrd_below_start_ok;
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
+phys_addr_t phys_initrd_start __initdata;
+unsigned long phys_initrd_size __initdata;
+
 static int __init no_initrd(char *str)
 {
 	mount_initrd = 0;
-- 
2.17.1
