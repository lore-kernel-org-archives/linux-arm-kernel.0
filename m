From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 09:56:27 +0200
Subject: [PATCHv2 7/7] i2c: omap: Restore i2c context always
In-Reply-To: <1352025873-27492-8-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-8-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121105075627.GH32468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 04, 2012 at 04:14:33PM +0530, Shubhrajyoti D wrote:
> Currently the restore is done based on the flag
> OMAP_I2C_FLAG_RESET_REGS_POSTIDLE.
> 
> This helps the following
> - The driver is always capable of restoring regardless
> of the off mode support being there or not.
> 
> - While testing omap2430 it is found that in case of certain
> error paths (timeout) a reset is done. However the restore
> never happens as it is dependent on the POSTIDLE flag.
> The other option would be to call a restore in the reset
> case. As there are only a few registers to be restored
> the penalty in the idle case should not be much.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Looks ok to me, one less unnecessary flag.

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Todo: the flag could be deleted if the patch is accepted.
> 
>  drivers/i2c/busses/i2c-omap.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 70d43b7..f66c5ab 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1314,8 +1314,7 @@ static int omap_i2c_runtime_resume(struct device *dev)
>  	if (!_dev->regs)
>  		return 0;
>  
> -	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> -		__omap_i2c_init(_dev);
> +	__omap_i2c_init(_dev);
>  
>  	return 0;
>  }
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/16f65478/attachment.sig>
