From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 15:20:52 +0100
Subject: [PATCH v4 2/2] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <1426688452-10804-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426688452-10804-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426688452-10804-3-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm/kernel/setup.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 637c449e6060..910bb1796946 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -376,6 +376,7 @@ void __init early_print(const char *str, ...)
 static void __init cpuid_init_hwcaps(void)
 {
 	int block;
+	u32 isar5;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
@@ -390,6 +391,27 @@ static void __init cpuid_init_hwcaps(void)
 	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
 	if (block >= 5)
 		elf_hwcap |= HWCAP_LPAE;
+
+	/* check for supported v8 Crypto instructions */
+	isar5 = read_cpuid_ext(CPUID_EXT_ISAR5);
+
+	block = cpuid_feature_extract_field(isar5, 4);
+	if (block >= 2)
+		elf_hwcap2 |= HWCAP2_PMULL;
+	if (block >= 1)
+		elf_hwcap2 |= HWCAP2_AES;
+
+	block = cpuid_feature_extract_field(isar5, 8);
+	if (block >= 1)
+		elf_hwcap2 |= HWCAP2_SHA1;
+
+	block = cpuid_feature_extract_field(isar5, 12);
+	if (block >= 1)
+		elf_hwcap2 |= HWCAP2_SHA2;
+
+	block = cpuid_feature_extract_field(isar5, 16);
+	if (block >= 1)
+		elf_hwcap2 |= HWCAP2_CRC32;
 }
 
 static void __init elf_hwcap_fixup(void)
-- 
1.8.3.2
