From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Jul 2014 20:52:17 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises it
 has exclusives
In-Reply-To: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <E1X39Wr-0000ly-RF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CPU has support for the byte and word exclusive operations,
userspace should use them in preference to the SWP instructions.
Detect the presence of these instructions by reading the ISAR CPU ID
registers and adjust the ELF HWCAP mask appropriately.

Note that ARM1136 < r1p0 has no ISAR4, so this is explicitly detected
and the test disabled, leaving the current situation where HWCAP_SWP
is set.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a16ee5d8a95..84db893dedc2 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -393,19 +393,34 @@ static void __init cpuid_init_hwcaps(void)
 		elf_hwcap |= HWCAP_LPAE;
 }
 
-static void __init feat_v6_fixup(void)
+static void __init elf_hwcap_fixup(void)
 {
-	int id = read_cpuid_id();
-
-	if ((id & 0xff0f0000) != 0x41070000)
-		return;
+	unsigned id = read_cpuid_id();
+	unsigned sync_prim;
 
 	/*
 	 * HWCAP_TLS is available only on 1136 r1p0 and later,
 	 * see also kuser_get_tls_init.
 	 */
-	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
+	if (read_cpuid_part() == ARM_CPU_PART_ARM1136 &&
+	    ((id >> 20) & 3) == 0) {
 		elf_hwcap &= ~HWCAP_TLS;
+		return;
+	}
+
+	/* Verify if CPUID scheme is implemented */
+	if ((id & 0x000f0000) != 0x000f0000)
+		return;
+
+	/*
+	 * If the CPU supports LDREX/STREX and LDREXB/STREXB,
+	 * avoid advertising SWP; it may not be atomic with
+	 * multiprocessing cores.
+	 */
+	sync_prim = ((read_cpuid_ext(CPUID_EXT_ISAR3) >> 8) & 0xf0) |
+		    ((read_cpuid_ext(CPUID_EXT_ISAR4) >> 20) & 0x0f);
+	if (sync_prim >= 0x13)
+		elf_hwcap &= ~HWCAP_SWP;
 }
 
 /*
@@ -609,7 +624,7 @@ static void __init setup_processor(void)
 #endif
 	erratum_a15_798181_init();
 
-	feat_v6_fixup();
+	elf_hwcap_fixup();
 
 	cacheid_init();
 	cpu_init();
-- 
1.8.3.1
