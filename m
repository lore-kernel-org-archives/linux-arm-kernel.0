From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 01 Jun 2010 10:51:16 +0200
Subject: [PATCH V2] i2c-imx: do not allow interruptions when waiting for
	I2C to complete
In-Reply-To: <1274962561-17007-1-git-send-email-mkl@pengutronix.de>
References: <1274962561-17007-1-git-send-email-mkl@pengutronix.de>
Message-ID: <4C04CA04.6000207@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde wrote:
> The i2c_imx_trx_complete() function is using
> wait_event_interruptible_timeout() to wait for the I2C controller to
> signal that it has completed an I2C bus operation. If the process that
> causes the I2C operation receives a signal, the wait will be
> interrupted, returning an error. It is better to let the I2C operation
> finished before handling the signal (i.e. returning into userspace).
> 
> It is safe to use wait_event_timeout() instead, because the timeout
> will allow the process to exit if the I2C bus hangs. It's also better
> to allow the I2C operation to finish, because unacknowledged I2C
> operations can cause the I2C bus to hang.

Ping, can someone please comment the patch and/or push upstream.

Marc
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> V2: Remove check for "result < 0" as commented by Wolfram Sang.
> 
>  drivers/i2c/busses/i2c-imx.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d1ff940..58df809 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -161,13 +161,10 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>  {
>  	int result;
>  
> -	result = wait_event_interruptible_timeout(i2c_imx->queue,
> +	result = wait_event_timeout(i2c_imx->queue,
>  		i2c_imx->i2csr & I2SR_IIF, HZ / 10);
>  
> -	if (unlikely(result < 0)) {
> -		dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
> -		return result;
> -	} else if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> +	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
>  		return -ETIMEDOUT;
>  	}
> @@ -295,7 +292,7 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  		i2c_imx->i2csr = temp;
>  		temp &= ~I2SR_IIF;
>  		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
> -		wake_up_interruptible(&i2c_imx->queue);
> +		wake_up(&i2c_imx->queue);
>  		return IRQ_HANDLED;
>  	}
>  


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100601/5cbd7706/attachment.sig>
