From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:20:53 +0100
Subject: [PATCH] ARM: Samsung: fix missing s5p_init_cpu() declaration
Message-ID: <1466511653-9295-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The declaration of s5p_init_cpu() in arch/arm/mach-exynos/common.h
is not included in the platform file arch/arm/plat-samsung/cpu.c
which generates a warning.

Fix the following warning by moving the declaration to somewhere
both the machine and platform code can get to it, and including
the right files as necessary:

arch/arm/plat-samsung/cpu.c:47:13: warning: symbol 's5p_init_cpu' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-exynos/common.h            | 1 -
 arch/arm/mach-exynos/exynos.c            | 1 +
 arch/arm/plat-samsung/include/plat/cpu.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 5365bf1..429dda5 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -166,7 +166,6 @@ extern struct cpuidle_exynos_data cpuidle_coupled_exynos_data;
 
 extern void exynos_set_delayed_reset_assertion(bool enable);
 
-extern void s5p_init_cpu(void __iomem *cpuid_addr);
 extern unsigned int samsung_rev(void);
 extern void exynos_core_restart(u32 core_id);
 extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a8620c6..9c51b6d 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -25,6 +25,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/map.h>
+#include <plat/cpu.h>
 
 #include "common.h"
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 61d14f3..4f8a6221 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -113,6 +113,7 @@ extern void s3c_init_cpu(unsigned long idcode,
 extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
 
 extern void s3c64xx_init_cpu(void);
+extern void s5p_init_cpu(void __iomem *cpuid_addr);
 
 extern unsigned int samsung_rev(void);
 
-- 
2.8.1
