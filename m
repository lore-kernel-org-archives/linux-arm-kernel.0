From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Wed, 24 Oct 2012 16:41:11 +0200
Subject: [PATCH 3/8] i2c: omap: fix error checking
In-Reply-To: <1350899218-13624-4-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-4-git-send-email-balbi@ti.com>
Message-ID: <5087FE07.6090504@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 10/22/2012 11:46 AM, Felipe Balbi wrote:
> It's impossible to have Arbitration Lost,
> Read Overflow, and Tranmist Underflow all
> asserted at the same time.
> 
> Those error conditions are mutually exclusive
> so what the code should be doing, instead, is
> check each error flag separataly.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index bea0277..e0eab38 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -587,9 +587,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  		goto err_i2c_init;
>  	}
>  
> -	/* We have an error */
> -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> -			    OMAP_I2C_STAT_XUDF)) {
> +	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
> +			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
> +			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {

Sorry, what is the difference? I didn't understand the optimisation and why now
is more clear. Can you just add a comment?

Michael

>  		ret = -EIO;
>  		goto err_i2c_init;
>  	}
> 
