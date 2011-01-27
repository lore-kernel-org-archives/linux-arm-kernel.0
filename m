From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Jan 2011 09:50:43 -0600
Subject: [PATCH] ARM: map ATAGs when not in first 1MB of RAM
Message-ID: <1296143443-9442-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

If ATAGs or DTB pointer is not within first 1MB of RAM, then the boot params
will not be mapped early enough, so map the 1MB region that r2 points to. Only
map the first 1MB when r2 is 0.

Some assembly improvements from Nicolas Pitre.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/head.S |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 65d9489..9c688bf 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -205,15 +205,32 @@ __create_page_tables:
 #endif
 
 	/*
-	 * Then map first 1MB of ram in case it contains our boot params.
+	 * Then map first 1MB of ram if boot params address is not specified.
 	 */
+	cmp	r2, #0
+	bne	1f
 	add	r0, r4, #PAGE_OFFSET >> 18
 	orr	r6, r7, #(PHYS_OFFSET & 0xff000000)
 	.if	(PHYS_OFFSET & 0x00f00000)
 	orr	r6, r6, #(PHYS_OFFSET & 0x00f00000)
 	.endif
 	str	r6, [r0]
+	b	2f
 
+	/*
+	 * Otherwise map the 1MB region r2 points to (atags or dtb)
+	 */
+1:	mov	r0, r2, lsr #20
+	mov	r0, r0, lsl #20
+	sub	r3, r0, #(PHYS_OFFSET & 0xff000000)
+	.if	(PHYS_OFFSET & 0x00f00000)
+	sub	r3, r3, #(PHYS_OFFSET & 0x00f00000)
+	.endif
+	add	r3, r3, #PAGE_OFFSET
+	add	r3, r4, r3, lsr #18
+	orr	r6, r7, r0
+	str	r6, [r3]
+2:
 #ifdef CONFIG_DEBUG_LL
 #ifndef CONFIG_DEBUG_ICEDCC
 	/*
-- 
1.7.1
