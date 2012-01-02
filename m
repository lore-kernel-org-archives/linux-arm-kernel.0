From: joerg.roedel@amd.com (Joerg Roedel)
Date: Mon, 2 Jan 2012 17:33:10 +0100
Subject: [PATCH] arm: Fix linux-next compile error in arch/arm/common/gic.c
Message-ID: <1325521990-4445-1-git-send-email-joerg.roedel@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_SMP=n the following compile error occurs:

  CC      arch/arm/common/gic.o
arch/arm/common/gic.c: In function 'gic_init_bases':
arch/arm/common/gic.c:679:4: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

This patch fixes the problem.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm/common/gic.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b2dc2dd..b33f6b0 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -676,7 +676,10 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		}
 
 		for_each_possible_cpu(cpu) {
-			unsigned long offset = percpu_offset * cpu_logical_map(cpu);
+			unsigned long offset = percpu_offset;
+#ifdef CONFIG_SMP
+			offset *= cpu_logical_map(cpu);
+#endif
 			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
 			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
 		}
-- 
1.7.5.4
