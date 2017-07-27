From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Jul 2017 10:37:26 +0100
Subject: [PATCH 2/2] clocksource/arm_arch_timer: Use
 static_branch_enable_nolock()
In-Reply-To: <20170727093726.30266-1-marc.zyngier@arm.com>
References: <20170727093726.30266-1-marc.zyngier@arm.com>
Message-ID: <20170727093726.30266-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new static_branch_enable_nolock function to switch
the workaround static key on the CPU hotplug path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aae87c4c546e..4f41acf59072 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -455,7 +455,11 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
 	}
 
-	static_branch_enable(&arch_timer_read_ool_enabled);
+	/*
+	 * Use the _nolock version, as we're called from the CPU
+	 * hotplug framework. Otherwise, we end-up in deadlock-land.
+	 */
+	static_branch_enable_nolock(&arch_timer_read_ool_enabled);
 
 	/*
 	 * Don't use the vdso fastpath if errata require using the
-- 
2.11.0
