From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 14:40:26 +0100
Subject: [PATCH 1/4] ARM: head: Always Enter the kernel in ARM state
In-Reply-To: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
References: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308577229-23681-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes Image directly bootable; otherwise the kernel is reliant
on the zImage decompressor to switch to the correct instruction
set.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/head.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 278c1b0..742b610 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -71,8 +71,16 @@
  * crap here - that's what the boot loader (or in extreme, well justified
  * circumstances, zImage) is for.
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
 	mrc	p15, 0, r9, c0, c0		@ get processor id
-- 
1.7.4.1
