From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Oct 2012 11:30:12 +0100
Subject: [PATCH v2 5/8] ARM: hw_breakpoint: make boot quieter without CPUID
 feature registers
In-Reply-To: <1351247415-25090-1-git-send-email-will.deacon@arm.com>
References: <1351247415-25090-1-git-send-email-will.deacon@arm.com>
Message-ID: <1351247415-25090-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting on a v6 core without the CPUID feature registers (e.g. 1136)
leads to a noisy dmesg complaining about their absence.

This patch changes the pr_warning into a pr_warn_once to keep the log
quieter.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 8cd52fa..983558e 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -136,8 +136,8 @@ static u8 get_debug_arch(void)
 
 	/* Do we implement the extended CPUID interface? */
 	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
-		pr_warning("CPUID feature registers not supported. "
-			   "Assuming v6 debug is present.\n");
+		pr_warn_once("CPUID feature registers not supported. "
+			     "Assuming v6 debug is present.\n");
 		return ARM_DEBUG_ARCH_V6;
 	}
 
-- 
1.7.4.1
