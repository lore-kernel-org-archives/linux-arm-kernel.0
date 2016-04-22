From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Apr 2016 12:25:32 +0100
Subject: [PATCH v4 2/5] arm64: Allow a capability to be checked on a single CPU
In-Reply-To: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1461324335-5081-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Now that the capabilities are only available once all the CPUs
have booted, we're unable to check for a particular feature
in any subsystem that gets initialized before then.

In order to support this, introduce a local_cpu_has_cap() function
that tests for the presence of a given capability independently
of the whole framework.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[ Added preemptible() check ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V2:
 - Check for preemptible()
---
 arch/arm64/include/asm/cpufeature.h |    2 ++
 arch/arm64/kernel/cpufeature.c      |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e501e4a..d39db63 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -109,6 +109,8 @@ struct arm64_cpu_capabilities {
 
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
+bool this_cpu_has_cap(unsigned int cap);
+
 static inline bool cpu_have_feature(unsigned int num)
 {
 	return elf_hwcap & (1UL << num);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7f9441d..79ec6c6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1005,6 +1005,24 @@ static void __init setup_feature_capabilities(void)
 	enable_cpu_capabilities(arm64_features);
 }
 
+/*
+ * Check if the current CPU has a given feature capability.
+ * Should be called from non-preemptible context.
+ */
+bool this_cpu_has_cap(unsigned int cap)
+{
+	const struct arm64_cpu_capabilities *caps = arm64_features;
+
+	if (WARN_ON(preemptible()))
+		return false;
+
+	for (caps = arm64_features; caps->desc; caps++)
+		if (caps->capability == cap && caps->matches)
+			return caps->matches(caps, SCOPE_LOCAL_CPU);
+
+	return false;
+}
+
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-- 
1.7.9.5
