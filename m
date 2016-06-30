From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Jun 2016 06:27:50 -0700
Subject: [PATCH] ARM: OMAP2+: Fix build with CONFIG_SMP and CONFIG_PM is not
 set
Message-ID: <1467293270-7253-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found one more make randconfig build error with the recent
SMP kexec changes. We need the mpuss now always available early.

Fixes: 0573b957fc21 ("ARM: OMAP4+: Prevent CPU1 related hang
with kexec")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile              | 5 ++++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c0c0abb..5b37ec2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -78,13 +78,16 @@ obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
 endif
 
 # Power Management
+omap-4-5-pm-common			= omap-mpuss-lowpower.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
+obj-$(CONFIG_ARCH_OMAP5)		+= $(omap-4-5-pm-common)
 obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
-omap-4-5-pm-common			=  pm44xx.o omap-mpuss-lowpower.o
+omap-4-5-pm-common			+= pm44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-pm-common)
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 1751517..ad98246 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -64,7 +64,7 @@
 
 static void __iomem *sar_base;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_PM) && defined(CONFIG_SMP)
 
 struct omap4_cpu_pm_info {
 	struct powerdomain *pwrdm;
-- 
2.8.1
