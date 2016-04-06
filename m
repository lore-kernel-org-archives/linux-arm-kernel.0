From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  6 Apr 2016 12:24:11 +0100
Subject: [PATCH 2/5] arm64: Allow a capability to be checked on a single CPU
In-Reply-To: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459941854-5190-3-git-send-email-suzuki.poulose@arm.com>
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
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    2 ++
 arch/arm64/kernel/cpufeature.c      |   11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5f10344..733b016 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -108,6 +108,8 @@ struct arm64_cpu_capabilities {
 
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
+bool this_cpu_has_cap(unsigned int cap);
+
 static inline bool cpu_have_feature(unsigned int num)
 {
 	return elf_hwcap & (1UL << num);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d3ee1df..3ace45f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -995,6 +995,17 @@ static void __init setup_feature_capabilities(void)
 	enable_cpu_capabilities(arm64_features);
 }
 
+bool this_cpu_has_cap(unsigned int cap)
+{
+	const struct arm64_cpu_capabilities *caps = arm64_features;
+
+	for (caps = arm64_features; caps->desc; caps++)
+		if (caps->capability == cap && caps->matches)
+			return caps->matches(caps, SCOPE_CPU);
+
+	return false;
+}
+
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-- 
1.7.9.5
