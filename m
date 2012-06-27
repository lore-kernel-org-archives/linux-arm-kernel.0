From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Jun 2012 10:13:38 +0800
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201206270330.31669.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <20120611063903.GD2552@S2101-09.ap.freescale.net>
 <201206111254.21766.marex@denx.de>
 <201206270330.31669.marex@denx.de>
Message-ID: <20120627021336.GA9787@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 03:30:31AM +0200, Marek Vasut wrote:
> Ok, I managed to replicate it just now. Scrap my previous email.
> 
> Still, any idea what can cause this?
> 
I just spent some time on it.  It looks like a document issue (dammit).

The HW_I2C_TIMING2 EXAMPLE tells the value is 0x0015000d which is the
one you looked at and used.  But the register field figure tells it's
0x00300030, which seems the real case.

The mxs_i2c_reset at probe changes the value to 0x0015000d which causes
the first time playback nonfunctional, but the mxs_i2c_reset call in
mxs_i2c_xfer_msg happens to reset the value back to 0x00300030, and
then second time playback starts working.

The changes below get everything work fine, both 100k and 400k.  So
with the changes in, you can add:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

--8<---

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e38be56..c2467e9 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -112,13 +112,13 @@ struct mxs_i2c_speed_config {
 const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
        .timing0        = 0x00780030,
        .timing1        = 0x00800030,
-       .timing2        = 0x0015000d,
+       .timing2        = 0x00300030,
 };

 const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
        .timing0        = 0x000f0007,
        .timing1        = 0x001f000f,
-       .timing2        = 0x0015000d,
+       .timing2        = 0x00300030,
 };
