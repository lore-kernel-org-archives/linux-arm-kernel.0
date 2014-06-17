From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jun 2014 18:04:33 +0100
Subject: [PATCHv2 3/4] arm64: cachetype: report weakest cache policy
In-Reply-To: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1403024674-25108-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In big.LITTLE systems, the I-cache policy may differ across CPUs, and
thus we must always meet the most stringent maintenance requirements of
any I-cache in the system when performing maintenance to ensure
correctness. Unfortunately this requirement is not met as we always look
at the current CPU's cache type register to determine the maintenance
requirements.

This patch causes the I-cache policy of all CPUs to be taken into
account for icache_is_aliasing and icache_is_aivivt. If any I-cache in
the system is aliasing or AIVIVT, the respective function will return
true. At boot each CPU may set flags to identify that at least one
I-cache in the system is aliasing and/or AIVIVT.

The now unused and potentially misleading icache_policy function is
removed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cachetype.h | 16 ++++++++++------
 arch/arm64/include/asm/cpu.h       |  1 +
 arch/arm64/kernel/cpuinfo.c        | 28 +++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 4b23e75..7a2e076 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -30,10 +30,14 @@
 
 #ifndef __ASSEMBLY__
 
-static inline u32 icache_policy(void)
-{
-	return (read_cpuid_cachetype() >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK;
-}
+#include <linux/bitops.h>
+
+#define CTR_L1IP(ctr)	(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
+
+#define ICACHEF_ALIASING	BIT(0)
+#define ICACHEF_AIVIVT		BIT(1)
+
+extern unsigned long __icache_flags;
 
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
@@ -41,12 +45,12 @@ static inline u32 icache_policy(void)
  */
 static inline int icache_is_aliasing(void)
 {
-	return icache_policy() != ICACHE_POLICY_PIPT;
+	return test_bit(ICACHEF_ALIASING, &__icache_flags);
 }
 
 static inline int icache_is_aivivt(void)
 {
-	return icache_policy() == ICACHE_POLICY_AIVIVT;
+	return test_bit(ICACHEF_AIVIVT, &__icache_flags);
 }
 
 static inline u32 cache_type_cwg(void)
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 74bf9bb..daca48d 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -20,6 +20,7 @@
  */
 struct cpuinfo_arm64 {
 	struct cpu	cpu;
+	u32		reg_ctr;
 	u32		reg_midr;
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 340621d..b146148 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -14,18 +14,44 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <asm/cachetype.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 
+#include <linux/bitops.h>
+#include <linux/printk.h>
 #include <linux/smp.h>
 
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 
+static char *icache_policy_str[] = {
+	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
+	[ICACHE_POLICY_AIVIVT] = "AIVIVT",
+	[ICACHE_POLICY_VIPT] = "VIPT",
+	[ICACHE_POLICY_PIPT] = "PIPT",
+};
+
+unsigned long __icache_flags;
+
+static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info, int cpu)
+{
+	u32 l1ip = CTR_L1IP(info->reg_ctr);
+
+	if (l1ip != ICACHE_POLICY_PIPT)
+		set_bit(ICACHEF_ALIASING, &__icache_flags);
+	if (l1ip == ICACHE_POLICY_AIVIVT);
+		set_bit(ICACHEF_AIVIVT, &__icache_flags);
+
+	pr_info("Detected %s I-cache on CPU%d", icache_policy_str[l1ip], cpu);
+}
+
 void cpuinfo_store_cpu(void)
 {
 	int cpu = smp_processor_id();
 	struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, cpu);
 
+	cpuinfo->reg_ctr = read_cpuid_cachetype();
 	cpuinfo->reg_midr = read_cpuid_id();
-}
 
+	cpuinfo_detect_icache_policy(cpuinfo, cpu);
+}
-- 
1.9.1
