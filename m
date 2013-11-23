From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:41:13 -0500
Subject: [PATCH 2/5] ARM: keystone: Make PM bus ready before populating
 platform devices
In-Reply-To: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385250076-9596-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone PM bus makes use of generic PM clock core backend. Since
generic PM clock core uses platform bus notifiers to track events like
ADD_DEVICE/DEL_DEVICE and to fill clock lists per each device, we need
to initialise Keystone PM domains before the platform devices have been
created.

Hence, fix it by moving keystone_pm_runtime_init() before platform
devices have been populated.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/keystone.c  |    1 +
 arch/arm/mach-keystone/keystone.h  |    1 +
 arch/arm/mach-keystone/pm_domain.c |    1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 2fe4dd0..6e6bb7d 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -41,6 +41,7 @@ static void __init keystone_init(void)
 	if (WARN_ON(!keystone_rstctrl))
 		pr_warn("ti,keystone-reset iomap error\n");
 
+	keystone_pm_runtime_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
index 60bef9d..cd04a1c 100644
--- a/arch/arm/mach-keystone/keystone.h
+++ b/arch/arm/mach-keystone/keystone.h
@@ -18,6 +18,7 @@
 extern struct smp_operations keystone_smp_ops;
 extern void secondary_startup(void);
 extern u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr);
+extern int keystone_pm_runtime_init(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __KEYSTONE_H__ */
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 2962523..065f2e3 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -79,4 +79,3 @@ int __init keystone_pm_runtime_init(void)
 
 	return 0;
 }
-subsys_initcall(keystone_pm_runtime_init);
-- 
1.7.9.5
