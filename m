From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 May 2012 15:06:04 -0700
Subject: [PATCHv9 07/10] I2C: OMAP: Handle error check for pm runtime
In-Reply-To: <1335969135-20858-8-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:12 +0530")
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <1335969135-20858-8-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87likfkjar.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> If PM runtime get_sync fails return with the error
> so that no further reads/writes goes through the interface.
> This will avoid possible abort. Add a error message in case
> of failure with the cause of the failure.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 44e8cfa..a72874e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -585,7 +585,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	int i;
>  	int r;
>  
> -	pm_runtime_get_sync(dev->dev);
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0)
> +		return r;

nit: please use IS_ERR_VALUE() 

Kevin
