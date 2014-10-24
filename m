From: js07.lee@gmail.com (Jungseung Lee)
Date: Fri, 24 Oct 2014 18:57:34 +0900
Subject: [PATCH 1/2] arm: hwcap: add new hwcap for identifying PXN bits
Message-ID: <1414144655-25204-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARMv7-A/R cores can optionally implement below new
hardware feature:

- PXN:
Privileged execute-never(PXN) is a security feature. PXN bit
determines whether the processor can execute software from
the region. This is effective solution against ret2usr attack.

This patch adds new HWCAP defines to describe new feature.
On an implementation that does not include the LPAE, PXN is
optionally supported.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/include/uapi/asm/hwcap.h | 1 +
 arch/arm/kernel/setup.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 20d12f2..a06faba 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -27,6 +27,7 @@
 #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
 #define HWCAP_LPAE	(1 << 20)
 #define HWCAP_EVTSTRM	(1 << 21)
+#define HWCAP_PXN   (1 << 22)       /* Privileged execute-never */
 
 /*
  * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c031063..48828fe 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -390,6 +390,10 @@ static void __init cpuid_init_hwcaps(void)
 
 	/* LPAE implies atomic ldrd/strd instructions */
 	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
+
+	if (vmsa >= 4)
+		elf_hwcap |= HWCAP_PXN;
+
 	if (vmsa >= 5)
 		elf_hwcap |= HWCAP_LPAE;
 }
@@ -1015,6 +1019,7 @@ static const char *hwcap_str[] = {
 	"vfpd32",
 	"lpae",
 	"evtstrm",
+	"pxn",
 	NULL
 };
 
-- 
1.9.1
