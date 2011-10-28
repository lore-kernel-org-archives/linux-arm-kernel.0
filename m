From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:33 +0100
Subject: [PATCH 05/51] ARM: cns3xxx: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-cns3xxx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-cns3xxx/cns3420vb.c           |    3 +++
 arch/arm/mach-cns3xxx/include/mach/system.h |    4 +++-
 arch/arm/mach-cns3xxx/pm.c                  |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 3e7d149..e19bda7 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -167,6 +167,8 @@ static struct platform_device *cns3420_pdevs[] __initdata = {
 	&cns3xxx_usb_ohci_device,
 };
 
+extern void cns3xxx_arch_reset(char mode, const char *cmd);
+
 static void __init cns3420_init(void)
 {
 	cns3xxx_l2x0_init();
@@ -176,6 +178,7 @@ static void __init cns3420_init(void)
 	cns3xxx_ahci_init();
 	cns3xxx_sdhci_init();
 
+	arm_arch_reset = cns3xxx_arch_reset;
 	pm_power_off = cns3xxx_power_off;
 }
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/system.h b/arch/arm/mach-cns3xxx/include/mach/system.h
index 4f16c9b..092d774 100644
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ b/arch/arm/mach-cns3xxx/include/mach/system.h
@@ -23,6 +23,8 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-void arch_reset(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 #endif
diff --git a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
index 0c04678..a3e01f9 100644
--- a/arch/arm/mach-cns3xxx/pm.c
+++ b/arch/arm/mach-cns3xxx/pm.c
@@ -89,7 +89,7 @@ void cns3xxx_pwr_soft_rst(unsigned int block)
 }
 EXPORT_SYMBOL(cns3xxx_pwr_soft_rst);
 
-void arch_reset(char mode, const char *cmd)
+void cns3xxx_arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * To reset, we hit the on-board reset register
-- 
1.7.4.1
