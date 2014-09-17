From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 17 Sep 2014 20:39:34 +0100
Subject: [PATCH v2] clocksource: arm_arch_timer: discard unavailable timers
 correctly
In-Reply-To: <1410911445-19067-1-git-send-email-sudeep.holla@arm.com>
References: <1410911445-19067-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1410982774-4724-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we wait until both cp15 and mem timers are probed if we
have both timer device nodes present in the device tree without
checking if the device is actually available. If one of the timer
device node present is disabled, the system locks up on the boot
as no timer gets registered.

This patch adds the check for the availablity of the timer device
so that we unavailable timers are discarded correctly. It also adds
the missing of_node_put.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Changes v1->v2:
	- Added missing of_node_put in the original code
	- Updated the commit log as suggested

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5163ec13429d..7e267e3990ab 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -616,17 +616,29 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
 	{},
 };
 
+static bool __init
+arch_timer_probed(int type, const struct of_device_id *matches)
+{
+	struct device_node *dn;
+	bool probed = false;
+
+	dn = of_find_matching_node(NULL, matches);
+	if (dn && of_device_is_available(dn) && (arch_timers_present & type))
+		probed = true;
+	of_node_put(dn);
+
+	return probed;
+}
+
 static void __init arch_timer_common_init(void)
 {
 	unsigned mask = ARCH_CP15_TIMER | ARCH_MEM_TIMER;
 
 	/* Wait until both nodes are probed if we have two timers */
 	if ((arch_timers_present & mask) != mask) {
-		if (of_find_matching_node(NULL, arch_timer_mem_of_match) &&
-				!(arch_timers_present & ARCH_MEM_TIMER))
+		if (!arch_timer_probed(ARCH_MEM_TIMER, arch_timer_mem_of_match))
 			return;
-		if (of_find_matching_node(NULL, arch_timer_of_match) &&
-				!(arch_timers_present & ARCH_CP15_TIMER))
+		if (!arch_timer_probed(ARCH_CP15_TIMER, arch_timer_of_match))
 			return;
 	}
 
-- 
1.9.1
