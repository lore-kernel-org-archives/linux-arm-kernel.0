From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 17 Mar 2016 18:08:03 +0800
Subject: [RFC PATCH] arm64: Expose physical/virtual address bits through
 cpuinfo
Message-ID: <1458209283-44999-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AArch64 support six types Physical Address range, permitted values
in ID_AA64MMFR0_EL1 are:
0000  32 bits, 4GB.
0001  36 bits, 64GB.
0010  40 bits, 1TB.
0011  42 bits, 4TB.
0100  44 bits, 16TB.
0101  48 bits, 256TB.
All other values are reserved.

Meanwhile, AArch64 allows 36-bit, 39-bit, 42-bit, 47-bit and 48-bit
virtual addresses.

Exposing the physical and virtual address bits to userspace through
procfs like x86, then it is easy to check them from cpuinfo.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/cpufeature.h | 11 +++++++++++
 arch/arm64/kernel/cpuinfo.c         |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a5c769b..33a9dc5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -188,6 +188,17 @@ static inline bool system_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
 }
 
+static inline int id_aa64mmfr0_parange_bits(void)
+{
+	/*
+	 * PARange[3:0] allows 0~5, other values are reserved,
+	 * convert to physical address bits with a simple formula.
+	 */
+	u32 parange = read_system_reg(SYS_ID_AA64MMFR0_EL1) & 0xf;
+
+	return parange < 3 ? 32 + parange * 4 : 42 + (parange - 3) * (parange - 2);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 212ae63..f6b49db 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -146,7 +146,9 @@ static int c_show(struct seq_file *m, void *v)
 		seq_printf(m, "CPU architecture: 8\n");
 		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
 		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
-		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
+		seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
+		seq_printf(m, "address sizes\t: %d bits physical, %d bits virtual\n\n",
+			   id_aa64mmfr0_parange_bits(), VA_BITS);
 	}
 
 	return 0;
-- 
1.7.12.4
