From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Dec 2013 22:04:36 +0100
Subject: [PATCH 2/4] arm64: Add hwcaps for crypto and CRC32 extensions.
In-Reply-To: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1387227878-30438-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@linaro.org>

Advertise the optional cryptographic and CRC32 instructions to
user space where present. Several hwcap bits [3-7] are allocated.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
[bit 2 is taken now so use bits 3-7 instead]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/uapi/asm/hwcap.h |  6 +++++-
 arch/arm64/kernel/setup.c           | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 9b12476..73cf0f5 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -22,6 +22,10 @@
 #define HWCAP_FP		(1 << 0)
 #define HWCAP_ASIMD		(1 << 1)
 #define HWCAP_EVTSTRM		(1 << 2)
-
+#define HWCAP_AES		(1 << 3)
+#define HWCAP_PMULL		(1 << 4)
+#define HWCAP_SHA1		(1 << 5)
+#define HWCAP_SHA2		(1 << 6)
+#define HWCAP_CRC32		(1 << 7)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0bc5e4c..961c961 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -116,6 +116,7 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 static void __init setup_processor(void)
 {
 	struct cpu_info *cpu_info;
+	u64 features, block;
 
 	/*
 	 * locate processor in the list of supported processor
@@ -136,6 +137,37 @@ static void __init setup_processor(void)
 
 	sprintf(init_utsname()->machine, ELF_PLATFORM);
 	elf_hwcap = 0;
+
+	/*
+	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
+	 * The blocks we test below represent incremental functionality
+	 * for non-negative values. Negative values are reserved.
+	 */
+	features = read_cpuid(ID_AA64ISAR0_EL1);
+	block = (features >> 4) & 0xf;
+	if (!(block & 0x8)) {
+		switch (block) {
+		default:
+		case 2:
+			elf_hwcap |= HWCAP_PMULL;
+		case 1:
+			elf_hwcap |= HWCAP_AES;
+		case 0:
+			break;
+		}
+	}
+
+	block = (features >> 8) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap |= HWCAP_SHA1;
+
+	block = (features >> 12) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap |= HWCAP_SHA2;
+
+	block = (features >> 16) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap |= HWCAP_CRC32;
 }
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
@@ -270,6 +302,11 @@ static const char *hwcap_str[] = {
 	"fp",
 	"asimd",
 	"evtstrm",
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
 	NULL
 };
 
-- 
1.8.3.2
