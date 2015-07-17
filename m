From: james.morse@arm.com (James Morse)
Date: Fri, 17 Jul 2015 18:30:16 +0100
Subject: [PATCH v2 1/6] arm64: kernel: Add cpuid_feature_extract_field() for
 4bit sign extension
In-Reply-To: <1437154221-5736-1-git-send-email-james.morse@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
Message-ID: <1437154221-5736-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copied from arch/arm/include/asm/cputype.h, this function does the
shifting and sign extension necessary when accessing cpu feature fields.

Signed-off-by: James Morse <james.morse@arm.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c1044218a63a..56c843918504 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -70,6 +70,19 @@ static inline void cpus_set_cap(unsigned int num)
 		__set_bit(num, cpu_hwcaps);
 }
 
+static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
+								  int field)
+{
+	int feature = (features >> field) & 15;
+
+	/* feature registers are signed values */
+	if (feature > 8)
+		feature -= 16;
+
+	return feature;
+}
+
+
 void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
-- 
2.1.4
