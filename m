From: js07.lee@gmail.com (Jungseung Lee)
Date: Fri, 24 Oct 2014 20:45:54 +0900
Subject: [PATCH RESEND 1/2] arm: hwcap: add new hwcap for identifying PXN bits
Message-ID: <1414151155-26890-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARMv7-A/R cores can optionally implement below new
hardware feature:

- PXN:
Privileged execute-never(PXN) is a security feature. PXN bit
determines whether the processor can execute software from
the region. This is effective solution against ret2usr attack.
On an implementation that does not include the LPAE, PXN is
optionally supported.

This patch adds new HWCAP defines to describe new feature.

In ARM world, elf_hwcap is used both internally in the kernel and
for user space to keep track of optional features.
HWCAP_PXN is exceptionally not exposed to user space since the user
doesn't need to know.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/include/uapi/asm/hwcap.h | 1 +
 arch/arm/kernel/setup.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 20d12f2..7075207 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -27,6 +27,7 @@
 #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
 #define HWCAP_LPAE	(1 << 20)
 #define HWCAP_EVTSTRM	(1 << 21)
+#define HWCAP_PXN   (1 << 22)       /* set if support the PXN attribute */
 
 /*
  * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c031063..22cd19a 100644
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
+	"",	/* HWCAP_PXN : not expose to user */
 	NULL
 };
 
-- 
1.9.1
