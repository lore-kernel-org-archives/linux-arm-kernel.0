From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sun, 12 Jul 2015 17:31:42 +0200
Subject: [PATCH] i2c: core: only use set_scl for bus recovery after
 calling prepare_recovery
In-Reply-To: <1436366106-11779-1-git-send-email-jlu@pengutronix.de>
References: <1436366106-11779-1-git-send-email-jlu@pengutronix.de>
Message-ID: <55A2885E.3000002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/15 16:35, Jan Luebbe wrote:
> Using set_scl may be ineffective before calling the driver specific
> prepare_recovery callback, which might change into a test mode. So
> instead of setting SCL in i2c_generic_scl_recovery, move it to
> i2c_generic_recovery (after the optional prepare_recovery).
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

I've tested it with oscilloscope on Beagle Bone Black, makes sense with
your next patch, so:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  drivers/i2c/i2c-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 069a41f116dd..be992b3e0be8 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -567,6 +567,9 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
>  	if (bri->prepare_recovery)
>  		bri->prepare_recovery(adap);
>  
> +	bri->set_scl(adap, val);
> +	ndelay(RECOVERY_NDELAY);
> +
>  	/*
>  	 * By this time SCL is high, as we need to give 9 falling-rising edges
>  	 */
> @@ -597,7 +600,6 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
>  
>  int i2c_generic_scl_recovery(struct i2c_adapter *adap)
>  {
> -	adap->bus_recovery_info->set_scl(adap, 1);
>  	return i2c_generic_recovery(adap);
>  }
>  EXPORT_SYMBOL_GPL(i2c_generic_scl_recovery);
> 
