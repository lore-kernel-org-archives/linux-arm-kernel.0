From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:37:52 +0100
Subject: [PATCH 3/5] arm64: cpufeatures: Check ICC_EL1_SRE.SRE before enabling
 ARM64_HAS_SYSREG_GIC_CPUIF
In-Reply-To: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443803874-9566-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the firmware (or the hypervisor) may have disabled SRE access,
check that SRE can actually be enabled before declaring that we
do have that capability.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3c9aed3..305f30dc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -23,6 +23,8 @@
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 
+#include <linux/irqchip/arm-gic-v3.h>
+
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
@@ -45,11 +47,26 @@ __ID_FEAT_CHK(id_aa64pfr0);
 __ID_FEAT_CHK(id_aa64mmfr1);
 __ID_FEAT_CHK(id_aa64isar0);
 
+static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
+{
+	bool has_sre;
+
+	if (!has_id_aa64pfr0_feature(entry))
+		return false;
+
+	has_sre = gic_enable_sre();
+	if (!has_sre)
+		pr_warn_once("%s present but disabled by higher exception level\n",
+			     entry->desc);
+
+	return has_sre;
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
-		.matches = has_id_aa64pfr0_feature,
+		.matches = has_useable_gicv3_cpuif,
 		.field_pos = 24,
 		.min_field_value = 1,
 	},
-- 
2.1.4
