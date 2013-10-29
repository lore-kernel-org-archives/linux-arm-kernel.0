From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 29 Oct 2013 21:10:38 +0000
Subject: [PATCH] arm64: Add hwcaps for crypto and CRC32 extensions.
Message-ID: <1383081038-3241-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise the optional cryptographic and CRC32 instructions to
user space where present. Several hwcap bits [2-6] are allocated.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/uapi/asm/hwcap.h |  6 +++++-
 arch/arm64/kernel/setup.c           | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index eea4975..2cd54ce 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -21,6 +21,10 @@
  */
 #define HWCAP_FP		(1 << 0)
 #define HWCAP_ASIMD		(1 << 1)
-
+#define HWCAP_AES		(1 << 2)
+#define HWCAP_PMULL		(1 << 3)
+#define HWCAP_SHA1		(1 << 4)
+#define HWCAP_SHA2		(1 << 5)
+#define HWCAP_CRC32		(1 << 6)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index add6ea6..d7a5f9c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -100,6 +100,7 @@ void __init early_print(const char *str, ...)
 static void __init setup_processor(void)
 {
 	struct cpu_info *cpu_info;
+	u64 features, block;
 
 	/*
 	 * locate processor in the list of supported processor
@@ -120,6 +121,37 @@ static void __init setup_processor(void)
 
 	sprintf(init_utsname()->machine, "aarch64");
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
@@ -309,6 +341,11 @@ subsys_initcall(topology_init);
 static const char *hwcap_str[] = {
 	"fp",
 	"asimd",
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
 	NULL
 };
 
-- 
1.8.1.4
