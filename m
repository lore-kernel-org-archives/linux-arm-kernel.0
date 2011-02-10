From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Feb 2011 11:49:26 +0000
Subject: [PATCH] ARM: hw_breakpoint: fix ptrace breakpoint advertising on
	unsupported arch
Message-ID: <1297338566-19947-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ptrace debug information register was advertising breakpoint and
watchpoint resources for unsupported debug architectures. This meant
that setting breakpoints on these architectures would appear to succeed,
although they would never fire in reality.

This patch fixes the breakpoint slot probing so that it returns 0 when
running on an unsupported debug architecture.

Reported-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index ab02d8a..d600bd3 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -137,11 +137,10 @@ static u8 get_debug_arch(void)
 	u32 didr;
 
 	/* Do we implement the extended CPUID interface? */
-	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
-		pr_warning("CPUID feature registers not supported. "
-				"Assuming v6 debug is present.\n");
+	if (WARN_ONCE((((read_cpuid_id() >> 16) & 0xf) != 0xf),
+	    "CPUID feature registers not supported. "
+	    "Assuming v6 debug is present.\n"))
 		return ARM_DEBUG_ARCH_V6;
-	}
 
 	ARM_DBG_READ(c0, 0, didr);
 	return (didr >> 16) & 0xf;
@@ -152,6 +151,12 @@ u8 arch_get_debug_arch(void)
 	return debug_arch;
 }
 
+static int debug_arch_supported(void)
+{
+	u8 arch = get_debug_arch();
+	return arch >= ARM_DEBUG_ARCH_V6 && arch <= ARM_DEBUG_ARCH_V7_ECP14;
+}
+
 /* Determine number of BRP register available. */
 static int get_num_brp_resources(void)
 {
@@ -268,6 +273,9 @@ out:
 
 int hw_breakpoint_slots(int type)
 {
+	if (!debug_arch_supported())
+		return 0;
+
 	/*
 	 * We can be called early, so don't rely on
 	 * our static variables being initialised.
@@ -882,7 +890,7 @@ static int __init arch_hw_breakpoint_init(void)
 
 	debug_arch = get_debug_arch();
 
-	if (debug_arch > ARM_DEBUG_ARCH_V7_ECP14) {
+	if (!debug_arch_supported()) {
 		pr_info("debug architecture 0x%x unsupported.\n", debug_arch);
 		return 0;
 	}
-- 
1.7.0.4
