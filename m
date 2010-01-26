From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Jan 2010 22:28:41 +0100
Subject: [PATCH 2/4] zImage: some comments for __armv3_mpu_cache_on
In-Reply-To: <20100126203835.GC17642@pengutronix.de>
References: <20100126203835.GC17642@pengutronix.de>
Message-ID: <1264541323-3454-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__armv3_mpu_cache_on seems broken.  As there is noone around who knows
about these machines just keep the code as is but point out the strange
things.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 7cbab3c..f6d665f 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -395,12 +395,15 @@ __armv3_mpu_cache_on:
 
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		/* ?? ARMv3 MMU doesn not allow reading the control register, does this really work on ARMv3 MPU? */
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
1.6.6
