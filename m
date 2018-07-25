From: dmueller@suse.com (Dirk Mueller)
Date: Wed, 25 Jul 2018 10:35:04 +0200
Subject: [PATCH] arm64: Check for errata before evaluating cpu features
Message-ID: <20180725083504.25836-1-dmueller@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
detection to boot-time CPUs") we rely on errata flags being already
populated during feature enumeration. The order of errata and
features was flipped as part of commit ed478b3f9e4a ("arm64:
capabilities: Group handling of features and errata workarounds").

Return to the orginal order of errata and feature evaluation to
ensure errata flags are present during feature evaluation.

Fixes: d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
detection to boot-time CPUs")
CC: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Dirk Mueller <dmueller@suse.com>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f24892a40d2c..c6d80743f4ed 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1351,9 +1351,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 
 static void update_cpu_capabilities(u16 scope_mask)
 {
-	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
 	__update_cpu_capabilities(arm64_errata, scope_mask,
 				  "enabling workaround for");
+	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
 }
 
 static int __enable_cpu_capability(void *arg)
@@ -1408,8 +1408,8 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 
 static void __init enable_cpu_capabilities(u16 scope_mask)
 {
-	__enable_cpu_capabilities(arm64_features, scope_mask);
 	__enable_cpu_capabilities(arm64_errata, scope_mask);
+	__enable_cpu_capabilities(arm64_features, scope_mask);
 }
 
 /*
-- 
2.18.0
