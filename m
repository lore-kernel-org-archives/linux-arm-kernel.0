From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 22 Oct 2014 10:38:56 -0700
Subject: [PATCH v2 1/3] PM / clock_ops: Add pm_clk_add_clk()
In-Reply-To: <1413809764-21995-2-git-send-email-grygorii.strashko@ti.com>
References: <1413809764-21995-1-git-send-email-grygorii.strashko@ti.com>
 <1413809764-21995-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141022173856.GB28104@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 03:56:02PM +0300, Grygorii Strashko wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The existing pm_clk_add() allows to pass a clock by con_id. However,
> when referring to a specific clock from DT, no con_id is available.
> 
> Add pm_clk_add_clk(), which allows to specify the struct clk * directly.
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> 
>  Pay attantion pls, that there is another series of patches
>  which have been posted already and which depends from this patch
>    "[PATCH v4 0/3] ARM: rk3288 : Add PM Domain support"
>    https://lkml.org/lkml/2014/10/20/105
> 
>  drivers/base/power/clock_ops.c | 41 +++++++++++++++++++++++++++++++----------
>  include/linux/pm_clock.h       |  8 ++++++++
>  2 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 7836930..f14b767 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -53,7 +53,8 @@ static inline int __pm_clk_enable(struct device *dev, struct clk *clk)
>   */
>  static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>  {
> -	ce->clk = clk_get(dev, ce->con_id);
> +	if (!ce->clk)
> +		ce->clk = clk_get(dev, ce->con_id);
>  	if (IS_ERR(ce->clk)) {
>  		ce->status = PCE_STATUS_ERROR;
>  	} else {
> @@ -63,15 +64,8 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>  	}
>  }
>  
> -/**
> - * pm_clk_add - Start using a device clock for power management.
> - * @dev: Device whose clock is going to be used for power management.
> - * @con_id: Connection ID of the clock.
> - *
> - * Add the clock represented by @con_id to the list of clocks used for
> - * the power management of @dev.
> - */
> -int pm_clk_add(struct device *dev, const char *con_id)
> +static int __pm_clk_add(struct device *dev, const char *con_id,
> +			struct clk *clk)
>  {
>  	struct pm_subsys_data *psd = dev_to_psd(dev);
>  	struct pm_clock_entry *ce;
> @@ -93,6 +87,8 @@ int pm_clk_add(struct device *dev, const char *con_id)
>  			kfree(ce);
>  			return -ENOMEM;
>  		}
> +	} else {
> +		ce->clk = clk;
>  	}
>  
>  	pm_clk_acquire(dev, ce);
> @@ -104,6 +100,31 @@ int pm_clk_add(struct device *dev, const char *con_id)
>  }
>  
>  /**
> + * pm_clk_add - Start using a device clock for power management.
> + * @dev: Device whose clock is going to be used for power management.
> + * @con_id: Connection ID of the clock.
> + *
> + * Add the clock represented by @con_id to the list of clocks used for
> + * the power management of @dev.
> + */
> +int pm_clk_add(struct device *dev, const char *con_id)
> +{
> +	return __pm_clk_add(dev, con_id, NULL);

Bikeshedding: why do we need __pm_clk_add() and not simply have
"canonical" pm_clk_add_clk() and then do:

int pm_clk_add(struct device *dev, const char *con_id)
{
	struct clk *clk;

	clk = clk_get(dev, con_id);
	...
	return pm_clk_add_clk(dev, clk);
}

Thanks.

-- 
Dmitry
