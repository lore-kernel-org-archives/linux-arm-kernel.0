From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:34 +0100
Subject: [PATCH 06/51] ARM: mach-davinci: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-davinci to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-davinci/common.c              |    8 ++++++++
 arch/arm/mach-davinci/include/mach/system.h |    2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 1d25573..b0b1560 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -71,6 +71,12 @@ static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 	return -EINVAL;
 }
 
+static void davinci_arch_reset(char mode, const char *cmd)
+{
+	if (davinci_soc_info.reset)
+		davinci_soc_info.reset(davinci_soc_info.reset_device);
+}
+
 void __init davinci_common_init(struct davinci_soc_info *soc_info)
 {
 	int ret;
@@ -97,6 +103,8 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 	if (!davinci_soc_info.reset)
 		davinci_soc_info.reset = davinci_watchdog_reset;
 
+	arm_arch_reset = davinci_arch_reset;
+
 	/*
 	 * We want to check CPU revision early for cpu_is_xxxx() macros.
 	 * IO space mapping must be initialized before we can do that.
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index e65629c..6bd1dc0 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -20,8 +20,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (davinci_soc_info.reset)
-		davinci_soc_info.reset(davinci_soc_info.reset_device);
 }
 
 #endif /* __ASM_ARCH_SYSTEM_H */
-- 
1.7.4.1
