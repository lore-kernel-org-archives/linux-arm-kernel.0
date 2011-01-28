From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Jan 2011 08:00:46 -0600
Subject: [PATCH v2] ARM: map ATAGs when not in first 1MB of RAM
Message-ID: <1296223246-2934-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

If ATAGs or DTB pointer is not within first 1MB of RAM, then the boot params
will not be mapped early enough, so map the 1MB region that r2 points to. Only
map the first 1MB when r2 is 0.

Some assembly improvements from Nicolas Pitre.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---

Applies to Russell's p2v branch

 arch/arm/kernel/head.S |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 17a97b5..d4efa71 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -206,11 +206,17 @@ __create_page_tables:
 #endif
 
 	/*
-	 * Then map first 1MB of ram in case it contains our boot params.
+	 * Then map boot params address in r2 or
+	 * the first 1MB of ram if boot params address is not specified.
 	 */
-	add	r0, r4, #PAGE_OFFSET >> 18
-	orr	r6, r7, r8
-	str	r6, [r0]
+	mov	r0, r2, lsr #20
+	movs	r0, r0, lsl #20
+	moveq	r0, r8
+	sub	r3, r0, r8
+	add	r3, r3, #PAGE_OFFSET
+	add	r3, r4, r3, lsr #18
+	orr	r6, r7, r0
+	str	r6, [r3]
 
 #ifdef CONFIG_DEBUG_LL
 #ifndef CONFIG_DEBUG_ICEDCC
-- 
1.7.1
