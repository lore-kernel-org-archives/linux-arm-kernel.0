From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:54 +0100
Subject: [PATCH 26/51] ARM: mach-msm: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-27-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-msm to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-msm/include/mach/system.h |    6 ------
 arch/arm/mach-msm/smd.c                 |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index d2e83f4..ab6590b 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -19,10 +19,4 @@ void arch_idle(void);
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	for (;;) ;  /* depends on IPC w/ other core */
 }
-
-/* low level hardware reset hook -- for example, hitting the
- * PSHOLD line on the PMIC to hard reset the system
- */
-extern void (*msm_hw_reset_hook)(void);
diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
index 657be73..4f0e919 100644
--- a/arch/arm/mach-msm/smd.c
+++ b/arch/arm/mach-msm/smd.c
@@ -1029,8 +1029,14 @@ static struct platform_driver msm_smd_driver = {
 	},
 };
 
+static void msm_arch_reset(char mode, const char *cmd)
+{
+	for (;;) ;  /* depends on IPC w/ other core */
+}
+
 static int __init msm_smd_init(void)
 {
+	arm_arch_reset = msm_arch_reset;
 	return platform_driver_register(&msm_smd_driver);
 }
 
-- 
1.7.4.1
