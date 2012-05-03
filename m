From: bryan.buckley@ti.com (Bryan Buckley)
Date: Thu, 3 May 2012 16:00:25 -0500
Subject: [PATCH] ARM: Enable I$/D$/BrPredict based on config
Message-ID: <1336078825-9810-1-git-send-email-bryan.buckley@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we only disable these bits based on config. Now we will
use this config option to explicitly enable these features at this
point regardless of what bootloader, other SW, or HW did before.

Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>
---
 arch/arm/kernel/head.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3bf0c7f..cec0de5 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -411,12 +411,18 @@ __enable_mmu:
 #endif
 #ifdef CONFIG_CPU_DCACHE_DISABLE
 	bic	r0, r0, #CR_C
+#else
+	orr	r0, r0, #CR_C
 #endif
 #ifdef CONFIG_CPU_BPREDICT_DISABLE
 	bic	r0, r0, #CR_Z
+#else
+	orr	r0, r0, #CR_Z
 #endif
 #ifdef CONFIG_CPU_ICACHE_DISABLE
 	bic	r0, r0, #CR_I
+#else
+	orr	r0, r0, #CR_I
 #endif
 #ifdef CONFIG_ARM_LPAE
 	mov	r5, #0
-- 
1.7.4.1
