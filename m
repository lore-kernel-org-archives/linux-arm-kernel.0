From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:26:54 +0200
Subject: [PATCH 04/29] arm64: cpu_errata: Allow an erratum to be match for all
 revisions of a core
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Some minor erratum may not be fixed in further revisions of a core,
leading to a situation where the workaround needs to be updated each
time an updated core is released.

Introduce a MIDR_ALL_VERSIONS match helper that will work for all
versions of that MIDR, once and for all.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f6cc67e..2be1d1c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -53,6 +53,13 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 	.midr_range_min = min, \
 	.midr_range_max = max
 
+#define MIDR_ALL_VERSIONS(model) \
+	.def_scope = SCOPE_LOCAL_CPU, \
+	.matches = is_affected_midr_range, \
+	.midr_model = model, \
+	.midr_range_min = 0, \
+	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
-- 
2.7.4
