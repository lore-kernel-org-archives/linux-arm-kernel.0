From: jnair@caviumnetworks.com (Jayachandran C)
Date: Fri, 19 Jan 2018 04:22:48 -0800
Subject: [PATCH v3 2/2] arm64: Turn on KPTI only on CPUs that need it
In-Reply-To: <1516364568-95577-1-git-send-email-jnair@caviumnetworks.com>
References: <20180118135354.GB20783@arm.com>
 <1516364568-95577-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1516364568-95577-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whitelist Broadcom Vulcan/Cavium ThunderX2 processors in
unmap_kernel_at_el0(). These CPUs are not vulnerable to
CVE-2017-5754 and do not need KPTI when KASLR is off.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/kernel/cpufeature.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 647d44b..fb698ca 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -866,6 +866,13 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
+	/* Don't force KPTI for CPUs that are not vulnerable */
+	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
+	case MIDR_CAVIUM_THUNDERX2:
+	case MIDR_BRCM_VULCAN:
+		return false;
+	}
+
 	/* Defer to CPU feature registers */
 	return !cpuid_feature_extract_unsigned_field(pfr0,
 						     ID_AA64PFR0_CSV3_SHIFT);
-- 
2.7.4
