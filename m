From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat,  5 Aug 2017 21:52:21 +0100
Subject: [PATCH 14/15] arm-soc: shmobile: replace open coded VA->PA calculation
In-Reply-To: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
References: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
Message-ID: <20170805205222.19868-15-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces a couple of open coded calculations to obtain the
physical address of a far symbol with calls to the new adr_l etc
macros.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mach-shmobile/headsmp.S | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 32e0bf6e3ccb..f5e0d7c93cda 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -46,11 +46,10 @@ ENTRY(shmobile_smp_boot)
 	and	r0, r1, #0xffffff		@ MPIDR_HWID_BITMASK
 						@ r0 = cpu_logical_map() value
 	mov	r1, #0				@ r1 = CPU index
-	adr	r2, 1f
-	ldmia	r2, {r5, r6, r7}
-	add	r5, r5, r2			@ array of per-cpu mpidr values
-	add	r6, r6, r2			@ array of per-cpu functions
-	add	r7, r7, r2			@ array of per-cpu arguments
+
+	adr_l	r5, shmobile_smp_mpidr		@ array of per-cpu mpidr values
+	adr_l	r6, shmobile_smp_fn		@ array of per-cpu functions
+	adr_l	r7, shmobile_smp_arg		@ array of per-cpu arguments
 
 shmobile_smp_boot_find_mpidr:
 	ldr	r8, [r5, r1, lsl #2]
@@ -78,11 +77,6 @@ ENTRY(shmobile_smp_sleep)
 	b	shmobile_smp_boot
 ENDPROC(shmobile_smp_sleep)
 
-	.align	2
-1:	.long	shmobile_smp_mpidr - .
-	.long	shmobile_smp_fn - 1b
-	.long	shmobile_smp_arg - 1b
-
 	.bss
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
-- 
2.11.0
