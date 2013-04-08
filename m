From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 14:09:00 +0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <CAOMZO5A-nwmb=6G-D_2LBNsPYH4C8Z686BjS3vd3WhzvnDFfqw@mail.gmail.com>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
 <20130407071028.GD11898@S2101-09.ap.freescale.net>
 <CAOMZO5Bxfj9ZGrVOcNirsVHFLWaHWBdkFpKSiVQ9iS4paT0Y6g@mail.gmail.com>
 <20130407142610.GE11898@S2101-09.ap.freescale.net>
 <CAOMZO5A-nwmb=6G-D_2LBNsPYH4C8Z686BjS3vd3WhzvnDFfqw@mail.gmail.com>
Message-ID: <20130408060857.GA5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 11:32:45AM -0300, Fabio Estevam wrote:
> On Sun, Apr 7, 2013 at 11:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > That's expected, as the pin ID gets re-numbered based on offset of
> > mux/conf register, so that we can determine the pin ID at runtime and
> > avoid encoding it in device tree.
> 
> but debug messages seems buggy now:
> 
Yes, you are right.  The change attached below should fix the problem.
I am fixing it up for all imx pinctrl drivers on imx/dt branch.

> Prior to the patch we had:
> 
> imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_D21
> 
> and now we have:
> 
> imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_A17
> 
> MX6Q_PAD_EIM_A17 has nothing to do with I2C, so we should print
> MX6Q_PAD_EIM_A17 when we are actually configuring MX6Q_PAD_EIM_D21.
> 
> Also, where does the 19 offset in the  imx6q_pads enum come from?

We choose to have the pin ID simply calculated from register offset.
For example, the mux register offset for MX6Q_PAD_SD2_DAT1 is 0x4c, and
the ID would be 0x4c / 4 = 19.

Shawn

--8<-----

diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
index f00f532..76dd9c4 100644
--- a/drivers/pinctrl/pinctrl-imx6q.c
+++ b/drivers/pinctrl/pinctrl-imx6q.c
@@ -23,6 +23,25 @@
 #include "pinctrl-imx.h"
 
 enum imx6q_pads {
+	MX6Q_PAD_RESERVE0 = 0,
+	MX6Q_PAD_RESERVE1 = 1,
+	MX6Q_PAD_RESERVE2 = 2,
+	MX6Q_PAD_RESERVE3 = 3,
+	MX6Q_PAD_RESERVE4 = 4,
+	MX6Q_PAD_RESERVE5 = 5,
+	MX6Q_PAD_RESERVE6 = 6,
+	MX6Q_PAD_RESERVE7 = 7,
+	MX6Q_PAD_RESERVE8 = 8,
+	MX6Q_PAD_RESERVE9 = 9,
+	MX6Q_PAD_RESERVE10 = 10,
+	MX6Q_PAD_RESERVE11 = 11,
+	MX6Q_PAD_RESERVE12 = 12,
+	MX6Q_PAD_RESERVE13 = 13,
+	MX6Q_PAD_RESERVE14 = 14,
+	MX6Q_PAD_RESERVE15 = 15,
+	MX6Q_PAD_RESERVE16 = 16,
+	MX6Q_PAD_RESERVE17 = 17,
+	MX6Q_PAD_RESERVE18 = 18,
 	MX6Q_PAD_SD2_DAT1 = 19,
 	MX6Q_PAD_SD2_DAT2 = 20,
 	MX6Q_PAD_SD2_DAT0 = 21,
@@ -224,6 +243,25 @@ enum imx6q_pads {
 
 /* Pad names for the pinmux subsystem */
 static const struct pinctrl_pin_desc imx6q_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE0),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE1),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE2),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE3),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE4),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE5),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE6),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE7),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE8),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE9),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE10),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE11),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE12),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE13),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE14),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE15),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE16),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE17),
+	IMX_PINCTRL_PIN(MX6Q_PAD_RESERVE18),
 	IMX_PINCTRL_PIN(MX6Q_PAD_SD2_DAT1),
 	IMX_PINCTRL_PIN(MX6Q_PAD_SD2_DAT2),
 	IMX_PINCTRL_PIN(MX6Q_PAD_SD2_DAT0),
