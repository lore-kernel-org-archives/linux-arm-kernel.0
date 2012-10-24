From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 24 Oct 2012 19:57:51 +0900
Subject: [PATCH 3/5] i2c: i2c-sh_mobile: fix ICCH to avoid violation of the
 tHD;STA timing spec
In-Reply-To: <5087C93F.6080601@renesas.com>
References: <5087C93F.6080601@renesas.com>
Message-ID: <5087C9AF.409@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optimized ICCH/ICCL values in the previous commit afterward turned
out to violate tHD;STA timing spec.  We had to take into account the
fall time of SDA signal (tf) at START condition.  Fix it accordingly.

With this change, sh_mobile_i2c_icch() is virtually identical to
sh_mobile_i2c_iccl(), but they're providing good descriptions of
SH-/R-Mobile I2C hardware spec, and I'd leave them as separated.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 1ad80c9..4dc0cc3 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -203,18 +203,23 @@ static u32 sh_mobile_i2c_iccl(unsigned long count_khz, u32 tLOW, u32 tf, int off
 	return (((count_khz * (tLOW + tf)) + 5000) / 10000) + offset;
 }
 
-static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, int offset)
+static u32 sh_mobile_i2c_icch(unsigned long count_khz, u32 tHIGH, u32 tf, int offset)
 {
 	/*
 	 * Conditional expression:
-	 *   ICCH >= COUNT_CLK * tHIGH
+	 *   ICCH >= COUNT_CLK * (tHIGH + tf)
 	 *
 	 * SH-Mobile IIC hardware is aware of SCL transition period 'tr',
 	 * and can ignore it.  SH-Mobile IIC controller starts counting
 	 * the HIGH period of the SCL signal (tHIGH) after the SCL input
 	 * voltage increases at VIH.
+	 *
+	 * Afterward it turned out calculating ICCH using only tHIGH spec
+	 * will result in violation of the tHD;STA timing spec.  We need
+	 * to take into account the fall time of SDA signal (tf) at START
+	 * condition, in order to meet both tHIGH and tHD;STA specs.
 	 */
-	return ((count_khz * tHIGH) + 5000) / 10000 + offset;
+	return (((count_khz * (tHIGH + tf)) + 5000) / 10000) + offset;
 }
 
 static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
@@ -250,7 +255,7 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	else
 		pd->icic &= ~ICIC_ICCLB8;
 
-	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, offset);
+	pd->icch = sh_mobile_i2c_icch(i2c_clk_khz, tHIGH, tf, offset);
 	/* one more bit of ICCH in ICIC */
 	if ((pd->icch > 0xff) && (pd->flags & IIC_FLAG_HAS_ICIC67))
 		pd->icic |= ICIC_ICCHB8;
-- 
1.7.12.4
