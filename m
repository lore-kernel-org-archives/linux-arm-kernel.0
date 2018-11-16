From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 16 Nov 2018 17:01:28 +0100
Subject: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <20181116145937.27660-2-phil.edworthy@renesas.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
Message-ID: <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 02:59:32PM +0000, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a clock required to
> access a peripheral's registers that is always enabled on some devices.
> This adds the of_clk_get_by_name_optional() function for this purpose.
> 
> This function behaves the same as of_clk_get_by_name() except that it
> will return NULL instead of -ENOENT. This allows for simpler error
> handling in the callers.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> *Warning*
> This changes the return values for of_clk_get_by_name() in some cases.
> If the name arg is non-NULL, and the "clock-names" OF property can't be
> found or the name is not in that prop, the code used to return -EINVAL,
> but will now return -ENOENT.
> Note that before and after this patch, if name=NULL and no "clocks" OF
> property has been found, of_clk_get_by_name() returns -ENOENT.
> 
> I believe the new behaviour is correct. I cannot find any callers to
> of_clk_get_by_name() that explicitly check for -EINVAL or -ENOENT, but
> there is the possibility that something will break at runtime with this
> change.
> 
> v6:
>  - Rework the __of_clk_get_by_name() logic so as to avoid duplicate tests.
> v5:
>  - Simplified the code by handling all the error conditions on exit
> v4:
>  - For optional named clocks of_property_match_string() will return
>    -EINVAL if the "clock-names" property is missing, or -ENODATA if
>    the specified clock name in the "clock-names" property is missing.
>    If we then call __of_clk_get() with these errors as the index, we
>    get clk = -EINVAL. This is then filtered later on so users don't
>    see it. However, if the clock is not named, __of_clk_get() will
>    return -ENOENT is the clock provide is not there.
>    So for optional named clocks, use index to determine if the clock
>    provider is there or not, and for unnamed clocks, simply check if
>    __of_clk_get() returns -ENOENT.
> 
> v3:
>  - Fix check for clock not present. __of_clk_get() returns -EINVAL
>    if it's not there. Cover case of when there is no clock name.
>  - of_clk_get_by_name_optional() should return NULL if !np.
>  - Add dummy version of of_clk_get_by_name_optional() for the
>    !OF || !COMMON_CLK case.
> ---
>  drivers/clk/clkdev.c | 76 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/clk.h  |  6 ++++
>  2 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 9ab3db8b3988..0c655d1ba1d9 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -52,9 +52,19 @@ struct clk *of_clk_get(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL(of_clk_get);
>  
> +/*
> + * This function tries to find a clock provider.
> + * If a name is provided, the function looks for a clock with that name in the
> + * OF node's "clock-names" property. If not found, the function will try the
> + * parent node and so on until a matching property is found or we reach the
> + * top of the tree.

I think the comment here could be improved. I think if you replace the
last sentence by:

	If not found (i.e. either there is no "clock-names" property or
	the "clock-names" property doesn't include the name to look up),
	the function will try the parent node and so on until ...

Other than that I think the patch is fine, but maybe it would be easier
to review if you split it in two patches. The first patch to implement
the changed behaviour you mention in the warning above and only then the
addition of the optional handling.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
