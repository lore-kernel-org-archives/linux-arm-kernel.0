From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 12:20:50 +0100
Subject: [PATCH v2] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <1352102683-2243-1-git-send-email-balbi@ti.com>
References: <20121102085447.GE17063@arwen.pp.htv.fi>
 <1352102683-2243-1-git-send-email-balbi@ti.com>
Message-ID: <20121114112050.GG5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 10:04:43AM +0200, Felipe Balbi wrote:
> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.
> 
> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
> 
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
> 
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	- use barrier() instead of wmb()
> 
> Note: this version was compile-tested only
> 
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..ba03bec 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
>  	dev->buf = msg->buf;
>  	dev->buf_len = msg->len;
> +	barrier();

I agree adding a comment here is a good idea.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/5b44e45c/attachment.sig>
