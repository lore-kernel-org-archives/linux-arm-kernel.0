From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Fri, 21 Jul 2017 11:29:30 +0300
Subject: [PATCH v2 3/5] clk: qcom: gdsc: Add support to control associated
 clks
In-Reply-To: <1500526099-9935-4-git-send-email-rnayak@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
 <1500526099-9935-4-git-send-email-rnayak@codeaurora.org>
Message-ID: <d89fd662-08bb-fdf5-75a0-4af528f6fa70@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

few small comments to get code closer to perfection...

On 07/20/2017 07:48 AM, Rajendra Nayak wrote:
> The devices within a gdsc power domain, quite often have additional
> clocks to be turned on/off along with the power domain itself.
> Add support for this by specifying a list of clk_hw pointers
> per gdsc which would be the clocks turned on/off along with the
> powerdomain on/off callbacks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/clk/qcom/gdsc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/clk/qcom/gdsc.h |  8 +++++++
>  2 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index a4f3580..7e7c051 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -12,6 +12,8 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/jiffies.h>
> @@ -21,6 +23,7 @@
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
> +#include "common.h"
>  #include "gdsc.h"
>  
>  #define PWR_ON_MASK		BIT(31)
> @@ -166,6 +169,29 @@ static inline void gdsc_assert_clamp_io(struct gdsc *sc)
>  			   GMEM_CLAMP_IO_MASK, 1);
>  }
>  
> +static inline int gdsc_clk_enable(struct gdsc *sc)

I think the compiler is smart enough so 'inline' can dropped here and below.

> +{
> +	int i, ret;
> +
> +	for (i = 0; i < sc->clk_count; i++) {
> +		ret = clk_prepare_enable(sc->clks[i]);
> +		if (ret) {
> +			for (i--; i >= 0; i--)
> +				clk_disable_unprepare(sc->clks[i]);
> +			return ret;
> +		}
> +	}

blank line please.

> +	return 0;
> +}
> +
> +static inline void gdsc_clk_disable(struct gdsc *sc)
> +{
> +	int i;
> +
> +	for (i = 0; i < sc->clk_count; i++)
> +		clk_disable_unprepare(sc->clks[i]);

can we disable clocks in reverse order, not sure that will make any
sense but I've seen issues with some of the clocks in the past.

> +}
> +
>  static int gdsc_enable(struct generic_pm_domain *domain)
>  {
>  	struct gdsc *sc = domain_to_gdsc(domain);
> @@ -193,6 +219,10 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>  	 */
>  	udelay(1);
>  
> +	ret = gdsc_clk_enable(sc);
> +	if (ret)
> +		return ret;
> +
>  	/* Turn on HW trigger mode if supported */
>  	if (sc->flags & HW_CTRL) {
>  		ret = gdsc_hwctrl(sc, true);
> @@ -241,6 +271,8 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  			return ret;
>  	}
>  
> +	gdsc_clk_disable(sc);
> +
>  	if (sc->pwrsts & PWRSTS_OFF)
>  		gdsc_clear_mem_on(sc);
>  
> @@ -254,7 +286,27 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> -static int gdsc_init(struct gdsc *sc)
> +static inline int gdsc_clk_get(struct device *dev, struct gdsc *sc)
> +{
> +	if (sc->clk_count) {

could you inverse the logic

if (!sc->clk_count)
	return 0;

> +		int i;
> +
> +		sc->clks = devm_kcalloc(dev, sc->clk_count, sizeof(*sc->clks),
> +					GFP_KERNEL);
> +		if (!sc->clks)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < sc->clk_count; i++) {
> +			sc->clks[i] = devm_clk_hw_get_clk(dev, sc->clk_hws[i],
> +							  NULL);
> +			if (IS_ERR(sc->clks[i]))
> +				return PTR_ERR(sc->clks[i]);
> +		}
> +	}

add blank line please

> +	return 0;
> +}
> +

I will make some tests with venus driver on mainline soon.

-- 
regards,
Stan
