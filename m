From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  1 Aug 2017 09:02:57 +0100
Subject: [PATCH v2 4/4] clocksource/arm_arch_timer: Use
 static_branch_enable_cpuslocked()
In-Reply-To: <20170801080257.5056-1-marc.zyngier@arm.com>
References: <20170801080257.5056-1-marc.zyngier@arm.com>
Message-ID: <20170801080257.5056-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new static_branch_enable_cpuslocked function to switch
the workaround static key on the CPU hotplug path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aae87c4c546e..c62e71614c75 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -455,7 +455,11 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
 	}
 
-	static_branch_enable(&arch_timer_read_ool_enabled);
+	/*
+	 * Use the locked version, as we're called from the CPU
+	 * hotplug framework. Otherwise, we end-up in deadlock-land.
+	 */
+	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
 
 	/*
 	 * Don't use the vdso fastpath if errata require using the
-- 
2.11.0
