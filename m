From: rric@kernel.org (Robert Richter)
Date: Fri, 14 Aug 2015 15:18:40 +0200
Subject: [PATCH v3 6/6] arm64: errata: Match all cpus if capability value is
 zero
In-Reply-To: <1439558320-5777-1-git-send-email-rric@kernel.org>
References: <1439558320-5777-1-git-send-email-rric@kernel.org>
Message-ID: <1439558320-5777-7-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch make caps usable optionally. If its value is zero, then all
cpus are matched. E.g. if caps resides in a stuct for marking it
dependend on a certain cpu feature/errata, then an empty value will
indicate not to use caps detection. An empty value will match all cpus
and thus just skip the cpu feature test.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/include/asm/cpufeature.h | 17 +++++++++++------
 drivers/irqchip/irq-gic-common.c    |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 2a5e4c163ee5..a5f8a007d982 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -21,13 +21,15 @@
 #define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
 #define cpu_feature(x)		ilog2(HWCAP_ ## x)
 
-#define ARM64_WORKAROUND_CLEAN_CACHE		0
-#define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
-#define ARM64_WORKAROUND_845719			2
-#define ARM64_HAS_SYSREG_GIC_CPUIF		3
-#define ARM64_WORKAROUND_CAVIUM_23154		4
+/* reserve zero to match all cpus for use of caps in empty structs */
+#define ARM64_ALL_CPUS				0
+#define ARM64_WORKAROUND_CLEAN_CACHE		1
+#define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	2
+#define ARM64_WORKAROUND_845719			3
+#define ARM64_HAS_SYSREG_GIC_CPUIF		4
+#define ARM64_WORKAROUND_CAVIUM_23154		5
 
-#define ARM64_NCAPS				5
+#define ARM64_NCAPS				6
 
 #ifndef __ASSEMBLY__
 
@@ -57,6 +59,9 @@ static inline bool cpu_have_feature(unsigned int num)
 
 static inline bool cpus_have_cap(unsigned int num)
 {
+	/* zero matches for all cpus */
+	if (!num)
+		return true;
 	if (num >= ARM64_NCAPS)
 		return false;
 	return test_bit(num, cpu_hwcaps);
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index f5e901a62ea5..cb55aaf960bb 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -25,7 +25,7 @@ void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
 			void *data)
 {
 	for (; cap->desc; cap++) {
-		if (cap->cpu_cap && !cpus_have_cap(cap->cpu_cap))
+		if (!cpus_have_cap(cap->cpu_cap))
 			continue;
 		if (cap->iidr != (cap->mask & iidr))
 			continue;
-- 
2.1.1
