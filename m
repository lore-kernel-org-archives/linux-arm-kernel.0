From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed,  9 Dec 2015 09:57:14 +0000
Subject: [RFC PATCH v3 3/8] arm64: head.S : Change register usage
In-Reply-To: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1449655039-22022-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stack information for a secondary CPU (struct secondary_data)
is passed on in x21 before the MMU is turned on. The boot CPU uses
x21 to store the FDT pointer. In a common code shared by these
CPUs, it gets difficult to use the information. So, we use
x22 for passing the secondary_data and initialise it with NULL
for the booting CPU for consistency. This will be used in a following
patch.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/head.S |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 23cfc08..b225d34 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -221,6 +221,7 @@ ENTRY(stext)
 	 */
 	ldr	x27, =__mmap_switched		// address to jump to after
 						// MMU has been enabled
+	mov	x22, 0				// &secondary_data for Boot CPU
 	adr_l	lr, __enable_mmu		// return (PIC) address
 	b	__cpu_setup			// initialise processor
 ENDPROC(stext)
@@ -598,13 +599,13 @@ ENTRY(secondary_startup)
 	adrp	x26, swapper_pg_dir
 	bl	__cpu_setup			// initialise processor
 
-	ldr	x21, =secondary_data
+	ldr	x22, =secondary_data
 	ldr	x27, =__secondary_switched	// address to jump to after enabling the MMU
 	b	__enable_mmu
 ENDPROC(secondary_startup)
 
 ENTRY(__secondary_switched)
-	ldr	x0, [x21]			// get secondary_data.stack
+	ldr	x0, [x22]			// get secondary_data.stack
 	mov	sp, x0
 	mov	x29, #0
 	b	secondary_start_kernel
-- 
1.7.9.5
