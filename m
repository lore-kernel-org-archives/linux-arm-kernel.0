From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  3 Aug 2012 15:42:42 -0700
Subject: [PATCH] ARM: Don't enable GENERIC_LOCKBREAK with ticket spinlocks
Message-ID: <1344033762-3296-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ARM has implemented its spinlocks with tickets we don't
need to use the generic lockbreak algorithm. Remove the Kconfig
from ARM so that we use the arch_spin_is_contended() definition
from the asm header. This also saves a word in each lock because
we don't need the break_lock member anymore.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

It seems we define the arch_spin_is_contended() macro but we don't
use it on SMP && PREEMPT kernels?

 arch/arm/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..e4191cc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -126,11 +126,6 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
-config GENERIC_LOCKBREAK
-	bool
-	default y
-	depends on SMP && PREEMPT
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
