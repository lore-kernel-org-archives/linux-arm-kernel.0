From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 25 Oct 2015 16:25:59 +0100
Subject: [PATCH] arm: Test for CONFIG_USE_OF to handle the USE_OF=n/OF=y case
Message-ID: <1445786759-22005-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until commit 0166dc11be911213 ("of: make CONFIG_OF user selectable"),
CONFIG_OF=y implied CONFIG_USE_OF=y on ARM, as the former could solely
be enabled by being selected by the latter.

However, if the user now manually enables CONFIG_OF=y while
CONFIG_USE_OF=n:

    arch/arm/kernel/devtree.c: In function 'setup_machine_fdt':
    arch/arm/kernel/devtree.c:215:2: error: implicit declaration of function 'early_init_dt_verify' [-Werror=implicit-function-declaration]
      if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
      ^
    arch/arm/kernel/devtree.c:218:2: error: implicit declaration of function 'of_flat_dt_match_machine' [-Werror=implicit-function-declaration]
      mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
      ^
    arch/arm/kernel/devtree.c:218:8: warning: assignment makes pointer from integer without a cast
      mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
	    ^
    arch/arm/kernel/devtree.c:228:3: error: implicit declaration of function 'of_get_flat_dt_root' [-Werror=implicit-function-declaration]
       dt_root = of_get_flat_dt_root();
       ^
    arch/arm/kernel/devtree.c:229:3: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]
       prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
       ^
    arch/arm/kernel/devtree.c:229:8: warning: assignment makes pointer from integer without a cast
       prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
	    ^
    arch/arm/kernel/devtree.c:244:2: error: implicit declaration of function 'early_init_dt_scan_nodes' [-Werror=implicit-function-declaration]
      early_init_dt_scan_nodes();
      ^

and

    arch/arm/kernel/built-in.o: In function `setup_arch':
    arch/arm/kernel/setup.c:940: undefined reference to `setup_machine_fdt'
    arch/arm/kernel/setup.c:979: undefined reference to `arm_dt_init_cpu_maps'

Replace tests for CONFIG_OF by tests for CONFIG_USE_OF where appropriate
to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Cfr. http://kisskb.ellerman.id.au/kisskb/buildresult/12531538/

I only fixed the particular issue with the randconfig from the build
above.  Are there more tests for CONFIG_OF that should be converted to
CONFIG_USE_OF?
---
 arch/arm/include/asm/prom.h | 6 +++---
 arch/arm/kernel/Makefile    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index cd94ef2ef283e14e..aac51015d18e27fb 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -11,12 +11,12 @@
 #ifndef __ASMARM_PROM_H
 #define __ASMARM_PROM_H
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 extern const struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
 extern void __init arm_dt_init_cpu_maps(void);
 
-#else /* CONFIG_OF */
+#else /* CONFIG_USE_OF */
 
 static inline const struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
 {
@@ -25,5 +25,5 @@ static inline const struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
 
 static inline void arm_dt_init_cpu_maps(void) { }
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
 #endif /* ASMARM_PROM_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59bf3831b9fd..4f6014eee0fe65bd 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -58,7 +58,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o patch.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
-obj-$(CONFIG_OF)		+= devtree.o
+obj-$(CONFIG_USE_OF)		+= devtree.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
 CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
-- 
1.9.1
