From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 11 Sep 2012 23:51:12 +0200
Subject: [PATCHv7 20/23] i2c: omap: switch to threaded IRQ support
In-Reply-To: <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120911215112.GA27031@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:12:15PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> for OMAP2, we can easily switch over to threaded
> IRQs on the I2C driver. This will allow us to
> spend less time in hardirq context.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> [Trivial formating changes]
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   43 +++++++++++++++++++++++++++++++++++-----
>  1 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4a696bd..e391370 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -176,6 +176,7 @@ enum {
>  #define I2C_OMAP_ERRATA_I462		(1 << 1)
>  
>  struct omap_i2c_dev {
> +	spinlock_t		lock;		/* IRQ synchronization */
>  	struct device		*dev;
>  	void __iomem		*base;		/* virtual */
>  	int			irq;
> @@ -854,9 +855,30 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
>  }
>  
>  static irqreturn_t
> -omap_i2c_isr(int this_irq, void *dev_id)
> +omap_i2c_isr(int irq, void *dev_id)
>  {
>  	struct omap_i2c_dev *dev = dev_id;
> +	irqreturn_t ret = IRQ_HANDLED;

Shouldn't that be IRQ_NONE?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/1a30fec3/attachment.sig>
