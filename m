From: ben-linux@fluff.org (Ben Dooks)
Date: Tue,  1 Dec 2009 01:43:13 +0000
Subject: [clocks] ARM: SAMSUNG: Reduce size of struct clk.
In-Reply-To: <1259631793-25480-1-git-send-email-ben-linux@fluff.org>
References: <1259631793-25480-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1259631793-25480-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce the size of struct clk by 12 bytes and make defining clocks with
common implementation functions easier by moving the set_rate, get_rate,
round_rate and set_parent calls into a new structure called 'struct clk_ops'
and using that instead.

This change does make a few clocks larger as they need their own clk_ops,
but this is outweighed by the number of clocks with either no ops or having
a common set of ops.

Update all the users of this.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2412/clock.c              |   52 ++++++++++------
 arch/arm/mach-s3c2440/clock.c              |    6 +-
 arch/arm/mach-s3c2442/clock.c              |    6 +-
 arch/arm/mach-s3c2443/clock.c              |   88 +++++++++++++++++---------
 arch/arm/plat-s3c/clock.c                  |   31 +++++----
 arch/arm/plat-s3c/pwm-clock.c              |   94 ++++++++++++++--------------
 arch/arm/plat-s3c24xx/clock-dclk.c         |   22 ++++---
 arch/arm/plat-s3c24xx/s3c244x-clock.c      |    4 +-
 arch/arm/plat-s3c64xx/s3c6400-clock.c      |   14 +++-
 arch/arm/plat-s5pc1xx/s5pc100-clock.c      |   28 ++++++---
 arch/arm/plat-samsung/clock-clksrc.c       |   17 +++---
 arch/arm/plat-samsung/include/plat/clock.h |   29 +++++++-
 12 files changed, 246 insertions(+), 145 deletions(-)

diff --git a/arch/arm/mach-s3c2412/clock.c b/arch/arm/mach-s3c2412/clock.c
index a037df5..0c0505b 100644
--- a/arch/arm/mach-s3c2412/clock.c
+++ b/arch/arm/mach-s3c2412/clock.c
@@ -124,7 +124,9 @@ static struct clk clk_usysclk = {
 	.name		= "usysclk",
 	.id		= -1,
 	.parent		= &clk_xtal,
-	.set_parent	= s3c2412_setparent_usysclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2412_setparent_usysclk,
+	},
 };
 
 static struct clk clk_mrefclk = {
@@ -199,10 +201,12 @@ static int s3c2412_setrate_usbsrc(struct clk *clk, unsigned long rate)
 static struct clk clk_usbsrc = {
 	.name		= "usbsrc",
 	.id		= -1,
-	.get_rate	= s3c2412_getrate_usbsrc,
-	.set_rate	= s3c2412_setrate_usbsrc,
-	.round_rate	= s3c2412_roundrate_usbsrc,
-	.set_parent	= s3c2412_setparent_usbsrc,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2412_getrate_usbsrc,
+		.set_rate	= s3c2412_setrate_usbsrc,
+		.round_rate	= s3c2412_roundrate_usbsrc,
+		.set_parent	= s3c2412_setparent_usbsrc,
+	},
 };
 
 static int s3c2412_setparent_msysclk(struct clk *clk, struct clk *parent)
@@ -225,7 +229,9 @@ static int s3c2412_setparent_msysclk(struct clk *clk, struct clk *parent)
 static struct clk clk_msysclk = {
 	.name		= "msysclk",
 	.id		= -1,
-	.set_parent	= s3c2412_setparent_msysclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2412_setparent_msysclk,
+	},
 };
 
 static int s3c2412_setparent_armclk(struct clk *clk, struct clk *parent)
@@ -264,7 +270,9 @@ static struct clk clk_armclk = {
 	.name		= "armclk",
 	.id		= -1,
 	.parent		= &clk_msysclk,
-	.set_parent	= s3c2412_setparent_armclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2412_setparent_armclk,
+	},
 };
 
 /* these next clocks have an divider immediately after them,
@@ -337,10 +345,12 @@ static int s3c2412_setrate_uart(struct clk *clk, unsigned long rate)
 static struct clk clk_uart = {
 	.name		= "uartclk",
 	.id		= -1,
-	.get_rate	= s3c2412_getrate_uart,
-	.set_rate	= s3c2412_setrate_uart,
-	.set_parent	= s3c2412_setparent_uart,
-	.round_rate	= s3c2412_roundrate_clksrc,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2412_getrate_uart,
+		.set_rate	= s3c2412_setrate_uart,
+		.set_parent	= s3c2412_setparent_uart,
+		.round_rate	= s3c2412_roundrate_clksrc,
+	},
 };
 
 static int s3c2412_setparent_i2s(struct clk *clk, struct clk *parent)
@@ -388,10 +398,12 @@ static int s3c2412_setrate_i2s(struct clk *clk, unsigned long rate)
 static struct clk clk_i2s = {
 	.name		= "i2sclk",
 	.id		= -1,
-	.get_rate	= s3c2412_getrate_i2s,
-	.set_rate	= s3c2412_setrate_i2s,
-	.set_parent	= s3c2412_setparent_i2s,
-	.round_rate	= s3c2412_roundrate_clksrc,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2412_getrate_i2s,
+		.set_rate	= s3c2412_setrate_i2s,
+		.set_parent	= s3c2412_setparent_i2s,
+		.round_rate	= s3c2412_roundrate_clksrc,
+	},
 };
 
 static int s3c2412_setparent_cam(struct clk *clk, struct clk *parent)
@@ -438,10 +450,12 @@ static int s3c2412_setrate_cam(struct clk *clk, unsigned long rate)
 static struct clk clk_cam = {
 	.name		= "camif-upll",	/* same as 2440 name */
 	.id		= -1,
-	.get_rate	= s3c2412_getrate_cam,
-	.set_rate	= s3c2412_setrate_cam,
-	.set_parent	= s3c2412_setparent_cam,
-	.round_rate	= s3c2412_roundrate_clksrc,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2412_getrate_cam,
+		.set_rate	= s3c2412_setrate_cam,
+		.set_parent	= s3c2412_setparent_cam,
+		.round_rate	= s3c2412_roundrate_clksrc,
+	},
 };
 
 /* standard clock definitions */
diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index d1c29b2..3dc2426 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -98,8 +98,10 @@ static struct clk s3c2440_clk_cam = {
 static struct clk s3c2440_clk_cam_upll = {
 	.name		= "camif-upll",
 	.id		= -1,
-	.set_rate	= s3c2440_camif_upll_setrate,
-	.round_rate	= s3c2440_camif_upll_round,
+	.ops		= &(struct clk_ops) {
+		.set_rate	= s3c2440_camif_upll_setrate,
+		.round_rate	= s3c2440_camif_upll_round,
+	},
 };
 
 static struct clk s3c2440_clk_ac97 = {
diff --git a/arch/arm/mach-s3c2442/clock.c b/arch/arm/mach-s3c2442/clock.c
index ea1aa1f..d9b692a 100644
--- a/arch/arm/mach-s3c2442/clock.c
+++ b/arch/arm/mach-s3c2442/clock.c
@@ -109,8 +109,10 @@ static struct clk s3c2442_clk_cam = {
 static struct clk s3c2442_clk_cam_upll = {
 	.name		= "camif-upll",
 	.id		= -1,
-	.set_rate	= s3c2442_camif_upll_setrate,
-	.round_rate	= s3c2442_camif_upll_round,
+	.ops		= &(struct clk_ops) {
+		.set_rate	= s3c2442_camif_upll_setrate,
+		.round_rate	= s3c2442_camif_upll_round,
+	},
 };
 
 static int s3c2442_clk_add(struct sys_device *sysdev)
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 2785d69..91db4f5 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -187,7 +187,9 @@ static int s3c2443_setparent_epllref(struct clk *clk, struct clk *parent)
 static struct clk clk_epllref = {
 	.name		= "epllref",
 	.id		= -1,
-	.set_parent	= s3c2443_setparent_epllref,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2443_setparent_epllref,
+	},
 };
 
 static unsigned long s3c2443_getrate_mdivclk(struct clk *clk)
@@ -205,7 +207,9 @@ static struct clk clk_mdivclk = {
 	.name		= "mdivclk",
 	.parent		= &clk_mpllref,
 	.id		= -1,
-	.get_rate	= s3c2443_getrate_mdivclk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_mdivclk,
+	},
 };
 
 static int s3c2443_setparent_msysclk(struct clk *clk, struct clk *parent)
@@ -232,7 +236,9 @@ static struct clk clk_msysclk = {
 	.name		= "msysclk",
 	.parent		= &clk_xtal,
 	.id		= -1,
-	.set_parent	= s3c2443_setparent_msysclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2443_setparent_msysclk,
+	},
 };
 
 /* armdiv
@@ -273,7 +279,9 @@ static int s3c2443_setparent_armclk(struct clk *clk, struct clk *parent)
 static struct clk clk_arm = {
 	.name		= "armclk",
 	.id		= -1,
-	.set_parent	= s3c2443_setparent_armclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2443_setparent_armclk,
+	},
 };
 
 /* esysclk
@@ -302,7 +310,9 @@ static struct clk clk_esysclk = {
 	.name		= "esysclk",
 	.parent		= &clk_epll,
 	.id		= -1,
-	.set_parent	= s3c2443_setparent_esysclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2443_setparent_esysclk,
+	},
 };
 
 /* uartclk
@@ -341,9 +351,11 @@ static struct clk clk_uart = {
 	.name		= "uartclk",
 	.id		= -1,
 	.parent		= &clk_esysclk,
-	.get_rate	= s3c2443_getrate_uart,
-	.set_rate	= s3c2443_setrate_uart,
-	.round_rate	= s3c2443_roundrate_clksrc16,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_uart,
+		.set_rate	= s3c2443_setrate_uart,
+		.round_rate	= s3c2443_roundrate_clksrc16,
+	},
 };
 
 /* hsspi
@@ -384,9 +396,11 @@ static struct clk clk_hsspi = {
 	.parent		= &clk_esysclk,
 	.ctrlbit	= S3C2443_SCLKCON_HSSPICLK,
 	.enable		= s3c2443_clkcon_enable_s,
-	.get_rate	= s3c2443_getrate_hsspi,
-	.set_rate	= s3c2443_setrate_hsspi,
-	.round_rate	= s3c2443_roundrate_clksrc4,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_hsspi,
+		.set_rate	= s3c2443_setrate_hsspi,
+		.round_rate	= s3c2443_roundrate_clksrc4,
+	},
 };
 
 /* usbhost
@@ -426,9 +440,11 @@ static struct clk clk_usb_bus_host = {
 	.parent		= &clk_esysclk,
 	.ctrlbit	= S3C2443_SCLKCON_USBHOST,
 	.enable		= s3c2443_clkcon_enable_s,
-	.get_rate	= s3c2443_getrate_usbhost,
-	.set_rate	= s3c2443_setrate_usbhost,
-	.round_rate	= s3c2443_roundrate_clksrc4,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_usbhost,
+		.set_rate	= s3c2443_setrate_usbhost,
+		.round_rate	= s3c2443_roundrate_clksrc4,
+	},
 };
 
 /* clk_hsmcc_div
@@ -468,9 +484,11 @@ static struct clk clk_hsmmc_div = {
 	.name		= "hsmmc-div",
 	.id		= -1,
 	.parent		= &clk_esysclk,
-	.get_rate	= s3c2443_getrate_hsmmc_div,
-	.set_rate	= s3c2443_setrate_hsmmc_div,
-	.round_rate	= s3c2443_roundrate_clksrc4,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_hsmmc_div,
+		.set_rate	= s3c2443_setrate_hsmmc_div,
+		.round_rate	= s3c2443_roundrate_clksrc4,
+	},
 };
 
 static int s3c2443_setparent_hsmmc(struct clk *clk, struct clk *parent)
@@ -505,7 +523,9 @@ static struct clk clk_hsmmc = {
 	.id		= -1,
 	.parent		= &clk_hsmmc_div,
 	.enable		= s3c2443_enable_hsmmc,
-	.set_parent	= s3c2443_setparent_hsmmc,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2443_setparent_hsmmc,
+	},
 };
 
 /* i2s_eplldiv
@@ -543,9 +563,11 @@ static struct clk clk_i2s_eplldiv = {
 	.name		= "i2s-eplldiv",
 	.id		= -1,
 	.parent		= &clk_esysclk,
-	.get_rate	= s3c2443_getrate_i2s_eplldiv,
-	.set_rate	= s3c2443_setrate_i2s_eplldiv,
-	.round_rate	= s3c2443_roundrate_clksrc16,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_i2s_eplldiv,
+		.set_rate	= s3c2443_setrate_i2s_eplldiv,
+		.round_rate	= s3c2443_roundrate_clksrc16,
+	},
 };
 
 /* i2s-ref
@@ -578,7 +600,9 @@ static struct clk clk_i2s = {
 	.parent		= &clk_i2s_eplldiv,
 	.ctrlbit	= S3C2443_SCLKCON_I2SCLK,
 	.enable		= s3c2443_clkcon_enable_s,
-	.set_parent	= s3c2443_setparent_i2s,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2443_setparent_i2s,
+	},
 };
 
 /* cam-if
@@ -618,9 +642,11 @@ static struct clk clk_cam = {
 	.parent		= &clk_esysclk,
 	.ctrlbit	= S3C2443_SCLKCON_CAMCLK,
 	.enable		= s3c2443_clkcon_enable_s,
-	.get_rate	= s3c2443_getrate_cam,
-	.set_rate	= s3c2443_setrate_cam,
-	.round_rate	= s3c2443_roundrate_clksrc16,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_cam,
+		.set_rate	= s3c2443_setrate_cam,
+		.round_rate	= s3c2443_roundrate_clksrc16,
+	},
 };
 
 /* display-if
@@ -660,9 +686,11 @@ static struct clk clk_display = {
 	.parent		= &clk_esysclk,
 	.ctrlbit	= S3C2443_SCLKCON_DISPCLK,
 	.enable		= s3c2443_clkcon_enable_s,
-	.get_rate	= s3c2443_getrate_display,
-	.set_rate	= s3c2443_setrate_display,
-	.round_rate	= s3c2443_roundrate_clksrc256,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_display,
+		.set_rate	= s3c2443_setrate_display,
+		.round_rate	= s3c2443_roundrate_clksrc256,
+	},
 };
 
 /* prediv
@@ -685,7 +713,9 @@ static struct clk clk_prediv = {
 	.name		= "prediv",
 	.id		= -1,
 	.parent		= &clk_msysclk,
-	.get_rate	= s3c2443_prediv_getrate,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_prediv_getrate,
+	},
 };
 
 /* standard clock definitions */
diff --git a/arch/arm/plat-s3c/clock.c b/arch/arm/plat-s3c/clock.c
index 4d01ef1..dd43264 100644
--- a/arch/arm/plat-s3c/clock.c
+++ b/arch/arm/plat-s3c/clock.c
@@ -150,8 +150,8 @@ unsigned long clk_get_rate(struct clk *clk)
 	if (clk->rate != 0)
 		return clk->rate;
 
-	if (clk->get_rate != NULL)
-		return (clk->get_rate)(clk);
+	if (clk->ops != NULL && clk->ops->get_rate != NULL)
+		return (clk->ops->get_rate)(clk);
 
 	if (clk->parent != NULL)
 		return clk_get_rate(clk->parent);
@@ -161,8 +161,8 @@ unsigned long clk_get_rate(struct clk *clk)
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (!IS_ERR(clk) && clk->round_rate)
-		return (clk->round_rate)(clk, rate);
+	if (!IS_ERR(clk) && clk->ops && clk->ops->round_rate)
+		return (clk->ops->round_rate)(clk, rate);
 
 	return rate;
 }
@@ -178,13 +178,14 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	 * the clock may have been made this way by choice.
 	 */
 
-	WARN_ON(clk->set_rate == NULL);
+	WARN_ON(clk->ops == NULL);
+	WARN_ON(clk->ops && clk->ops->set_rate == NULL);
 
-	if (clk->set_rate == NULL)
+	if (clk->ops == NULL || clk->ops->set_rate == NULL)
 		return -EINVAL;
 
 	spin_lock(&clocks_lock);
-	ret = (clk->set_rate)(clk, rate);
+	ret = (clk->ops->set_rate)(clk, rate);
 	spin_unlock(&clocks_lock);
 
 	return ret;
@@ -204,8 +205,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	spin_lock(&clocks_lock);
 
-	if (clk->set_parent)
-		ret = (clk->set_parent)(clk, parent);
+	if (clk->ops && clk->ops->set_parent)
+		ret = (clk->ops->set_parent)(clk, parent);
 
 	spin_unlock(&clocks_lock);
 
@@ -230,6 +231,10 @@ static int clk_default_setrate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+static struct clk_ops clk_ops_def_setrate = {
+	.set_rate	= clk_default_setrate,
+};
+
 struct clk clk_xtal = {
 	.name		= "xtal",
 	.id		= -1,
@@ -251,7 +256,7 @@ struct clk clk_epll = {
 struct clk clk_mpll = {
 	.name		= "mpll",
 	.id		= -1,
-	.set_rate	= clk_default_setrate,
+	.ops		= &clk_ops_def_setrate,
 };
 
 struct clk clk_upll = {
@@ -267,7 +272,6 @@ struct clk clk_f = {
 	.rate		= 0,
 	.parent		= &clk_mpll,
 	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
 };
 
 struct clk clk_h = {
@@ -276,7 +280,7 @@ struct clk clk_h = {
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
+	.ops		= &clk_ops_def_setrate,
 };
 
 struct clk clk_p = {
@@ -285,7 +289,7 @@ struct clk clk_p = {
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
+	.ops		= &clk_ops_def_setrate,
 };
 
 struct clk clk_usb_bus = {
@@ -296,7 +300,6 @@ struct clk clk_usb_bus = {
 };
 
 
-
 struct clk s3c24xx_uclk = {
 	.name		= "uclk",
 	.id		= -1,
diff --git a/arch/arm/plat-s3c/pwm-clock.c b/arch/arm/plat-s3c/pwm-clock.c
index a318215..1808fa8 100644
--- a/arch/arm/plat-s3c/pwm-clock.c
+++ b/arch/arm/plat-s3c/pwm-clock.c
@@ -130,20 +130,22 @@ static int clk_pwm_scaler_set_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+static struct clk_ops clk_pwm_scaler_ops = {
+	.get_rate	= clk_pwm_scaler_get_rate,
+	.set_rate	= clk_pwm_scaler_set_rate,
+	.round_rate	= clk_pwm_scaler_round_rate,
+};
+
 static struct clk clk_timer_scaler[] = {
 	[0]	= {
 		.name		= "pwm-scaler0",
 		.id		= -1,
-		.get_rate	= clk_pwm_scaler_get_rate,
-		.set_rate	= clk_pwm_scaler_set_rate,
-		.round_rate	= clk_pwm_scaler_round_rate,
+		.ops		= &clk_pwm_scaler_ops,
 	},
 	[1]	= {
 		.name		= "pwm-scaler1",
 		.id		= -1,
-		.get_rate	= clk_pwm_scaler_get_rate,
-		.set_rate	= clk_pwm_scaler_set_rate,
-		.round_rate	= clk_pwm_scaler_round_rate,
+		.ops		= &clk_pwm_scaler_ops,
 	},
 };
 
@@ -256,50 +258,46 @@ static int clk_pwm_tdiv_set_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+static struct clk_ops clk_tdiv_ops = {
+	.get_rate	= clk_pwm_tdiv_get_rate,
+	.set_rate	= clk_pwm_tdiv_set_rate,
+	.round_rate	= clk_pwm_tdiv_round_rate,
+};
+
 static struct pwm_tdiv_clk clk_timer_tdiv[] = {
 	[0]	= {
 		.clk	= {
-			.name		= "pwm-tdiv",
-			.parent		= &clk_timer_scaler[0],
-			.get_rate	= clk_pwm_tdiv_get_rate,
-			.set_rate	= clk_pwm_tdiv_set_rate,
-			.round_rate	= clk_pwm_tdiv_round_rate,
+			.name	= "pwm-tdiv",
+			.ops	= &clk_tdiv_ops,
+			.parent	= &clk_timer_scaler[0],
 		},
 	},
 	[1]	= {
 		.clk	= {
-			.name		= "pwm-tdiv",
-			.parent		= &clk_timer_scaler[0],
-			.get_rate	= clk_pwm_tdiv_get_rate,
-			.set_rate	= clk_pwm_tdiv_set_rate,
-			.round_rate	= clk_pwm_tdiv_round_rate,
+			.name	= "pwm-tdiv",
+			.ops	= &clk_tdiv_ops,
+			.parent	= &clk_timer_scaler[0],
 		}
 	},
 	[2]	= {
 		.clk	= {
-			.name		= "pwm-tdiv",
-			.parent		= &clk_timer_scaler[1],
-			.get_rate	= clk_pwm_tdiv_get_rate,
-			.set_rate	= clk_pwm_tdiv_set_rate,
-			.round_rate	= clk_pwm_tdiv_round_rate,
+			.name	= "pwm-tdiv",
+			.ops	= &clk_tdiv_ops,
+			.parent	= &clk_timer_scaler[1],
 		},
 	},
 	[3]	= {
 		.clk	= {
-			.name		= "pwm-tdiv",
-			.parent		= &clk_timer_scaler[1],
-			.get_rate	= clk_pwm_tdiv_get_rate,
-			.set_rate	= clk_pwm_tdiv_set_rate,
-			.round_rate	= clk_pwm_tdiv_round_rate,
+			.name	= "pwm-tdiv",
+			.ops	= &clk_tdiv_ops,
+			.parent	= &clk_timer_scaler[1],
 		},
 	},
 	[4]	= {
 		.clk	= {
-			.name		= "pwm-tdiv",
-			.parent		= &clk_timer_scaler[1],
-			.get_rate	= clk_pwm_tdiv_get_rate,
-			.set_rate	= clk_pwm_tdiv_set_rate,
-			.round_rate	= clk_pwm_tdiv_round_rate,
+			.name	= "pwm-tdiv",
+			.ops	= &clk_tdiv_ops,
+			.parent	= &clk_timer_scaler[1],
 		},
 	},
 };
@@ -356,31 +354,35 @@ static int clk_pwm_tin_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
+static struct clk_ops clk_tin_ops = {
+	.set_parent	= clk_pwm_tin_set_parent,
+};
+
 static struct clk clk_tin[] = {
 	[0]	= {
-		.name		= "pwm-tin",
-		.id		= 0,
-		.set_parent	= clk_pwm_tin_set_parent,
+		.name	= "pwm-tin",
+		.id	= 0,
+		.ops	= &clk_tin_ops,
 	},
 	[1]	= {
-		.name		= "pwm-tin",
-		.id		= 1,
-		.set_parent	= clk_pwm_tin_set_parent,
+		.name	= "pwm-tin",
+		.id	= 1,
+		.ops	= &clk_tin_ops,
 	},
 	[2]	= {
-		.name		= "pwm-tin",
-		.id		= 2,
-		.set_parent	= clk_pwm_tin_set_parent,
+		.name	= "pwm-tin",
+		.id	= 2,
+		.ops	= &clk_tin_ops,
 	},
 	[3]	= {
-		.name		= "pwm-tin",
-		.id		= 3,
-		.set_parent	= clk_pwm_tin_set_parent,
+		.name	= "pwm-tin",
+		.id	= 3,
+		.ops	= &clk_tin_ops,
 	},
 	[4]	= {
-		.name		= "pwm-tin",
-		.id		= 4,
-		.set_parent	= clk_pwm_tin_set_parent,
+		.name	= "pwm-tin",
+		.id	= 4,
+		.ops	= &clk_tin_ops,
 	},
 };
 
diff --git a/arch/arm/plat-s3c24xx/clock-dclk.c b/arch/arm/plat-s3c24xx/clock-dclk.c
index 0afb217..fc81104 100644
--- a/arch/arm/plat-s3c24xx/clock-dclk.c
+++ b/arch/arm/plat-s3c24xx/clock-dclk.c
@@ -161,14 +161,18 @@ static int s3c24xx_clkout_setparent(struct clk *clk, struct clk *parent)
 
 /* external clock definitions */
 
+static struct clk_ops dclk_ops = {
+	.set_parent	= s3c24xx_dclk_setparent,
+	.set_rate	= s3c24xx_set_dclk_rate,
+	.round_rate	= s3c24xx_round_dclk_rate,
+};
+
 struct clk s3c24xx_dclk0 = {
 	.name		= "dclk0",
 	.id		= -1,
 	.ctrlbit	= S3C2410_DCLKCON_DCLK0EN,
 	.enable	        = s3c24xx_dclk_enable,
-	.set_parent	= s3c24xx_dclk_setparent,
-	.set_rate	= s3c24xx_set_dclk_rate,
-	.round_rate	= s3c24xx_round_dclk_rate,
+	.ops		= &dclk_ops,
 };
 
 struct clk s3c24xx_dclk1 = {
@@ -176,19 +180,21 @@ struct clk s3c24xx_dclk1 = {
 	.id		= -1,
 	.ctrlbit	= S3C2410_DCLKCON_DCLK1EN,
 	.enable		= s3c24xx_dclk_enable,
-	.set_parent	= s3c24xx_dclk_setparent,
-	.set_rate	= s3c24xx_set_dclk_rate,
-	.round_rate	= s3c24xx_round_dclk_rate,
+	.ops		= &dclk_ops,
+};
+
+static struct clk_ops clkout_ops = {
+	.set_parent	= s3c24xx_clkout_setparent,
 };
 
 struct clk s3c24xx_clkout0 = {
 	.name		= "clkout0",
 	.id		= -1,
-	.set_parent	= s3c24xx_clkout_setparent,
+	.ops		= &clkout_ops,
 };
 
 struct clk s3c24xx_clkout1 = {
 	.name		= "clkout1",
 	.id		= -1,
-	.set_parent	= s3c24xx_clkout_setparent,
+	.ops		= &clkout_ops,
 };
diff --git a/arch/arm/plat-s3c24xx/s3c244x-clock.c b/arch/arm/plat-s3c24xx/s3c244x-clock.c
index dde41f1..4edf32e 100644
--- a/arch/arm/plat-s3c24xx/s3c244x-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c244x-clock.c
@@ -68,7 +68,9 @@ static int s3c2440_setparent_armclk(struct clk *clk, struct clk *parent)
 static struct clk clk_arm = {
 	.name		= "armclk",
 	.id		= -1,
-	.set_parent	= s3c2440_setparent_armclk,
+	.ops		= &(struct clk_ops) {
+		.set_parent	= s3c2440_setparent_armclk,
+	},
 };
 
 static int s3c244x_clk_add(struct sys_device *sysdev)
diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index adc2e0a..79e4bd7 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -169,9 +169,11 @@ static struct clk clk_arm = {
 	.name		= "armclk",
 	.id		= -1,
 	.parent		= &clk_mout_apll.clk,
-	.get_rate	= s3c64xx_clk_arm_get_rate,
-	.set_rate	= s3c64xx_clk_arm_set_rate,
-	.round_rate	= s3c64xx_clk_arm_round_rate,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c64xx_clk_arm_get_rate,
+		.set_rate	= s3c64xx_clk_arm_set_rate,
+		.round_rate	= s3c64xx_clk_arm_round_rate,
+	},
 };
 
 static unsigned long s3c64xx_clk_doutmpll_get_rate(struct clk *clk)
@@ -186,11 +188,15 @@ static unsigned long s3c64xx_clk_doutmpll_get_rate(struct clk *clk)
 	return rate;
 }
 
+static struct clk_ops clk_dout_ops = {
+	.get_rate	= s3c64xx_clk_doutmpll_get_rate,
+};
+
 static struct clk clk_dout_mpll = {
 	.name		= "dout_mpll",
 	.id		= -1,
 	.parent		= &clk_mout_mpll.clk,
-	.get_rate	= s3c64xx_clk_doutmpll_get_rate,
+	.ops		= &clk_dout_ops,
 };
 
 static struct clk *clkset_spi_mmc_list[] = {
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
index 6b24035..2b3d5b9 100644
--- a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
+++ b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
@@ -73,6 +73,10 @@ static int clk_default_setrate(struct clk *clk, unsigned long rate)
 	return 1;
 }
 
+static struct clk_ops default_setrate = {
+	.set_rate	= clk_default_setrate,
+};
+
 struct clk clk_27m = {
 	.name		= "clk_27m",
 	.id		= -1,
@@ -123,7 +127,7 @@ struct clk clk_hd0 = {
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
+	.ops		= &default_setrate,
 };
 
 struct clk clk_pd0 = {
@@ -132,7 +136,7 @@ struct clk clk_pd0 = {
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
-	.set_rate	= clk_default_setrate,
+	.ops		= &default_setrate,
 };
 
 static int s5pc1xx_clk_gate(void __iomem *reg,
@@ -871,7 +875,9 @@ static struct clk clk_dout_mpll = {
 	.name		= "dout_mpll",
 	.id		= -1,
 	.parent		= &clk_mout_mpll.clk,
-	.get_rate	= s5pc1xx_clk_doutmpll_get_rate,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc1xx_clk_doutmpll_get_rate,
+	},
 };
 
 static unsigned long s5pc1xx_clk_doutmpll2_get_rate(struct clk *clk)
@@ -891,7 +897,9 @@ struct clk clk_dout_mpll2 = {
 	.name		= "dout_mpll2",
 	.id		= -1,
 	.parent		= &clk_mout_mpll.clk,
-	.get_rate	= s5pc1xx_clk_doutmpll2_get_rate,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s5pc1xx_clk_doutmpll2_get_rate,
+	},
 };
 
 static struct clk *clkset_uart_list[] = {
@@ -992,16 +1000,20 @@ static unsigned long s5pc1xx_roundrate_clksrc(struct clk *clk,
 	return rate;
 }
 
+static struct clk_ops s5pc1xx_clksrc_ops = {
+	.set_parent	= s5pc1xx_setparent_clksrc,
+	.get_rate	= s5pc1xx_getrate_clksrc,
+	.set_rate	= s5pc1xx_setrate_clksrc,
+	.round_rate	= s5pc1xx_roundrate_clksrc,
+};
+
 static struct clksrc_clk clk_uart_uclk1 = {
 	.clk	= {
 		.name		= "uclk1",
 		.id		= -1,
 		.ctrlbit        = S5PC100_CLKGATE_SCLK0_UART,
 		.enable		= s5pc1xx_sclk0_ctrl,
-		.set_parent	= s5pc1xx_setparent_clksrc,
-		.get_rate	= s5pc1xx_getrate_clksrc,
-		.set_rate	= s5pc1xx_setrate_clksrc,
-		.round_rate	= s5pc1xx_roundrate_clksrc,
+		.ops		= &s5pc1xx_clksrc_ops,
 	},
 	.shift		= S5PC100_CLKSRC1_UART_SHIFT,
 	.mask		= S5PC100_CLKSRC1_UART_MASK,
diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index 5872f0b..ad4e872 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -150,20 +150,21 @@ void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk)
 	       clk_get_rate(&clk->clk));
 }
 
+static struct clk_ops clksrc_ops = {
+	.set_parent	= s3c_setparent_clksrc,
+	.get_rate	= s3c_getrate_clksrc,
+	.set_rate	= s3c_setrate_clksrc,
+	.round_rate	= s3c_roundrate_clksrc,
+};
+
 void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 {
 	int ret;
 
 	for (; size > 0; size--, clksrc++) {
 		/* fill in the default functions */
-		if (!clksrc->clk.set_parent)
-			clksrc->clk.set_parent = s3c_setparent_clksrc;
-		if (!clksrc->clk.get_rate)
-			clksrc->clk.get_rate = s3c_getrate_clksrc;
-		if (!clksrc->clk.set_rate)
-			clksrc->clk.set_rate = s3c_setrate_clksrc;
-		if (!clksrc->clk.round_rate)
-			clksrc->clk.round_rate = s3c_roundrate_clksrc;
+		if (!clksrc->clk.ops)
+			clksrc->clk.ops = &clksrc_ops;
 
 		s3c_set_clksrc(clksrc);
 
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index d86af84..43324af 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -11,6 +11,30 @@
 
 #include <linux/spinlock.h>
 
+struct clk;
+
+/**
+ * struct clk_ops - standard clock operations
+ * @set_rate: set the clock rate, see clk_set_rate().
+ * @get_rate: get the clock rate, see clk_get_rate().
+ * @round_rate: round a given clock rate, see clk_round_rate().
+ * @set_parent: set the clock's parent, see clk_set_parent().
+ *
+ * Group the common clock implementations together so that we
+ * don't have to keep setting the same fiels again. We leave
+ * enable in struct clk.
+ *
+ * Adding an extra layer of indirection into the process should
+ * not be a problem as it is unlikely these operations are going
+ * to need to be called quickly.
+ */
+struct clk_ops {
+	int		    (*set_rate)(struct clk *c, unsigned long rate);
+	unsigned long	    (*get_rate)(struct clk *c);
+	unsigned long	    (*round_rate)(struct clk *c, unsigned long rate);
+	int		    (*set_parent)(struct clk *c, struct clk *parent);
+};
+
 struct clk {
 	struct list_head      list;
 	struct module        *owner;
@@ -21,11 +45,8 @@ struct clk {
 	unsigned long         rate;
 	unsigned long         ctrlbit;
 
+	struct clk_ops		*ops;
 	int		    (*enable)(struct clk *, int enable);
-	int		    (*set_rate)(struct clk *c, unsigned long rate);
-	unsigned long	    (*get_rate)(struct clk *c);
-	unsigned long	    (*round_rate)(struct clk *c, unsigned long rate);
-	int		    (*set_parent)(struct clk *c, struct clk *parent);
 };
 
 /* other clocks which may be registered by board support */
-- 
1.5.6.5
