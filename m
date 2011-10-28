From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:55 +0100
Subject: [PATCH 27/51] ARM: mach-mxs: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-28-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-mxs to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-mxs/include/mach/system.h |    4 +++-
 arch/arm/mach-mxs/system.c              |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/system.h b/arch/arm/mach-mxs/include/mach/system.h
index 0e42823..bcd8989 100644
--- a/arch/arm/mach-mxs/include/mach/system.h
+++ b/arch/arm/mach-mxs/include/mach/system.h
@@ -22,6 +22,8 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-void arch_reset(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 #endif /* __MACH_MXS_SYSTEM_H__ */
diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
index 20ec3bd..add6428 100644
--- a/arch/arm/mach-mxs/system.c
+++ b/arch/arm/mach-mxs/system.c
@@ -42,7 +42,7 @@ static void __iomem *mxs_clkctrl_reset_addr;
 /*
  * Reset the system. It is called by machine_restart().
  */
-void arch_reset(char mode, const char *cmd)
+static void mxs_arch_reset(char mode, const char *cmd)
 {
 	/* reset the chip */
 	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, mxs_clkctrl_reset_addr);
@@ -68,6 +68,8 @@ static int __init mxs_arch_reset_init(void)
 	if (!IS_ERR(clk))
 		clk_enable(clk);
 
+	arm_arch_reset = mxs_arch_reset;
+
 	return 0;
 }
 core_initcall(mxs_arch_reset_init);
-- 
1.7.4.1
