From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 12 Sep 2012 16:03:35 -0700
Subject: [PATCHv8 21/22] i2c: omap: switch over to autosuspend API
In-Reply-To: <1347447496-16793-22-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Wed, 12 Sep 2012 16:28:15 +0530")
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <1347447496-16793-22-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87627iu9mg.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> From: Felipe Balbi <balbi@ti.com>
>
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message starting soon.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

I tracked the PM regression down to this patch.

> ---
>  drivers/i2c/busses/i2c-omap.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 6d38a57..122f517 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -55,6 +55,9 @@
>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  
> +/* timeout for pm runtime autosuspend */
> +#define OMAP_I2C_PM_TIMEOUT		1000	/* ms */
> +
>  /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
>  enum {
>  	OMAP_I2C_REV_REG = 0,
> @@ -645,7 +648,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  	omap_i2c_wait_for_bb(dev);
>  out:
> -	pm_runtime_put(dev->dev);
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);

Reverting this change allows CORE to hit retention again.

I didn't debug this any further, so I'm not sure exactly why the async
suspend works but not the autosuspend.

Kevin
