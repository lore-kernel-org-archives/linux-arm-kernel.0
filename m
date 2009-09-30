From: davidb@codeaurora.org (David Brown)
Date: Wed, 30 Sep 2009 14:44:31 -0700
Subject: [PATCH] ARM: allow empty ATAG_CORE
Message-ID: <1254347072-27932-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Brown <davidb@quicinc.com>

The ATAG_CORE is allowed to be empty.  Although this is handled
by parse_tag_core(), __vet_atags during startup rejects this tag
unless it contains data.  Allow the initial tag to be either the
full size, or empty.

Signed-off-by: David Brown <davidb@quicinc.com>
---
Currently, some configurations of the Android bootloader use an empty
ATAG_CORE.

 arch/arm/kernel/head-common.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 93ad576..1e8f0d6 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -13,6 +13,7 @@
 
 #define ATAG_CORE 0x54410001
 #define ATAG_CORE_SIZE ((2*4 + 3*4) >> 2)
+#define ATAG_CORE_SIZE_EMPTY ((2*4 + 3*4) >> 2)
 
 	.align	2
 	.type	__switch_data, %object
@@ -251,7 +252,8 @@ __vet_atags:
 	bne	1f
 
 	ldr	r5, [r2, #0]			@ is first tag ATAG_CORE?
-	subs	r5, r5, #ATAG_CORE_SIZE
+	cmp	r5, #ATAG_CORE_SIZE
+	cmpne	r5, #ATAG_CORE_SIZE_EMPTY
 	bne	1f
 	ldr	r5, [r2, #4]
 	ldr	r6, =ATAG_CORE
-- 
1.6.2.3
