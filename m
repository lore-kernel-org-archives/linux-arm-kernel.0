From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 16:50:53 -0600
Subject: [PATCH 1/3] ARM: tegra: fix build error when THUMB2_KERNEL enabled
Message-ID: <1366066255-18192-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

This patch fix the build failure when CONFIG_THUBM2_KERNEL enabled. You
clould see the error message below:

arch/arm/mach-tegra/sleep-tegra30.S:69: Error: shift must be constant --
`orr r12,r12,r4,lsl r3'

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Arnd, Olof, here are 3 fixes from Joseph for some Tegra build issues,
mostly exposed by multi-platform enablement and/or related randconfig
testing.

Can you please apply these to arm-soc? For reference, I tested applying
them to Tegra's for-3.10/fixes branch and they apply there fine, and
merge with the other Tegra for-3.10 branches at least, without any issue.

Note: patch 3 triggers checkpatch, but I can't work out why; the code
seems to be formatted the same as patch 1 and 2, and is consistent with
other usage of ARM() and THUMB() macros in arch/arm/.

 arch/arm/mach-tegra/sleep-tegra30.S |    4 +++-
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
1.7.10.4
