From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 10 May 2013 11:45:26 +0530
Subject: [PATCH 1/1] ARM: mcpm: Fix build error with gic_secondary_init call
Message-ID: <1368166526-12525-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c0114709ed ("irqchip: gic: Perform the gic_secondary_init()
call via CPU notifier") removed all platform calls to gic_secondary_init.
Since this file got merged after the removal of the above call, this
function got left out in the current file which is causing the following
build error:
arch/arm/common/mcpm_platsmp.c:52:2: error: implicit declaration of function
?gic_secondary_init? [-Werror=implicit-function-declaration]
gic_secondary_init(0);

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
Compile tested only.
---
 arch/arm/common/mcpm_platsmp.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 52b88d8..3caed0d 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -15,8 +15,6 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 
-#include <linux/irqchip/arm-gic.h>
-
 #include <asm/mcpm.h>
 #include <asm/smp.h>
 #include <asm/smp_plat.h>
@@ -49,7 +47,6 @@ static int __cpuinit mcpm_boot_secondary(unsigned int cpu, struct task_struct *i
 static void __cpuinit mcpm_secondary_init(unsigned int cpu)
 {
 	mcpm_cpu_powered_up();
-	gic_secondary_init(0);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.7.9.5
