From: sramana@codeaurora.org (Srinivas Ramana)
Date: Wed, 28 Sep 2016 18:15:28 +0530
Subject: [PATCH v1] ARM: decompressor: reset ttbcr fields to use TTBR0 on ARMv7
In-Reply-To: <3441d0c3-c4b6-a795-a841-b61a8866ce17@arm.com>
References: <3441d0c3-c4b6-a795-a841-b61a8866ce17@arm.com>
Message-ID: <1475066728-27290-1-git-send-email-sramana@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the bootloader uses the long descriptor format and jumps to
kernel decompressor code, TTBCR may not be in a right state.
Before enabling the MMU, it is required to clear the TTBCR.PD0
field to use TTBR0 for translation table walks.

The commit dbece45894d3a ("ARM: 7501/1: decompressor:
reset ttbcr for VMSA ARMv7 cores") does the reset of TTBCR.N, but
doesn't consider all the bits for the size of TTBCR.N.

Clear TTBCR.PD0 field and reset all the three bits of TTBCR.N to
indicate the use of TTBR0 and the correct base address width.

Fixes: dbece45894d3 ("ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores")
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
---
 arch/arm/boot/compressed/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index af11c2f8f3b7..fc6d541549a2 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -779,7 +779,7 @@ __armv7_mmu_cache_on:
 		orrne	r0, r0, #1		@ MMU enabled
 		movne	r1, #0xfffffffd		@ domain 0 = client
 		bic     r6, r6, #1 << 31        @ 32-bit translation system
-		bic     r6, r6, #3 << 0         @ use only ttbr0
+		bic     r6, r6, #(7 << 0) | (1 << 4)	@ use only ttbr0
 		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
 		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
 		mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
