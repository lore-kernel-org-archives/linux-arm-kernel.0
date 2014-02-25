From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Feb 2014 13:38:59 +0100
Subject: [PATCH resend 3/3] arm64: advertise ARMv8 extensions to 32-bit compat
 ELF binaries
In-Reply-To: <1393331939-31289-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1393331939-31289-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1393331939-31289-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for advertising the presence of ARMv8 Crypto
Extensions in the Aarch32 execution state to 32-bit ELF binaries
running in 32-bit compat mode under the arm64 kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/hwcap.h |  6 ++++++
 arch/arm64/kernel/setup.c      | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 9a4cbd60c88e..024c46183c3c 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -32,6 +32,12 @@
 #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
 #define COMPAT_HWCAP_EVTSTRM	(1 << 21)
 
+#define COMPAT_HWCAP2_AES	(1 << 0)
+#define COMPAT_HWCAP2_PMULL	(1 << 1)
+#define COMPAT_HWCAP2_SHA1	(1 << 2)
+#define COMPAT_HWCAP2_SHA2	(1 << 3)
+#define COMPAT_HWCAP2_CRC32	(1 << 4)
+
 #ifndef __ASSEMBLY__
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 349c49260f09..67da30741a1b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -243,6 +243,38 @@ static void __init setup_processor(void)
 	block = (features >> 16) & 0xf;
 	if (block && !(block & 0x8))
 		elf_hwcap |= HWCAP_CRC32;
+
+#ifdef CONFIG_COMPAT
+	/*
+	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
+	 * the Aarch32 32-bit execution state.
+	 */
+	features = read_cpuid(ID_ISAR5_EL1);
+	block = (features >> 4) & 0xf;
+	if (!(block & 0x8)) {
+		switch (block) {
+		default:
+		case 2:
+			compat_elf_hwcap2 |= COMPAT_HWCAP2_PMULL;
+		case 1:
+			compat_elf_hwcap2 |= COMPAT_HWCAP2_AES;
+		case 0:
+			break;
+		}
+	}
+
+	block = (features >> 8) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA1;
+
+	block = (features >> 12) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_SHA2;
+
+	block = (features >> 16) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap2 |= COMPAT_HWCAP2_CRC32;
+#endif
 }
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
-- 
1.8.3.2
