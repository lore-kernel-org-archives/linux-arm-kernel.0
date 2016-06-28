From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 28 Jun 2016 18:07:30 +0100
Subject: [PATCH v2 4/6] arm64: errata: Calling enable functions for CPU errata
 too
In-Reply-To: <20160628170732.523-1-andre.przywara@arm.com>
References: <20160628170732.523-1-andre.przywara@arm.com>
Message-ID: <20160628170732.523-5-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we call the (optional) enable function for CPU _features_
only. As CPU _errata_ descriptions share the same data structure and
having an enable function is useful for errata as well (for instance
to set bits in SCTLR), lets call it when enumerating erratas too.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 ++
 arch/arm64/kernel/cpu_errata.c      | 5 +++++
 arch/arm64/kernel/cpufeature.c      | 4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 224efe7..49dd1bd 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -191,7 +191,9 @@ void __init setup_cpu_features(void);
 
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
+void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
 void check_local_cpu_errata(void);
+void __init enable_errata_workarounds(void);
 
 void verify_local_cpu_errata(void);
 void verify_local_cpu_capabilities(void);
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index d427894..c2261a7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -127,3 +127,8 @@ void check_local_cpu_errata(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
+
+void __init enable_errata_workarounds(void)
+{
+	enable_cpu_capabilities(arm64_errata);
+}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 811773d..916d27a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -913,8 +913,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init
-enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++)
 		if (caps->enable && cpus_have_cap(caps->capability))
@@ -1036,6 +1035,7 @@ void __init setup_cpu_features(void)
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
+	enable_errata_workarounds();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
-- 
2.9.0
