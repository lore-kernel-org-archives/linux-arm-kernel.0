From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Dec 2013 22:04:38 +0100
Subject: [PATCH 4/4] arm64: add 32-bit compat hwcaps for v8 crypto extensions
In-Reply-To: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1387227878-30438-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv8 Crypto Extensions may also be available to userland
processes running in 32-bit mode. Allocate the compat bits and
set them at boot.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/hwcap.h |  6 ++++++
 arch/arm64/kernel/setup.c      | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 6cddbb0..4ae8c69 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -31,6 +31,12 @@
 #define COMPAT_HWCAP_IDIVT	(1 << 18)
 #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
 #define COMPAT_HWCAP_EVTSTRM	(1 << 21)
+#define COMPAT_HWCAP_EVTSTRM	(1 << 21)
+#define COMPAT_HWCAP_AES	(1 << 22)
+#define COMPAT_HWCAP_PMULL	(1 << 23)
+#define COMPAT_HWCAP_SHA1	(1 << 24)
+#define COMPAT_HWCAP_SHA2	(1 << 25)
+#define COMPAT_HWCAP_CRC32	(1 << 26)
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 961c961..283039d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -168,6 +168,38 @@ static void __init setup_processor(void)
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
+			compat_elf_hwcap |= COMPAT_HWCAP_PMULL;
+		case 1:
+			compat_elf_hwcap |= COMPAT_HWCAP_AES;
+		case 0:
+			break;
+		}
+	}
+
+	block = (features >> 8) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap |= COMPAT_HWCAP_SHA1;
+
+	block = (features >> 12) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap |= COMPAT_HWCAP_SHA2;
+
+	block = (features >> 16) & 0xf;
+	if (block && !(block & 0x8))
+		compat_elf_hwcap |= COMPAT_HWCAP_CRC32;
+#endif
 }
 
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
-- 
1.8.3.2
