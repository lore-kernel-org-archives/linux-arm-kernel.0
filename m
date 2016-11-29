From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:58 +0000
Subject: [RFC v2 PATCH 16/23] ARM: sa1100: move CPU specific copy code under
 its own config
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-17-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By now there is no way to limit sa1100 specific copy code to MMU only
builds and that leads to the following error when built for NOMMU

arch/arm/mm/copypage-v4mc.c:26:35: error: 'L_PTE_PRESENT' undeclared (first use in this function)
 #define minicache_pgprot __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | \
                                   ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
arch/arm/mm/copypage-v4mc.c:77:47: note: in expansion of macro 'minicache_pgprot'
  set_top_pte(COPYPAGE_MINICACHE, mk_pte(from, minicache_pgprot));
                                               ^
arch/arm/mm/copypage-v4mc.c:26:51: error: 'L_PTE_YOUNG' undeclared (first use in this function)
 #define minicache_pgprot __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | \
                                                   ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
arch/arm/mm/copypage-v4mc.c:77:47: note: in expansion of macro 'minicache_pgprot'
  set_top_pte(COPYPAGE_MINICACHE, mk_pte(from, minicache_pgprot));
                                               ^
arch/arm/mm/copypage-v4mc.c:27:7: error: 'L_PTE_MT_MINICACHE' undeclared (first use in this function)
       L_PTE_MT_MINICACHE)
       ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
arch/arm/mm/copypage-v4mc.c:77:47: note: in expansion of macro 'minicache_pgprot'
  set_top_pte(COPYPAGE_MINICACHE, mk_pte(from, minicache_pgprot));
                                               ^
arch/arm/mm/copypage-v4mc.c: At top level:
arch/arm/mm/copypage-v4mc.c:112:8: error: variable 'v4_mc_user_fns' has initializer but incomplete type
 struct cpu_user_fns v4_mc_user_fns __initdata = {
        ^
arch/arm/mm/copypage-v4mc.c:113:2: error: unknown field 'cpu_clear_user_highpage' specified in initializer
  .cpu_clear_user_highpage = v4_mc_clear_user_highpage,
  ^
arch/arm/mm/copypage-v4mc.c:113:2: warning: excess elements in struct initializer
arch/arm/mm/copypage-v4mc.c:113:2: warning: (near initialization for 'v4_mc_user_fns')
arch/arm/mm/copypage-v4mc.c:114:2: error: unknown field 'cpu_copy_user_highpage' specified in initializer
  .cpu_copy_user_highpage = v4_mc_copy_user_highpage,
  ^
arch/arm/mm/copypage-v4mc.c:114:2: warning: excess elements in struct initializer
arch/arm/mm/copypage-v4mc.c:114:2: warning: (near initialization for 'v4_mc_user_fns')
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mm/copypage-v4mc.o] Error 1
make: *** [arch/arm/mm] Error 2

Move that code under CPU_COPY_V4MC config option which we can guard
against NOMMU configuration.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/page.h |    2 +-
 arch/arm/mm/Kconfig         |    4 ++++
 arch/arm/mm/Makefile        |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0e..6ec7bb6 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -75,7 +75,7 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_SA1100
+#ifdef CONFIG_CPU_COPY_V4MC
 # ifdef _USER
 #  define MULTI_USER 1
 # else
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c1799dd..6dffbe4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -290,6 +290,7 @@ config CPU_SA1100
 	select CPU_ABRT_EV4
 	select CPU_CACHE_V4WB
 	select CPU_CACHE_VIVT
+	select CPU_COPY_V4MC if MMU
 	select CPU_CP15_MMU
 	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WB if MMU
@@ -524,6 +525,9 @@ config CPU_CACHE_V7M
 
 if MMU
 # The copy-page model
+config CPU_COPY_V4MC
+	bool
+
 config CPU_COPY_V4WT
 	bool
 
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index e869824..2ac7988 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -53,7 +53,7 @@ obj-$(CONFIG_CPU_COPY_V4WT)	+= copypage-v4wt.o
 obj-$(CONFIG_CPU_COPY_V4WB)	+= copypage-v4wb.o
 obj-$(CONFIG_CPU_COPY_FEROCEON)	+= copypage-feroceon.o
 obj-$(CONFIG_CPU_COPY_V6)	+= copypage-v6.o context.o
-obj-$(CONFIG_CPU_SA1100)	+= copypage-v4mc.o
+obj-$(CONFIG_CPU_COPY_V4MC)	+= copypage-v4mc.o
 obj-$(CONFIG_CPU_XSCALE)	+= copypage-xscale.o
 obj-$(CONFIG_CPU_XSC3)		+= copypage-xsc3.o
 obj-$(CONFIG_CPU_COPY_FA)	+= copypage-fa.o
-- 
1.7.9.5
