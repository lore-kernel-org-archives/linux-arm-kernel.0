From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Apr 2013 14:23:13 +0200
Subject: [PATCH] i2c: s3c2410: Add SMBus emulation for block read
In-Reply-To: <1364308196-10101-1-git-send-email-prasanna.ps@samsung.com>
References: <1364308196-10101-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <20130409122313.GD4913@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 26, 2013 at 07:59:56PM +0530, Prasanna Kumar wrote:
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 17c5c37..e4ab9ea 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -309,6 +309,12 @@ static inline int is_lastmsg(struct s3c24xx_i2c *i2c)
>  
>  static inline int is_msglast(struct s3c24xx_i2c *i2c)
>  {
> +	/* msg->len is always 1 for the first byte of smbus block read.
> +	 * Actual length will be read from slave. More bytes will be
> +	 * read according to the length then. */
> +	if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
> +		return 0;
> +
>  	return i2c->msg_ptr == i2c->msg->len-1;
>  }
>  
> @@ -448,6 +454,9 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
>  		byte = readb(i2c->regs + S3C2410_IICDS);
>  		i2c->msg->buf[i2c->msg_ptr++] = byte;
>  
> +		/* Add actual length to read for smbus block read */
> +		if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
> +			i2c->msg->len += byte;
>   prepare_read:
>  		if (is_msglast(i2c)) {
I don't know if that can happen, but if the block has length 0 (that is,
only consists of a single byte that is read as 0) the is_msglast() test
returns 0 which might be wrong. Maybe even if it cannot regularily
happen handle it in a sane way?

Also I wonder if error checking for byte > I2C_SMBUS_BLOCK_MAX would be
needed to prevent a buffer overrun?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
