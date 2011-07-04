From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon,  4 Jul 2011 15:52:17 +0200
Subject: [BUGFIX][PATCH] mach-mx5: fix the I2C clock parents
In-Reply-To: <19985.49912.927038.73866@ipc1.ka-ro>
References: <19985.49912.927038.73866@ipc1.ka-ro>
Message-ID: <1309787537-20664-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock from which the I2C timing is derived is the ipg_perclk not ipg_clk.

I2C bus frequency was lower by a factor of ~8 due to the clock divider
calculation being based on 66.5MHz IPG clock while the bus actually
uses 8MHz ipg_perclk.

Kernel version: 3.0.0-rc2 branch 'imx-for-next' of git://git.pengutronix.de/git/imx/linux-2.6

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 699b0d2..ff16d86 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1282,13 +1282,13 @@ DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
 
 /* I2C */
 DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
-	NULL, NULL, &ipg_clk, NULL);
+	NULL, NULL, &ipg_perclk, NULL);
 DEFINE_CLOCK(i2c2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG10_OFFSET,
-	NULL, NULL, &ipg_clk, NULL);
+	NULL, NULL, &ipg_perclk, NULL);
 DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
 	NULL, NULL, &ipg_clk, NULL);
 DEFINE_CLOCK(i2c3_mx53_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
-	NULL, NULL, &ipg_clk, NULL);
+	NULL, NULL, &ipg_perclk, NULL);
 
 /* FEC */
 DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
-- 
1.5.6.5
