From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 16:50:55 -0600
Subject: [PATCH 3/3] ARM: tegra: make sure the pointer on 4 byte align when
 THUMB2_KERNEL enabled
In-Reply-To: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
References: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1366066255-18192-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

When building kernel with CONFIG_THUMB2_KERNEL, the data pointer in the
assembly may not on the 4 byte alignment. Then causing a data abort when
accessing the pointer. This patch add a ".align" flag in the head of the
pointer. And always using 32-bit ADR Thumb instruction to make sure it
won't build failure.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S |    1 +
 arch/arm/mach-tegra/sleep.h         |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index e6de88a..519a8c5 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -83,6 +83,7 @@ ENDPROC(tegra_resume)
 
 #ifdef CONFIG_CACHE_L2X0
 	.globl	l2x0_saved_regs_addr
+	.align
 l2x0_saved_regs_addr:
 	.long	0
 #endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 4ffae54..8e9b6af 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -92,7 +92,8 @@
 
 #ifdef CONFIG_CACHE_L2X0
 .macro l2_cache_resume, tmp1, tmp2, tmp3, phys_l2x0_saved_regs
-	adr	\tmp1, \phys_l2x0_saved_regs
+ ARM(	adr	\tmp1, \phys_l2x0_saved_regs )
+ THUMB(	adr.w	\tmp1, \phys_l2x0_saved_regs )
 	ldr	\tmp1, [\tmp1]
 	ldr	\tmp2, [\tmp1, #L2X0_R_PHY_BASE]
 	ldr	\tmp3, [\tmp2, #L2X0_CTRL]
-- 
1.7.10.4
