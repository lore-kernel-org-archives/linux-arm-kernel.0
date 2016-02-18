From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 17:34:48 +0100
Subject: [PATCH] [RESEND] ARM: PJ4: don't use PJ4B code on PJ4
Message-ID: <1455813309-2556471-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can have multiplatform kernels with PJ4 (Dove, MMP2) in combination
with PJ4B (Armada 370) or PJ4B-MP (Berlin, Armada XP), and the processor
functions that are defined for PJ4B use a mask that covers all three
core types, rather than using the default ARMv7 type for the original
PJ4.

This adds a second entry for PJ4B-MP, so we at least get a consistent
behavior between single-machine kernels and combined ones.

I suspect however that we actually want different contents for each
of the three cores, as PJ4B and PJ4B-MP appear to be at least as
different as PJ4 is from PJ4B, in particular the support for
the standard architecture extensions like IDIV and LPAE, and the
PJ4B_ERRATA_4742 workaround apparently does not apply to PJ4B-MP
but might apply to PJ4.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 049be07053eb ("ARM: 7754/1: Fix the CPU ID and the mask associated to the PJ4B")
---
I sent this out previously as an RFC but did not get any reply. I'm
pretty sure we still need the patch, or an extended version of it,
but I'd be much happier if someone could actually look into the
contents.
---
 arch/arm/mm/proc-v7.S | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0f8963a7e7d9..7239fd55b159 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -576,10 +576,17 @@ __v7_ca8_proc_info:
 #ifdef CONFIG_CPU_PJ4B
 	.type   __v7_pj4b_proc_info, #object
 __v7_pj4b_proc_info:
-	.long	0x560f5800
-	.long	0xff0fff00
+	.long	0x562f5840
+	.long	0xfffffff0
 	__v7_proc __v7_pj4b_proc_info, __v7_pj4b_setup, proc_fns = pj4b_processor_functions
 	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
+
+	.type   __v7_pj4bmp_proc_info, #object
+__v7_pj4bmp_proc_info:
+	.long	0x561f5810
+	.long	0xfffffff0
+	__v7_proc __v7_pj4bmp_proc_info, __v7_pj4b_setup, proc_fns = pj4b_processor_functions
+	.size	__v7_pj4bmp_proc_info, . - __v7_pj4bmp_proc_info
 #endif
 
 	/*
-- 
2.7.0
