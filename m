From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 Jan 2012 10:51:31 +0100
Subject: [PATCH] ARM: GIC: fix non-SMP builds
Message-ID: <1327312291-9457-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the build break introduced by commit db0d4db22. It
happen only if SMP support has been disabled:

arch/arm/common/gic.c: In function 'gic_init_bases':
arch/arm/common/gic.c:679: error: implicit declaration of function 'cpu_logical_map'
make[1]: *** [arch/arm/common/gic.o] Error 1
make: *** [arch/arm/common] Error 2

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/common/gic.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b2dc2dd..1a29555 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -676,7 +676,10 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		}
 
 		for_each_possible_cpu(cpu) {
-			unsigned long offset = percpu_offset * cpu_logical_map(cpu);
+			unsigned long offset = 0;
+#ifdef CONFIG_SMP
+			offset = percpu_offset * cpu_logical_map(cpu);
+#endif
 			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
 			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
 		}
-- 
1.7.1.569.g6f426
