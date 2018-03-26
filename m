From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Mar 2018 15:12:36 +0100
Subject: [PATCH v5 09/22] arm64: capabilities: Split the processing of errata
 work arounds
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1522073569-29174-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we run through the errata workarounds check on all boot
active CPUs, with SCOPE_ALL. This wouldn't help for detecting erratum
workarounds with a SYSTEM_SCOPE. There are none yet, but we plan to
introduce some: let us clean this up so that such workarounds can be
detected and enabled correctly.

So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
checks are run only once after all the boot time CPUs are active.

Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 703215f..b8d23f4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -560,7 +560,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 				"enabling workaround for");
 }
 
@@ -1452,7 +1452,7 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 					"enabling workaround for");
 	else
 		verify_local_cpu_capabilities();
@@ -1480,6 +1480,8 @@ void __init setup_cpu_features(void)
 
 	/* Set the CPU feature capabilies */
 	update_cpu_capabilities(arm64_features, SCOPE_ALL, "detected:");
+	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
+				"enabling workaround for");
 	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
 	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
 	mark_const_caps_ready();
-- 
2.7.4
