From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 9 Dec 2010 16:50:22 +0100
Subject: [PATCH 12/20] mfd/tc3589x: undo gpio module reset during chip init
In-Reply-To: <1291388753-14662-13-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-13-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20101209155021.GW8884@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sundar,

On Fri, Dec 03, 2010 at 08:35:45PM +0530, Sundar Iyer wrote:
> Skip putting the GPIO module into a reset during the chip init.  This makes
> sure to preserve any existing GPIO configurations done by pre-kernel boot code.
> 

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> ---
>  drivers/mfd/tc3589x.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
> index e173f33..fd206fd 100644
> --- a/drivers/mfd/tc3589x.c
> +++ b/drivers/mfd/tc3589x.c
> @@ -247,12 +247,15 @@ static int tc3589x_chip_init(struct tc3589x *tc3589x)
>  
>  	dev_info(tc3589x->dev, "manufacturer: %#x, version: %#x\n", manf, ver);
>  
> -	/* Put everything except the IRQ module into reset */
> +	/*
> +	 * Put everything except the IRQ module into reset;
> +	 * also spare the GPIO module for any pin initialization
> +	 * done during pre-kernel boot
> +	 */
>  	ret = tc3589x_reg_write(tc3589x, TC3589x_RSTCTRL,
>  				TC3589x_RSTCTRL_TIMRST
>  				| TC3589x_RSTCTRL_ROTRST
> -				| TC3589x_RSTCTRL_KBDRST
> -				| TC3589x_RSTCTRL_GPIRST);
> +				| TC3589x_RSTCTRL_KBDRST);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 1.7.2.dirty
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
