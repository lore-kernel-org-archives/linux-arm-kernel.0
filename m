From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 27 Mar 2012 17:50:39 +0100
Subject: [PATCH RESEND 2/2] ARM: ThumbEE: Use cpuid macros to read ID_PFR0 for
 ThumbEE
In-Reply-To: <1332867039-3567-1-git-send-email-jonathan.austin@arm.com>
References: <1332867039-3567-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1332867039-3567-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ThumbEE probe code uses inline assembly to read ID_PFR0 in order to
detect whether ThumbEE is implemented by the processor.

This patch replaces the inline asm with the read_cpuid_ext macro.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---

Resending these patches, rebased on v3.3. If there are no comments again
this time around I will submit them to the patch-system when RC1 comes
around.
 

 arch/arm/kernel/thumbee.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/thumbee.c b/arch/arm/kernel/thumbee.c
index 9cb7aac..3471f63 100644
--- a/arch/arm/kernel/thumbee.c
+++ b/arch/arm/kernel/thumbee.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
+#include <asm/cputype.h>
 #include <asm/thread_notify.h>
 
 /*
@@ -66,8 +67,7 @@ static int __init thumbee_init(void)
 	if (cpu_arch < CPU_ARCH_ARMv7)
 		return 0;
 
-	/* processor feature register 0 */
-	asm("mrc	p15, 0, %0, c0, c1, 0\n" : "=r" (pfr0));
+	pfr0 = read_cpuid_ext(CPUID_EXT_PFR0);
 	if ((pfr0 & 0x0000f000) != 0x00001000)
 		return 0;
 
-- 
1.7.1
