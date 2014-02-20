From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Feb 2014 13:03:40 +0100
Subject: [PATCH v2 2/2] regulator: core: Replace direct ops->disable usage
In-Reply-To: <1392894472-11956-3-git-send-email-mpa@pengutronix.de>
References: <1392894472-11956-1-git-send-email-mpa@pengutronix.de>
 <1392894472-11956-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20140220120340.GB21048@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 12:07:52PM +0100, Markus Pargmann wrote:
> There are many places where ops->disable is called directly. Instead we
> should use _regulator_do_disable() which also handles gpio regulators.
> 
> Cc: <stable@vger.kernel.org> # 3.10+
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/regulator/core.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 017f5cb..a0c916f 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c

...

> @@ -3641,12 +3637,10 @@ int regulator_suspend_finish(void)
>  		} else {
>  			if (!have_full_constraints())
>  				goto unlock;
> -			if (!ops->disable)
> -				goto unlock;
>  			if (!_regulator_is_enabled(rdev))
>  				goto unlock;
>  
> -			error = ops->disable(rdev);
> +			error = _regulator_do_disable(rdev);

ops is unused and creates a compile warning. I will resend later with
the 'ops' variable removed from the function.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/5e70776e/attachment.sig>
