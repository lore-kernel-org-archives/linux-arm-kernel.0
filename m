From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 15:52:49 +0300
Subject: [PATCH v2 4/7] i2c: omap: in case of VERSION_2 read
 IRQSTATUS_RAW but write to IRQSTATUS
In-Reply-To: <50893665.60604@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-5-git-send-email-balbi@ti.com>
 <50893665.60604@ti.com>
Message-ID: <20121025125249.GK21217@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 06:23:57PM +0530, Santosh Shilimkar wrote:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> >on OMAP4+ we want to read IRQSTATUS_RAW register,
> >instead of IRQSTATUS. The reason being that IRQSTATUS
> >will only contain the bits which were enabled on
> >IRQENABLE_SET and that will break when we need to
> >poll for a certain bit which wasn't enabled as an
> >IRQ source.
> >
> >One such case is after we finish converting to
> >deferred stop bit, we will have to poll for ARDY
> >bit before returning control for the client driver
> >in order to prevent us from trying to start a
> >transfer on a bus which is already busy.
> >
> >Note, however, that omap-i2c.c needs a big rework
> >on register definition and register access. Such
> >work will be done in a separate series of patches.
> >
> >Cc: Benoit Cousson <b-cousson@ti.com>
> >Signed-off-by: Felipe Balbi <balbi@ti.com>
> >---
> >  drivers/i2c/busses/i2c-omap.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> >index b004126..20f9ad6 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -271,8 +271,18 @@ static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
> >
> >  static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> >  {
> >-	return __raw_readw(i2c_dev->base +
> >+	/* if we are OMAP_I2C_IP_VERSION_2, we need to read from
> >+	 * IRQSTATUS_RAW, but write to IRQSTATUS
> >+	 */
> >+	if ((i2c_dev->dtrev == OMAP_I2C_IP_VERSION_2) &&
> >+			(reg == OMAP_I2C_STAT_REG)) {
> Doing this check on every I2C register read seems to
> expensive to me. Can you not sort this in init with some offset
> which can be 0 or non zero ?  Sorry in case this is already dicussed.

could be. I didn't go that route because I'm planning a complete rewrite
of all register accesses. The way it's done today is completely broken
and already expensive (with reg_shift and different map tables and so
on).

If it's really a big of a deal, I can try to find another way, maybe
just adding omap_i2c_read_stat() and limit the version check just to
I2C_STAT reads would do it for now...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/d7a764f7/attachment.sig>
