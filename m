From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Mon, 22 Nov 2010 04:40:02 -0800
Subject: [PATCH 1/2] ARM: pxa: replace duplicated macro DEFINE_PXA3_CK()
	with DEFINE_CK()
In-Reply-To: <1290406957-21601-1-git-send-email-eric.y.miao@gmail.com>
References: <1290406957-21601-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C059ABECC49@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?22? 2:23 PM
>To: linux-arm-kernel
>Cc: Haojian Zhuang; Eric Miao
>Subject: [PATCH 1/2] ARM: pxa: replace duplicated macro DEFINE_PXA3_CK() with
>DEFINE_CK()
>
>Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>---
> arch/arm/mach-pxa/clock.h  |   22 ++++++++--------------
> arch/arm/mach-pxa/pxa3xx.c |    7 ++++---
> 2 files changed, 12 insertions(+), 17 deletions(-)
>
>diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
>index d848874..f09ecb1 100644
>--- a/arch/arm/mach-pxa/clock.h
>+++ b/arch/arm/mach-pxa/clock.h
>@@ -21,14 +21,6 @@ struct clk {
> 		.con_id		= _conname,		\
> 	}
>
>-#define DEFINE_CKEN(_name, _cken, _rate, _delay)	\
>-struct clk clk_##_name = {				\
>-		.ops	= &clk_cken_ops,		\
>-		.rate	= _rate,			\
>-		.cken	= CKEN_##_cken,			\
>-		.delay	= _delay,			\
>-	}
>-
> #define DEFINE_CK(_name, _cken, _ops)			\
> struct clk clk_##_name = {				\
> 		.ops	= _ops,				\
>@@ -42,6 +34,14 @@ struct clk clk_##_name = {				\
> 		.delay	= _delay,			\
> 	}
>
>+#define DEFINE_CKEN(_name, _cken, _rate, _delay)	\
>+struct clk clk_##_name = {				\
>+		.ops	= &clk_cken_ops,		\
>+		.rate	= _rate,			\
>+		.cken	= CKEN_##_cken,			\
>+		.delay	= _delay,			\
>+	}
>+
> extern const struct clkops clk_cken_ops;
>
> void clk_cken_enable(struct clk *clk);
>@@ -56,12 +56,6 @@ struct clk clk_##_name = {				\
> 		.delay	= _delay,			\
> 	}
>
>-#define DEFINE_PXA3_CK(_name, _cken, _ops)		\
>-struct clk clk_##_name = {				\
>-		.ops	= _ops,				\
>-		.cken	= CKEN_##_cken,			\
>-	}
>-
> extern const struct clkops clk_pxa3xx_cken_ops;
> extern void clk_pxa3xx_cken_enable(struct clk *);
> extern void clk_pxa3xx_cken_disable(struct clk *);
>diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
>index dc658ad..a0b123c 100644
>--- a/arch/arm/mach-pxa/pxa3xx.c
>+++ b/arch/arm/mach-pxa/pxa3xx.c
>@@ -216,9 +216,6 @@ static struct clk clk_dummy = {
> 	.ops		= &clk_dummy_ops,
> };
>
>-static DEFINE_PXA3_CK(pxa3xx_lcd, LCD, &clk_pxa3xx_hsio_ops);
>-static DEFINE_PXA3_CK(pxa3xx_camera, CAMERA, &clk_pxa3xx_hsio_ops);
>-static DEFINE_PXA3_CK(pxa3xx_ac97, AC97, &clk_pxa3xx_ac97_ops);
> static DEFINE_PXA3_CKEN(pxa3xx_ffuart, FFUART, 14857000, 1);
> static DEFINE_PXA3_CKEN(pxa3xx_btuart, BTUART, 14857000, 1);
> static DEFINE_PXA3_CKEN(pxa3xx_stuart, STUART, 14857000, 1);
>@@ -236,6 +233,10 @@ static DEFINE_PXA3_CKEN(pxa3xx_pwm1, PWM1, 13000000, 0);
> static DEFINE_PXA3_CKEN(pxa3xx_mmc1, MMC1, 19500000, 0);
> static DEFINE_PXA3_CKEN(pxa3xx_mmc2, MMC2, 19500000, 0);
>
>+static DEFINE_CK(pxa3xx_lcd, LCD, &clk_pxa3xx_hsio_ops);
>+static DEFINE_CK(pxa3xx_camera, CAMERA, &clk_pxa3xx_hsio_ops);
>+static DEFINE_CK(pxa3xx_ac97, AC97, &clk_pxa3xx_ac97_ops);
>+
> static struct clk_lookup pxa3xx_clkregs[] = {
> 	INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
> 	/* Power I2C clock is always on */
>--
>1.7.1

Acked.
