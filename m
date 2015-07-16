From: james.morse@arm.com (James Morse)
Date: Thu, 16 Jul 2015 17:01:57 +0100
Subject: [PATCH 3/5] arm64: kernel: Add min/max values in feature-detection
 register values.
In-Reply-To: <1437062519-18883-1-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
Message-ID: <1437062519-18883-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a new cpu feature is available, the cpu feature bits will be 0001,
when features are updated, this value will be incremented. This patch
changes 'register_value' to be '{min,max}_register_value', and checks
the value falls in this range.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 3 ++-
 arch/arm64/kernel/cpufeature.c      | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a8a201ab6cd1..680a6a1f087e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -43,7 +43,8 @@ struct arm64_cpu_capabilities {
 
 		struct {	/* Feature register checking */
 			u64 register_mask;
-			u64 register_value;
+			u64 min_register_value;
+			u64 max_register_value;
 		};
 	};
 };
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 650ffc28bedc..f260affb825c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -28,7 +28,8 @@ has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
 	u64 val;
 
 	val = read_cpuid(id_aa64pfr0_el1);
-	return (val & entry->register_mask) == entry->register_value;
+	return ((val & entry->register_mask) >= entry->min_register_value &&
+		(val & entry->register_mask) <= entry->max_register_value);
 }
 
 static const struct arm64_cpu_capabilities arm64_features[] = {
@@ -37,7 +38,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
 		.matches = has_id_aa64pfr0_feature,
 		.register_mask = (0xf << 24),
-		.register_value = (1 << 24),
+		.min_register_value = (1 << 24),
+		.max_register_value = (1 << 24),
 	},
 	{},
 };
-- 
2.1.4
