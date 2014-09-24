From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 24 Sep 2014 10:27:02 +0200
Subject: [PATCH v2] ARM: cacheflush: Fix v7_exit_coherency_flush exynos build
 breakage on ARMv6
Message-ID: <1411547222-677-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes build breakage of platsmp.c if ARMv6 was chosen for compile
time options (e.g. by building allmodconfig):

$ make allmodconfig
$ make
  CC      arch/arm/mach-exynos/platsmp.o
/tmp/ccdQM0Eg.s: Assembler messages:
/tmp/ccdQM0Eg.s:432: Error: selected processor does not support ARM mode `isb '
/tmp/ccdQM0Eg.s:437: Error: selected processor does not support ARM mode `isb '
/tmp/ccdQM0Eg.s:438: Error: selected processor does not support ARM mode `dsb '
make[1]: *** [arch/arm/mach-exynos/platsmp.o] Error 1

The error was introduced in commit "ARM: EXYNOS: Move code from
hotplug.c to platsmp.c".  Previously code using
v7_exit_coherency_flush() macro was built with '-march=armv7-a' flag but
this flag dissapeared during the movement.

Fix this by annotating the v7_exit_coherency_flush() asm code with
armv7-a architecture.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Mark Brown <broonie@kernel.org>
Link: http://www.spinics.net/lists/linux-samsung-soc/msg36790.html

---

Changes since v1:
1. Use armv7-a arch annotation instead replacing isb/dsb with macros.
   Suggsted by Nicolas Pitre.
---
 arch/arm/include/asm/cacheflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 79ecb4f34ffb..10e78d00a0bb 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -466,6 +466,7 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
  */
 #define v7_exit_coherency_flush(level) \
 	asm volatile( \
+	".arch	armv7-a \n\t" \
 	"stmfd	sp!, {fp, ip} \n\t" \
 	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR \n\t" \
 	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
-- 
1.9.1
