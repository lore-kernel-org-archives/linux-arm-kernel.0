From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:57 +0800
Subject: [PATCH 20/45] arm64: Run enable method for errata work arounds on
 late CPUs
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-21-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 55b35d070c25 upstream.

When a CPU is brought up after we have finalised the system
wide capabilities (i.e, features and errata), we make sure the
new CPU doesn't need a new errata work around which has not been
detected already. However we don't run enable() method on the new
CPU for the errata work arounds already detected. This could
cause the new CPU running without potential work arounds.
It is upto the "enable()" method to decide if this CPU should
do something about the errata.

Fixes: commit 6a6efbb45b7d95c84 ("arm64: Verify CPU errata work arounds on hotplugged CPU")
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpu_errata.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c66a673c..8de43799 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -150,15 +150,18 @@ void verify_local_cpu_errata_workarounds(void)
 {
 	const struct arm64_cpu_capabilities *caps = arm64_errata;
 
-	for (; caps->matches; caps++)
-		if (!cpus_have_cap(caps->capability) &&
-			caps->matches(caps, SCOPE_LOCAL_CPU)) {
+	for (; caps->matches; caps++) {
+		if (cpus_have_cap(caps->capability)) {
+			if (caps->enable)
+				caps->enable((void *)caps);
+		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: Requires work around for %s, not detected"
 					" at boot time\n",
 				smp_processor_id(),
 				caps->desc ? : "an erratum");
 			cpu_die_early();
 		}
+	}
 }
 
 void update_cpu_errata_workarounds(void)
-- 
2.7.4
