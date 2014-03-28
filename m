From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:14:29 +0000
Subject: [PATCH 02/75] ARM: l2c: remove unnecessary call to outer_flush_all()
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYUH-0004W1-Kq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

outer_disable() is defined to safely turn the L2 cache off without data
loss: this means that outer_flush_all() should never be called unless
you need to implement some special L2 cache disabling, and even then
only from your replacement L2 cache disable function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-prima2/pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index c4525a88e5da..96e9bc102117 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -71,7 +71,6 @@ static int sirfsoc_pm_enter(suspend_state_t state)
 	case PM_SUSPEND_MEM:
 		sirfsoc_pre_suspend_power_off();
 
-		outer_flush_all();
 		outer_disable();
 		/* go zzz */
 		cpu_suspend(0, sirfsoc_finish_suspend);
-- 
1.8.3.1
