From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 08 May 2015 18:35:31 +0100
Subject: [PATCH 2/3] ARM: proc-v7: clean up MIDR access
In-Reply-To: <20150508173505.GL2067@n2100.arm.linux.org.uk>
References: <20150508173505.GL2067@n2100.arm.linux.org.uk>
Message-ID: <E1YqmBP-0000Na-18@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have the main ID register available in r9, there's no need
to refetch it.  Use the saved value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 48031ee36e4c..19c1c8b7c3bb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -409,14 +409,13 @@ __v7_setup:
 	bl      v7_flush_dcache_louis
 	ldmia	r12, {r0-r5, r7, r9, r11, lr}
 
-	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
-	and	r10, r0, #0xff000000		@ ARM?
+	and	r10, r9, #0xff000000		@ ARM?
 	teq	r10, #0x41000000
 	bne	__errata_finish
-	and	r3, r0, #0x00f00000		@ variant
-	and	r6, r0, #0x0000000f		@ revision
+	and	r3, r9, #0x00f00000		@ variant
+	and	r6, r9, #0x0000000f		@ revision
 	orr	r6, r6, r3, lsr #20-4		@ combine variant and revision
-	ubfx	r0, r0, #4, #12			@ primary part number
+	ubfx	r0, r9, #4, #12			@ primary part number
 
 	/* Cortex-A8 Errata */
 	ldr	r10, =0x00000c08		@ Cortex-A8 primary part number
-- 
1.8.3.1
