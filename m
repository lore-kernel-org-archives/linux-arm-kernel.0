From: james.morse@arm.com (James Morse)
Date: Fri,  5 Feb 2016 14:58:49 +0000
Subject: [PATCH v2 4/5] arm64: cpufeature: Test 'matches' pointer to find the
 end of the list
In-Reply-To: <1454684330-892-1-git-send-email-james.morse@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
Message-ID: <1454684330-892-5-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU feature code uses the desc field as a test to find the end of the list,
this means every entry must have a description. This generates noise for
entries in the list that aren't really features, but combinations of them.
e.g.
> CPU features: detected feature: Privileged Access Never
> CPU features: detected feature: PAN and not UAO

These combination features are needed for corner cases with alternatives,
where cpu features interact.

Change all walkers of the arm64_features[] and arm64_hwcaps[] lists to test
'matches' not 'desc', and only print 'desc' if it is non-NULL.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 06bdcd019bd6..c717c3d78f5e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -754,7 +754,7 @@ static void __init setup_cpu_hwcaps(void)
 	int i;
 	const struct arm64_cpu_capabilities *hwcaps = arm64_hwcaps;
 
-	for (i = 0; hwcaps[i].desc; i++)
+	for (i = 0; hwcaps[i].matches; i++)
 		if (hwcaps[i].matches(&hwcaps[i]))
 			cap_set_hwcap(&hwcaps[i]);
 }
@@ -764,11 +764,11 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 {
 	int i;
 
-	for (i = 0; caps[i].desc; i++) {
+	for (i = 0; caps[i].matches; i++) {
 		if (!caps[i].matches(&caps[i]))
 			continue;
 
-		if (!cpus_have_cap(caps[i].capability))
+		if (!cpus_have_cap(caps[i].capability) && caps[i].desc)
 			pr_info("%s %s\n", info, caps[i].desc);
 		cpus_set_cap(caps[i].capability);
 	}
@@ -783,7 +783,7 @@ enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	int i;
 
-	for (i = 0; caps[i].desc; i++)
+	for (i = 0; caps[i].matches; i++)
 		if (caps[i].enable && cpus_have_cap(caps[i].capability))
 			on_each_cpu(caps[i].enable, NULL, true);
 }
@@ -890,7 +890,7 @@ void verify_local_cpu_capabilities(void)
 		return;
 
 	caps = arm64_features;
-	for (i = 0; caps[i].desc; i++) {
+	for (i = 0; caps[i].matches; i++) {
 		if (!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
 			continue;
 		/*
@@ -903,7 +903,7 @@ void verify_local_cpu_capabilities(void)
 			caps[i].enable(NULL);
 	}
 
-	for (i = 0, caps = arm64_hwcaps; caps[i].desc; i++) {
+	for (i = 0, caps = arm64_hwcaps; caps[i].matches; i++) {
 		if (!cpus_have_hwcap(&caps[i]))
 			continue;
 		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i]))
-- 
2.6.2
