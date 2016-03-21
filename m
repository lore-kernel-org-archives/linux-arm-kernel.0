From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Mar 2016 18:35:11 +0100
Subject: [PATCH] arm64: kaslr: use callee saved register to preserve SCTLR
 across C call
Message-ID: <1458581711-13950-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KASLR code incorrectly expects the contents of x18 to be preserved
across a call into C code, and uses it to stash the contents of SCTLR_EL1
before enabling the MMU. If the MMU needs to be disabled again to create
the randomized kernel mapping, x18 is written back to SCTLR_EL1, which is
likely to crash the system if x18 has been clobbered by kasan_early_init()
or kaslr_early_init(). So use x22 instead, which is not in use so far in
head.S

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5728ba6878e0..f03101064f52 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -763,7 +763,7 @@ ENTRY(__early_cpu_boot_status)
  */
 	.section	".idmap.text", "ax"
 __enable_mmu:
-	mrs	x18, sctlr_el1			// preserve old SCTLR_EL1 value
+	mrs	x22, sctlr_el1			// preserve old SCTLR_EL1 value
 	mrs	x1, ID_AA64MMFR0_EL1
 	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
@@ -792,7 +792,7 @@ __enable_mmu:
 	 * to take into account by discarding the current kernel mapping and
 	 * creating a new one.
 	 */
-	msr	sctlr_el1, x18			// disable the MMU
+	msr	sctlr_el1, x22			// disable the MMU
 	isb
 	bl	__create_page_tables		// recreate kernel mapping
 
-- 
1.9.1
