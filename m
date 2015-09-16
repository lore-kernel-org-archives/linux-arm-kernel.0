From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:07 +0100
Subject: [PATCH 09/22] arm64: Read system wide CPUID value
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Add an API for reading the safe CPUID value across the
system from the new infrastructure.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    2 ++
 arch/arm64/kernel/cpufeature.c      |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7927ac2..f59e90a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -149,6 +149,8 @@ void check_local_cpu_features(void);
 bool cpu_supports_mixed_endian_el0(void);
 bool system_supports_mixed_endian_el0(void);
 
+u64 read_system_reg(u32 id);
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 960a62f..a736c13 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -593,6 +593,15 @@ void update_cpu_features(int cpu,
 	update_mixed_endian_el0_support(info);
 }
 
+u64 read_system_reg(u32 id)
+{
+	struct arm64_ftr_reg *regp = get_arm64_sys_reg(id);
+
+	/* We shouldn't get a request for an unsupported register */
+	BUG_ON(!regp);
+	return regp->sys_val;
+}
+
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
-- 
1.7.9.5
