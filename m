From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Mar 2015 13:59:35 +0000
Subject: [PATCH 4/5] arm64: alternative: Introduce feature for GICv3 CPU
 interface
In-Reply-To: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
References: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426773576-14062-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new item to the feature set (ARM64_HAS_SYSREG_GIC_CPUIF)
to indicate that we have a system register GIC CPU interface

This will help KVM switching to alternative instruction patching.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  8 +++++++-
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 6ae35d1..d9e57b5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -23,8 +23,9 @@
 
 #define ARM64_WORKAROUND_CLEAN_CACHE		0
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
+#define ARM64_HAS_SYSREG_GIC_CPUIF		2
 
-#define ARM64_NCAPS				2
+#define ARM64_NCAPS				3
 
 #ifndef __ASSEMBLY__
 
@@ -37,6 +38,11 @@ struct arm64_cpu_capabilities {
 			u32 midr_model;
 			u32 midr_range_min, midr_range_max;
 		};
+
+		struct {	/* Feature register checking */
+			u64 register_mask;
+			u64 register_value;
+		};
 	};
 };
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3d9967e..b0bea2b3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -22,7 +22,23 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 
+static bool
+has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
+{
+	u64 val;
+
+	val = read_cpuid(id_aa64pfr0_el1);
+	return (val & entry->register_mask) == entry->register_value;
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
+	{
+		.desc = "system register GIC CPU interface",
+		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
+		.matches = has_id_aa64pfr0_feature,
+		.register_mask = (0xf << 24),
+		.register_value = (1 << 24),
+	},
 	{},
 };
 
-- 
2.1.4
