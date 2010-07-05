From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  5 Jul 2010 16:15:20 +0200
Subject: [PATCH 02/11] ARM: zImage: some comments for __armv3_mpu_cache_on
In-Reply-To: <20100705141344.GA25407@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
Message-ID: <1278339329-23739-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__armv3_mpu_cache_on seems broken.  As there is noone around who knows
about these machines just keep the code as is but point out the strange
things.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 390aa92..7b7d95c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -396,12 +396,18 @@ __armv3_mpu_cache_on:
 
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		/*
+		 * ?? ARMv3 MMU does not allow reading the control register,
+		 * does this really work on ARMv3 MPU?
+		 */
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 						@ .... .... .... WC.M
 		orr	r0, r0, #0x000d		@ .... .... .... 11.1
+		/* ?? this overwrites the value constructed above? */
 		mov	r0, #0
 		mcr	p15, 0, r0, c1, c0, 0	@ write control reg
 
+		/* ?? invalidate for the second time? */
 		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
 		mov	pc, lr
 
-- 
1.7.1
