From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:01:58 +0100
Subject: [PATCH v2 09/22] arm64: Read system wide CPUID value
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an API for reading the safe CPUID value across the
system from the new infrastructure.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    2 ++
 arch/arm64/kernel/cpufeature.c      |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7ed92f2..2e17f9b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -145,6 +145,8 @@ void check_local_cpu_features(void);
 bool cpu_supports_mixed_endian_el0(void);
 bool system_supports_mixed_endian_el0(void);
 
+u64 read_system_reg(u32 id);
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b5dd450..a4eff72 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -594,6 +594,15 @@ void update_cpu_features(int cpu,
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
