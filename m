From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  5 Mar 2015 12:51:42 +0100
Subject: [PATCH v2] ARM: advertise availability of v8 Crypto instructions
Message-ID: <1425556302-3370-1-git-send-email-ard.biesheuvel@linaro.org>
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
v2:
- drop redundant architecture check -> accessing ID_ISAR5 should be safe
  even on v7-M, and even if we don't expect to find crypto features there
- add comment regarding pmull->aes

 arch/arm/kernel/setup.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e55408e96559..482bdfa24daa 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -375,7 +375,7 @@ void __init early_print(const char *str, ...)
 
 static void __init cpuid_init_hwcaps(void)
 {
-	unsigned int divide_instrs, vmsa;
+	unsigned int divide_instrs, vmsa, isar5;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
@@ -393,6 +393,20 @@ static void __init cpuid_init_hwcaps(void)
 	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
 	if (vmsa >= 5)
 		elf_hwcap |= HWCAP_LPAE;
+
+	/* check for supported v8 Crypto instructions */
+	isar5 = read_cpuid_ext(CPUID_EXT_ISAR5);
+
+	switch ((isar5 >> 4) & 0xf) {
+	case 2:	elf_hwcap2 |= HWCAP2_PMULL;	/* pmull implies aes */
+	case 1:	elf_hwcap2 |= HWCAP2_AES;
+	}
+	if (((isar5 >> 8) & 0xf) == 1)
+		elf_hwcap2 |= HWCAP2_SHA1;
+	if (((isar5 >> 12) & 0xf) == 1)
+		elf_hwcap2 |= HWCAP2_SHA2;
+	if (((isar5 >> 16) & 0xf) == 1)
+		elf_hwcap2 |= HWCAP2_CRC32;
 }
 
 static void __init elf_hwcap_fixup(void)
-- 
1.8.3.2
