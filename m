From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  9 May 2016 17:49:48 +0100
Subject: [PATCH 4/6] arm64: errata: Calling enable functions for CPU errata too
In-Reply-To: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462812590-4494-5-git-send-email-andre.przywara@arm.com>
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
index b9b6494..cb8fb2c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -174,7 +174,9 @@ void __init setup_cpu_features(void);
 
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
+void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
 void check_local_cpu_errata(void);
+void __init enable_cpu_errata(void);
 
 void verify_local_cpu_capabilities(void);
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 06afd04..64cb71d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -105,3 +105,8 @@ void check_local_cpu_errata(void)
 {
 	update_cpu_capabilities(arm64_errata, "enabling workaround for");
 }
+
+void __init enable_cpu_errata(void)
+{
+	enable_cpu_capabilities(arm64_errata);
+}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 943f514..04a324f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -835,8 +835,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init
-enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	int i;
 
@@ -974,6 +973,7 @@ void __init setup_cpu_features(void)
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
+	enable_cpu_errata();
 	setup_cpu_hwcaps();
 
 	/* Advertise that we have computed the system capabilities */
-- 
2.7.3
