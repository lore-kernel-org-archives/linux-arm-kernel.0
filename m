From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 14:40:27 +0100
Subject: [PATCH 2/4] ARM: head-nommu: Always enter the kernel in ARM state
In-Reply-To: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
References: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308577229-23681-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes Image directly bootable; otherwise the kernel is reliant
on the zImage decompressor to switch to the correct instruction
set.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/head-nommu.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 6b1e0ad..d46f259 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -32,8 +32,16 @@
  * numbers for r1.
  *
  */
+	.arm
+
 	__HEAD
 ENTRY(stext)
+
+ THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
+ THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ THUMB(	.thumb			)	@ switch to Thumb now.
+ THUMB(1:			)
+
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
 #ifndef CONFIG_CPU_CP15
-- 
1.7.4.1
