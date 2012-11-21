From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 21 Nov 2012 01:43:09 +0100
Subject: [RESEND PATCH] S3C24XX: Fix console baud rate guessing
Message-ID: <50ac2947.4969b40a.4ccc.ffff94b6@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Between v3.2 and v3.3 my S3C2440 board started to print garbage on the
console during boot. I nailed the problem down to the default UCON clock
selection, which with this commit has been switched from UCLK to PCLK.

commit c3310fbbeb9db6967900ed22eb3d0bd0bb0e892c
Author: Thomas Abraham <thomas.abraham@linaro.org>
Date:   Mon Oct 24 11:47:57 2011 +0200

    serial: samsung: remove all uses of get_clksrc and set_clksrc
    
    With clkdev based clock lookup support, the clock set and get operation
    using clock names communicated between the samsung uart driver and the
    SoC specific extension can be removed.
    
    In addition to that, for each platform specific extension, add the
    default clock selection, number of clock options for uart baud generator,
    clock selection bit mask and shift values which is required by the
    clkdev support in samsung uart driver.
    
    The default clock selection value 'def_clk_sel' specifies the default clock
    to be used as the source clock for baud rate generator in case the platform
    code does not specify the same.
    
    Cc: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
    Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>


To restore previous functionality, usable console with no UCON nor baud
rate specified, I had to change the default UCON clock back to UCLK.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 samsung.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7f04717..316b703 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1572,7 +1572,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
 		.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
 		.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-		.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL1,
 		.num_clks	= 4,
 		.clksel_mask	= S3C2412_UCON_CLKMASK,
 		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
