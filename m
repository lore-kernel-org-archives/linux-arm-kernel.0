From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:39 +0100
Subject: [PATCH 5/7] ARM: hw_breakpoint: make boot quieter without CPUID
 feature registers
In-Reply-To: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350487901-3108-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting on a v6 core without the CPUID feature registers (e.g. 1136)
leads to a noisy dmesg complaining about their absence.

This patch changes the pr_warning into a WARN_ONCE to keep the log
quieter.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b6f4aec..f267120 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -135,11 +135,10 @@ static u8 get_debug_arch(void)
 	u32 didr;
 
 	/* Do we implement the extended CPUID interface? */
-	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
-		pr_warning("CPUID feature registers not supported. "
-			   "Assuming v6 debug is present.\n");
+	if (WARN_ONCE(((read_cpuid_id() >> 16) & 0xf) != 0xf,
+		"CPUID feature registers not supported. "
+		"Assuming v6 debug is present.\n"))
 		return ARM_DEBUG_ARCH_V6;
-	}
 
 	ARM_DBG_READ(c0, 0, didr);
 	return (didr >> 16) & 0xf;
-- 
1.7.4.1
