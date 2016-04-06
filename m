From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  6 Apr 2016 12:24:13 +0100
Subject: [PATCH 4/5] arm64: Verify CPU errata work arounds on hotplugged CPU
In-Reply-To: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459941854-5190-5-git-send-email-suzuki.poulose@arm.com>
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
 arch/arm64/include/asm/cpufeature.h |    2 +-
 arch/arm64/kernel/cpu_errata.c      |   22 ++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |    1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 733b016..d5b7386 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -191,7 +191,7 @@ void __init setup_cpu_features(void);
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
-
+void verify_local_cpu_errata(void);
 void verify_local_cpu_capabilities(void);
 
 u64 read_system_reg(u32 id);
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2fd5780..d35b398 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -101,6 +101,28 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
+			caps->matches(caps, SCOPE_CPU)) {
+			int cpu = smp_processor_id();
+
+			if (caps->desc)
+				pr_crit("CPU%d: Detected - %s\n", cpu, caps->desc);
+			pr_crit("CPU%d: Requires an errata work around not detected"
+					" at boot time\n", cpu);
+			cpu_die_early();
+		}
+}
+
 void check_local_cpu_errata(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3ace45f..2f6ce1d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -983,6 +983,7 @@ void verify_local_cpu_capabilities(void)
 	if (!sys_caps_initialised)
 		return;
 
+	verify_local_cpu_errata();
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 	if (system_supports_32bit_el0())
-- 
1.7.9.5
