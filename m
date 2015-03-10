From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 08:54:48 +0100
Subject: [PATCH v3] ARM: advertise availability of v8 Crypto instructions
Message-ID: <1425974088-15591-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running the 32-bit ARM kernel on ARMv8 capable bare metal (e.g.,
32-bit Android userland and kernel on a Cortex-A53), or as a KVM guest
on a 64-bit host, we should advertise the availability of the Crypto
instructions, so that userland libraries such as OpenSSL may use them.
(Support for the v8 Crypto instructions in the 32-bit build was added
to OpenSSL more than six months ago)

This adds the ID feature bit detection, and sets elf_hwcap2 accordingly.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3:
- reuse logic from arm64 kernel: the feature blocks are signed quantities
  that represent incremental functionality for non-negative values.
v2:
- drop redundant architecture check -> accessing ID_ISAR5 should be safe
  even on v7-M, and even if we don't expect to find crypto features there

 arch/arm/kernel/setup.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e55408e96559..fe07efca2f12 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -375,7 +375,7 @@ void __init early_print(const char *str, ...)
 
 static void __init cpuid_init_hwcaps(void)
 {
-	unsigned int divide_instrs, vmsa;
+	unsigned int divide_instrs, vmsa, features, block;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
@@ -393,6 +393,37 @@ static void __init cpuid_init_hwcaps(void)
 	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
 	if (vmsa >= 5)
 		elf_hwcap |= HWCAP_LPAE;
+
+	/*
+	 * ID_ISAR5 contains 4-bit wide signed feature blocks.
+	 * The blocks we test below represent incremental functionality
+	 * for non-negative values. Negative values are reserved.
+	 */
+	features = read_cpuid_ext(ID_ISAR5);
+	block = (features >> 4) & 0xf;
+	if (!(block & 0x8)) {
+		switch (block) {
+		default:
+		case 2:
+			elf_hwcap2 |= HWCAP2_PMULL;
+		case 1:
+			elf_hwcap2 |= HWCAP2_AES;
+		case 0:
+			break;
+		}
+	}
+
+	block = (features >> 8) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap2 |= HWCAP2_SHA1;
+
+	block = (features >> 12) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap2 |= HWCAP2_SHA2;
+
+	block = (features >> 16) & 0xf;
+	if (block && !(block & 0x8))
+		elf_hwcap2 |= HWCAP2_CRC32;
 }
 
 static void __init elf_hwcap_fixup(void)
-- 
1.8.3.2
