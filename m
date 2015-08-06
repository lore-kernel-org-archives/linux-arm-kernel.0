From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  6 Aug 2015 13:27:32 +0200
Subject: [PATCH] ARM: Fix the secondary_startup function in Big Endian case
Message-ID: <1438860452-6347-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the commit "b2c3e38a5471 ARM: redo TTBR setup code for LPAE",
the setup code had been reworked. As a result the secondary CPUs
failed to come online in Big Endian.

As explained by Russell, the new code expected the value in r4/r5 to
be the least significant 32bits in r4 and the most significant 32bits
in r5. However, in the secondary code, we load this using ldrd, which
on BE reverses that.

This patch swap r4/r5 after the ldrd. It is done using the xor
instructions in order to not use a temporary register.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/kernel/head.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index bd755d97e459..75cbcf34c2e9 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -399,6 +399,9 @@ ENTRY(secondary_startup)
 	sub	lr, r4, r5			@ mmu has been enabled
 	add	r3, r7, lr
 	ldrd	r4, [r3, #0]			@ get secondary_data.pgdir
+ARM_BE8(eor	r4, r4, r5)			@ swap r5 and r4 in BE
+ARM_BE8(eor	r5, r4, r5)			@ it can be done in 3 step
+ARM_BE8(eor	r4, r4, r5)			@ without using an temp reg
 	ldr	r8, [r3, #8]			@ get secondary_data.swapper_pg_dir
 	badr	lr, __enable_mmu		@ return address
 	mov	r13, r12			@ __secondary_switched address
-- 
2.1.0
