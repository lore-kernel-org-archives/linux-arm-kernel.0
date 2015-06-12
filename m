From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Jun 2015 12:06:36 +0100
Subject: [PATCH 1/2] arm64: alternative: Introduce feature for GICv3 CPU
 interface
In-Reply-To: <1434107197-4919-1-git-send-email-marc.zyngier@arm.com>
References: <1434107197-4919-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1434107197-4919-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new item to the feature set (ARM64_HAS_SYSREG_GIC_CPUIF)
to indicate that we have a system register GIC CPU interface

This will help KVM switching to alternative instruction patching.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  8 +++++++-
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 82cb9f9..c104421 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -24,8 +24,9 @@
 #define ARM64_WORKAROUND_CLEAN_CACHE		0
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
 #define ARM64_WORKAROUND_845719			2
+#define ARM64_HAS_SYSREG_GIC_CPUIF		3
 
-#define ARM64_NCAPS				3
+#define ARM64_NCAPS				4
 
 #ifndef __ASSEMBLY__
 
@@ -38,6 +39,11 @@ struct arm64_cpu_capabilities {
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
index 3d9967e..5ad86ce 100644
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
+		.desc = "GIC system register CPU interface",
+		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
+		.matches = has_id_aa64pfr0_feature,
+		.register_mask = (0xf << 24),
+		.register_value = (1 << 24),
+	},
 	{},
 };
 
-- 
2.1.4
