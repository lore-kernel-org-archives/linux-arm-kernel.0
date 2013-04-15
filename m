From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 15 Apr 2013 20:42:27 +0800
Subject: [PATCH 1/3] ARM: tegra: fix build error when THUMB2_KERNEL enabled
Message-ID: <1366029749-16476-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the build failure when CONFIG_THUBM2_KERNEL enabled. You
clould see the error message below:

arch/arm/mach-tegra/sleep-tegra30.S:69: Error: shift must be constant --
`orr r12,r12,r4,lsl r3'

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 63a15bd..d29dfcc 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -66,7 +66,9 @@ ENTRY(tegra30_cpu_shutdown)
 		FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG | \
 		FLOW_CTRL_CSR_ENABLE
 	mov	r4, #(1 << 4)
-	orr	r12, r12, r4, lsl r3
+ ARM(	orr	r12, r12, r4, lsl r3	)
+ THUMB(	lsl	r4, r4, r3		)
+ THUMB(	orr	r12, r12, r4		)
 	str	r12, [r1]
 
 	/* Halt this CPU. */
-- 
1.8.2
