From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 23 Jul 2012 22:03:59 +0200
Subject: [PATCH] I2C: MV64XYZ: Add Device Tree support
In-Reply-To: <1342954295-13279-1-git-send-email-andrew@lunn.ch>
References: <1342954295-13279-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120723200359.GB31645@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 12:51:35PM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Rather than
> pass the N & M factors in DT, use the more standard clock-frequency
> property. Calculate N & M at run time. In order to do this, we need to
> know tclk. So the driver uses clk_get() etc in order to get the clock
> and clk_get_rate() to determine the tclk rate. Not all platforms
> however have CLK, so some #ifdefery is needed to ensure the driver
> still compiles when CLK is not available.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Sparse complained about this:

drivers/i2c/busses/i2c-mv64xxx.c:584:54: warning: incorrect type in argument 3 (different signedness)
drivers/i2c/busses/i2c-mv64xxx.c:584:54:    expected unsigned int [usertype] *out_value
drivers/i2c/busses/i2c-mv64xxx.c:584:54:    got int *<noident>
drivers/i2c/busses/i2c-mv64xxx.c:586:41: warning: incorrect type in argument 3 (different signedness)
drivers/i2c/busses/i2c-mv64xxx.c:586:41:    expected int *best_n
drivers/i2c/busses/i2c-mv64xxx.c:586:41:    got unsigned int *<noident>
drivers/i2c/busses/i2c-mv64xxx.c:586:60: warning: incorrect type in argument 4 (different signedness)
drivers/i2c/busses/i2c-mv64xxx.c:586:60:    expected int *best_m
drivers/i2c/busses/i2c-mv64xxx.c:586:60:    got unsigned int *<noident>

I applied your patch with the following fix to -next. Let me know if you agree
with that.

Regards,

   Wolfram

--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -537,8 +537,8 @@ mv64xxx_calc_freq(const int tclk, const int n, const int m)
 }
 
 static bool __devinit
-mv64xxx_find_baud_factors(const int req_freq, const int tclk, int *best_n,
-                         int *best_m)
+mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
+                         u32 *best_m)
 {
        int freq, delta, best_delta = INT_MAX;
        int m, n;
@@ -564,8 +564,7 @@ static int __devinit
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
                  struct device_node *np)
 {
-       int bus_freq;
-       int tclk;
+       u32 bus_freq, tclk;
        int rc = 0;
 
        /* CLK is mandatory when using DT to describe the i2c bus. We

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/eb671a3b/attachment.sig>
