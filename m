From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:26:51 +0200
Subject: [PATCH 01/29] arm64: Allow checking of a CPU-local erratum
In-Reply-To: <20170416202542.GV2078@mai>
References: <20170416202542.GV2078@mai>
Message-ID: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

this_cpu_has_cap() only checks the feature array, and not the errata
one. In order to be able to check for a CPU-local erratum, allow it
to inspect the latter as well.

This is consistent with cpus_have_cap()'s behaviour, which includes
errata already.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e8..6eb77ae 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1090,20 +1090,29 @@ static void __init setup_feature_capabilities(void)
  * Check if the current CPU has a given feature capability.
  * Should be called from non-preemptible context.
  */
-bool this_cpu_has_cap(unsigned int cap)
+static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
+			       unsigned int cap)
 {
 	const struct arm64_cpu_capabilities *caps;
 
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = arm64_features; caps->desc; caps++)
+	for (caps = cap_array; caps->desc; caps++)
 		if (caps->capability == cap && caps->matches)
 			return caps->matches(caps, SCOPE_LOCAL_CPU);
 
 	return false;
 }
 
+extern const struct arm64_cpu_capabilities arm64_errata[];
+
+bool this_cpu_has_cap(unsigned int cap)
+{
+	return (__this_cpu_has_cap(arm64_features, cap) ||
+		__this_cpu_has_cap(arm64_errata, cap));
+}
+
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-- 
2.7.4
