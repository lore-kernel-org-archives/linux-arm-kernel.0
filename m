From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:55 +0100
Subject: [RFC PATCH 09/10] arm64: Read system wide CPUID value
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Add an API for reading a safe CPUID value across the system

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h |    2 ++
 arch/arm64/kernel/cpuinfo.c  |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index cb25cb9..17a871d 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -177,6 +177,7 @@ struct arm64_ftr_reg {
 		.ftr_bits = &((ftr_table)[0]),		\
 	}
 
+#define read_system_cpuid(id)	read_system_reg(SYS_##id)
 /*
  * Records attributes of an individual CPU.
  */
@@ -226,4 +227,5 @@ static inline u64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 reg)
 	return ((reg >> ftrp->shift) & ftrp->mask);
 }
 
+u64 read_system_reg(enum sys_id id);
 #endif /* __ASM_CPU_H */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 9145eef..7d140f7 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -310,6 +310,15 @@ static struct arm64_ftr_reg* get_arm64_sys_reg(enum sys_id sys_id)
 	return NULL;
 }
 
+u64 read_system_reg(enum sys_id id)
+{
+	struct arm64_ftr_reg *regp = get_arm64_sys_reg(id);
+
+	/* We shouldn't get a request for an unsupported register */
+	BUG_ON(!regp);
+	return regp->sys_val;
+}
+
 static u64 arm64_ftr_set_value(struct arm64_ftr_bits *ftrp, u64 reg, u64 ftr_val)
 {
 	u64 mask = ftrp->mask << ftrp->shift;
-- 
1.7.9.5
