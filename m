From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Jan 2013 16:48:18 +0000
Subject: [RFC PATCH 4/4] ARM: vexpress/dcscb: power_up_setup memory barrier
 cleanup
In-Reply-To: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1358268498-8086-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bL_head framework has sufficient barriers to ensure correct
globally observed ordering of explicit memory accesses done by the
power_up_setup function.

This patch removes the unnecessary DSB from dcscb_setup.S.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mach-vexpress/dcscb_setup.S |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb_setup.S b/arch/arm/mach-vexpress/dcscb_setup.S
index c75ee8c..e338be7 100644
--- a/arch/arm/mach-vexpress/dcscb_setup.S
+++ b/arch/arm/mach-vexpress/dcscb_setup.S
@@ -64,14 +64,13 @@ ENTRY(dcscb_power_up_setup)
 
 	ldr	r3, =RTSM_CCI_PHYS_BASE
 
-	b	1f
-0:	dsb
 1:	ldr	r0, [r3, #CCI_STATUS_OFFSET]
 	tst	r0, #STATUS_CHANGE_PENDING
-	bne	0b
+	bne	1b
 
 2:	@ Implementation-specific local CPU setup operations should go here,
 	@ if any.  In this case, there is nothing to do.
 
 	bx	lr
+
 ENDPROC(dcscb_power_up_setup)
-- 
1.7.4.1
