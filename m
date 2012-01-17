From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 16:48:52 +0000
Subject: [PATCH v2 2/2] ARM: SCU: use cpu_logical_map for per-CPU low power
 mode
In-Reply-To: <1326818932-4922-1-git-send-email-will.deacon@arm.com>
References: <1326818932-4922-1-git-send-email-will.deacon@arm.com>
Message-ID: <1326818932-4922-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scu_power_mode changes the power mode for the current CPU, which it
determines from smp_processor_id(). However, this assumes that the
physical CPU number is equal to Linux's logical CPU number and if this
is not true, we will power off the wrong CPU.

This patch uses cpu_logical_map to translate the logical CPU number
into a physical one in scu_power_mode.

Reported-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp_scu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 8f5dd79..b9f015e 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
@@ -74,7 +75,7 @@ void scu_enable(void __iomem *scu_base)
 int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 {
 	unsigned int val;
-	int cpu = smp_processor_id();
+	int cpu = cpu_logical_map(smp_processor_id());
 
 	if (mode > 3 || mode == 1 || cpu > 3)
 		return -EINVAL;
-- 
1.7.4.1
