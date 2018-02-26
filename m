From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 26 Feb 2018 09:20:07 +0000
Subject: [SIL2review] [PATCH] i2c: cadence: Fix PM device usage count
In-Reply-To: <20180224224238.nlr3mrifwngjzkrz@agrajag.zerfleddert.de>
References: <20180224224238.nlr3mrifwngjzkrz@agrajag.zerfleddert.de>
Message-ID: <20180226092007.GC6152@osadl.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 11:42:38PM +0100, Tobias Jordan wrote:
> pm_runtime_get_sync() increases the device's usage count even when
> reporting an error, so add a call to pm_runtime_put_noidle() in the
> error branch.
> 
> Fixes: 7fa32329ca03 ("i2c: cadence: Move to sensible power management")
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> ---
> This is one of a number of patches for problems found using coccinelle
> scripting in the SIL2LinuxMP project. The patch has been compile-tested;
> it's based on linux-next-20180223.
> 
> For a discussion of the corresponding issue, see
> https://marc.info/?l=linux-pm&m=151904483924999&w=2

just wondering if that should not be above the --- as:

Link: https://marc.info/?l=linux-pm&m=151904483924999&w=2

notably as the discussion about why not to fix it in __pm_runtime_resume
would seem reasonable to carry into the mainline logs.

thx!
hforat

> 
>  drivers/i2c/busses/i2c-cadence.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b13605718291..898faa7fbac5 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -574,8 +574,10 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	bool hold_quirk;
>  
>  	ret = pm_runtime_get_sync(id->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(id->dev);
>  		return ret;
> +	}
>  	/* Check if the bus is free */
>  	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA) {
>  		ret = -EAGAIN;
> -- 
> 2.11.0
> 
> _______________________________________________
> SIL2review mailing list
> SIL2review at lists.osadl.org
> https://lists.osadl.org/mailman/listinfo/sil2review
