From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Aug 2011 15:19:00 +0100
Subject: [PATCH] ARM: Add safe diagnostic to indicate when __cpu_architecture
	isn't set up
Message-ID: <1313504340-28004-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although assing BUG() when __cpu_architecture is unexpectedly
CPU_ARCH_UNKNOWN seems like a good idea, in practice the kernel may
not be able to boot far enough even to write to the console in such
cases, even with earlyprintk enabled.

This patch adds a more useful diagnostic, and works out the cpu
architecture from scratch in such cases, instead of just returning
CPU_ARCH_UNKNOWN to the caller.

This patch is useful for debugging, but I'm not convinced it should
be merged.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/system.h |    9 +++++++--
 arch/arm/kernel/setup.c       |    2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index b0445f7..d679d2f 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -110,8 +110,13 @@ extern int __cpu_architecture;
 
 static inline int __pure cpu_architecture(void)
 {
-	BUG_ON(__cpu_architecture == CPU_ARCH_UNKNOWN);
-	return __cpu_architecture;
+	if (unlikely(__cpu_architecture == CPU_ARCH_UNKNOWN)) {
+		extern int __pure __get_cpu_architecture(void);
+
+		WARN_ONCE(1, "__cpu_architecture not set yet!\n");
+		return __get_cpu_architecture();
+	} else
+		return __cpu_architecture;
 }
 
 extern void cpu_init(void);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e0c1b3..188aae5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -212,7 +212,7 @@ static const char *proc_arch[] = {
 	"?(17)",
 };
 
-static int __init __get_cpu_architecture(void)
+int __get_cpu_architecture(void)
 {
 	int cpu_arch;
 
-- 
1.7.4.1
