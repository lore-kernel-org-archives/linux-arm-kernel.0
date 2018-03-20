From: stefan@agner.ch (Stefan Agner)
Date: Wed, 21 Mar 2018 00:02:04 +0100
Subject: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Message-ID: <20180320230206.25289-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As documented in GCC naked functions should only use Basic asm
syntax. The Extended asm or mixture of Basic asm and "C" code is
not guaranteed. Currently this works because it was hard coded
to follow and check GCC behavior for arguments and register
placement.

Furthermore with clang using parameters in Extended asm in a
naked function is not supported:
  arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
          references not allowed in naked functions
                : "r" (type), "r" (arg1), "r" (arg2)
                       ^

Use a regular function to be more portable. This aligns also with
the other smc call implementations e.g. in qcom_scm-32.c and
bcm_kona_smc.c.

Additionally also make sure all callee-saved registers get saved
as it has been done before.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/firmware/trusted_foundations.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3fb1b5a1dce9..426d732e6591 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -31,21 +31,23 @@
 
 static unsigned long cpu_boot_addr;
 
-static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
+static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 {
+	register u32 r0 asm("r0") = type;
+	register u32 r1 asm("r1") = arg1;
+	register u32 r2 asm("r2") = arg2;
+
 	asm volatile(
 		".arch_extension	sec\n\t"
-		"stmfd	sp!, {r4 - r11, lr}\n\t"
 		__asmeq("%0", "r0")
 		__asmeq("%1", "r1")
 		__asmeq("%2", "r2")
 		"mov	r3, #0\n\t"
 		"mov	r4, #0\n\t"
 		"smc	#0\n\t"
-		"ldmfd	sp!, {r4 - r11, pc}"
 		:
-		: "r" (type), "r" (arg1), "r" (arg2)
-		: "memory");
+		: "r" (r0), "r" (r1), "r" (r2)
+		: "memory", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10");
 }
 
 static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
-- 
2.16.2
