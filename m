From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:41 +0100
Subject: [PATCH 13/51] ARM: mach-integrator: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-14-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-integrator to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-integrator/core.c                |   11 +++++++++++
 arch/arm/mach-integrator/include/mach/system.h |    5 -----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 77315b9..86f09cb 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -149,6 +149,15 @@ void __init integrator_init_early(void)
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 }
 
+static void integrator_arch_reset(char mode, const char *cmd)
+{
+	/*
+	 * To reset, we hit the on-board reset register
+	 * in the system FPGA
+	 */
+	cm_control(CM_CTRL_RESET, CM_CTRL_RESET);
+}
+
 static int __init integrator_init(void)
 {
 	int i;
@@ -158,6 +167,8 @@ static int __init integrator_init(void)
 		amba_device_register(d, &iomem_resource);
 	}
 
+	arm_arch_reset = integrator_arch_reset;
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-integrator/include/mach/system.h b/arch/arm/mach-integrator/include/mach/system.h
index e1551b8..6e5adbf 100644
--- a/arch/arm/mach-integrator/include/mach/system.h
+++ b/arch/arm/mach-integrator/include/mach/system.h
@@ -34,11 +34,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * To reset, we hit the on-board reset register
-	 * in the system FPGA
-	 */
-	cm_control(CM_CTRL_RESET, CM_CTRL_RESET);
 }
 
 #endif
-- 
1.7.4.1
