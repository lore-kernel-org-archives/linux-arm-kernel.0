From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Apr 2016 15:56:36 +0100
Subject: [PATCH v3 4/5] arm64: Verify CPU errata work arounds on hotplugged CPU
In-Reply-To: <1461250597-16712-1-git-send-email-suzuki.poulose@arm.com>
References: <1461250597-16712-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1461250597-16712-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU Errata work arounds are detected and applied to the
kernel code at boot time and the data is then freed up.
If a new hotplugged CPU requires a work around which
was not applied at boot time, there is nothing we can
do but simply fail the booting.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    1 +
 arch/arm64/kernel/cpu_errata.c      |   20 ++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |    1 +
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index d39db63..224efe7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -193,6 +193,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
 
+void verify_local_cpu_errata(void);
 void verify_local_cpu_capabilities(void);
 
 u64 read_system_reg(u32 id);
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2fdecd7..d427894 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -103,6 +103,26 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	}
 };
 
+/*
+ * The CPU Errata work arounds are detected and applied at boot time
+ * and the related information is freed soon after. If the new CPU requires
+ * an errata not detected at boot, fail this CPU.
+ */
+void verify_local_cpu_errata(void)
+{
+	const struct arm64_cpu_capabilities *caps = arm64_errata;
+
+	for (; caps->matches; caps++)
+		if (!cpus_have_cap(caps->capability) &&
+			caps->matches(caps, SCOPE_LOCAL_CPU)) {
+			pr_crit("CPU%d: Requires work around for %s, not detected"
+					" at boot time\n",
+				smp_processor_id(),
+				caps->desc ? : "an erratum");
+			cpu_die_early();
+		}
+}
+
 void check_local_cpu_errata(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 74e733a..5f06b65 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -993,6 +993,7 @@ void verify_local_cpu_capabilities(void)
 	if (!sys_caps_initialised)
 		return;
 
+	verify_local_cpu_errata();
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 	if (system_supports_32bit_el0())
-- 
1.7.9.5
