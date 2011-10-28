From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:11 +0100
Subject: [PATCH 43/51] ARM: mach-versatile: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-44-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-versatile to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-versatile/core.c                |   14 ++++++++++++++
 arch/arm/mach-versatile/include/mach/system.h |    8 --------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e340a54..5d97b6e 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -756,6 +756,18 @@ void __init versatile_init_early(void)
 	versatile_sched_clock_init(sys + VERSATILE_SYS_24MHz_OFFSET, 24000000);
 }
 
+static void versatile_arch_reset(char mode, const char *cmd)
+{
+	u32 val;
+
+	val = __raw_readl(IO_ADDRESS(VERSATILE_SYS_RESETCTL)) & ~0x7;
+	val |= 0x105;
+
+	__raw_writel(0xa05f, IO_ADDRESS(VERSATILE_SYS_LOCK));
+	__raw_writel(val, IO_ADDRESS(VERSATILE_SYS_RESETCTL));
+	__raw_writel(0, IO_ADDRESS(VERSATILE_SYS_LOCK));
+}
+
 void __init versatile_init(void)
 {
 	int i;
@@ -773,6 +785,8 @@ void __init versatile_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = versatile_leds_event;
 #endif
+
+	arm_arch_reset = versatile_arch_reset;
 }
 
 /*
diff --git a/arch/arm/mach-versatile/include/mach/system.h b/arch/arm/mach-versatile/include/mach/system.h
index 8ffc12a..ebc6348 100644
--- a/arch/arm/mach-versatile/include/mach/system.h
+++ b/arch/arm/mach-versatile/include/mach/system.h
@@ -36,14 +36,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	u32 val;
-
-	val = __raw_readl(IO_ADDRESS(VERSATILE_SYS_RESETCTL)) & ~0x7;
-	val |= 0x105;
-
-	__raw_writel(0xa05f, IO_ADDRESS(VERSATILE_SYS_LOCK));
-	__raw_writel(val, IO_ADDRESS(VERSATILE_SYS_RESETCTL));
-	__raw_writel(0, IO_ADDRESS(VERSATILE_SYS_LOCK));
 }
 
 #endif
-- 
1.7.4.1
