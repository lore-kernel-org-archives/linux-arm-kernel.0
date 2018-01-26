From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 12:03:15 +0000
Subject: [PATCH 5/7] arm64: Force KPTI to be disabled on Cavium ThunderX
In-Reply-To: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
References: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
Message-ID: <1516968197-23206-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Cavium ThunderX's erratum 27456 results in a corruption of icache
entries that are loaded from memory that is mapped as non-global
(i.e. ASID-tagged).

As KPTI is based on memory being mapped non-global, let's prevent
it from kicking in if this erratum is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[will: Update comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index cd9f46952db3..0ff8ab79352c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -855,12 +855,23 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	char const *str = "command line option";
 	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
-	/* Forced on command line? */
+	/*
+	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
+	 * ThunderX leads to apparent I-cache corruption of kernel text, which
+	 * ends as well as you might imagine. Don't even try.
+	 */
+	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456)) {
+		str = "ARM64_WORKAROUND_CAVIUM_27456";
+		__kpti_forced = -1;
+	}
+
+	/* Forced? */
 	if (__kpti_forced) {
-		pr_info_once("kernel page table isolation forced %s by command line option\n",
-			     __kpti_forced > 0 ? "ON" : "OFF");
+		pr_info_once("kernel page table isolation forced %s by %s\n",
+			     __kpti_forced > 0 ? "ON" : "OFF", str);
 		return __kpti_forced > 0;
 	}
 
-- 
2.1.4
