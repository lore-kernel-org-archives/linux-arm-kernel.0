From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Thu, 05 Mar 2015 14:47:14 +0200
Subject: [PATCH 1/6] clk: qcom: Add support for GDSCs
In-Reply-To: <1425279749-16625-2-git-send-email-rnayak@codeaurora.org>
References: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
 <1425279749-16625-2-git-send-email-rnayak@codeaurora.org>
Message-ID: <54F85052.8090600@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 09:02 AM, Rajendra Nayak wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> GDSCs (Global Distributed Switch Controllers) are responsible for
> safely collapsing and restoring power to peripherals in the SoC.
> These are best modelled as power domains using genpd and given
> the registers are scattered throughout the clock controller register
> space, its best to have the support added through the clock driver.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig  |   5 ++
>  drivers/clk/qcom/Makefile |   1 +
>  drivers/clk/qcom/gdsc.c   | 130 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h   |  43 +++++++++++++++
>  4 files changed, 179 insertions(+)
>  create mode 100644 drivers/clk/qcom/gdsc.c
>  create mode 100644 drivers/clk/qcom/gdsc.h
> 

<snip>

> --- /dev/null
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -0,0 +1,130 @@
> +/*

<snip>

> +
> +#include "gdsc.h"
> +
> +#define PWR_ON_MASK		BIT(31)
> +#define EN_REST_WAIT_MASK	(0xF << 20)

you can use GENMASK(23, 20) here and below

> +#define EN_FEW_WAIT_MASK	(0xF << 16)
> +#define CLK_DIS_WAIT_MASK	(0xF << 12)
> +#define SW_OVERRIDE_MASK	BIT(2)
> +#define HW_CONTROL_MASK		BIT(1)
> +#define SW_COLLAPSE_MASK	BIT(0)
> +
> +/* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
> +#define EN_REST_WAIT_VAL	(0x2 << 20)
> +#define EN_FEW_WAIT_VAL		(0x8 << 16)
> +#define CLK_DIS_WAIT_VAL	(0x2 << 12)
> +
> +#define TIMEOUT_US		100
> +
> +static int gdsc_is_enabled(struct gdsc *sc)
> +{
> +	u32 val;
> +
> +	regmap_read(sc->regmap, sc->gdscr, &val);

please, check the regmap_read for error, here and on few places below.

> +	return !!(val & PWR_ON_MASK);
> +}
> +
> +static int gdsc_toggle_logic(struct gdsc *sc, bool en)
> +{
> +	int ret;
> +	u32 val = en ? 0 : SW_COLLAPSE_MASK;
> +	u32 check = en ? PWR_ON_MASK : 0;
> +	unsigned long timeout;
> +
> +	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> +	do {
> +		regmap_read(sc->regmap, sc->gdscr, &val);
> +		if ((val & PWR_ON_MASK) == check)
> +			return 0;
> +	} while (time_before(jiffies, timeout));

blank line here will be better.

> +	regmap_read(sc->regmap, sc->gdscr, &val);
> +	if ((val & PWR_ON_MASK) == check)
> +		return 0;
> +
> +	pr_err("%s %s timed out\n", en ? "enabling" : "disabling", sc->pd.name);

use dev_err() or giving the error to the upper layers should be enough.

> +	return -ETIMEDOUT;
> +}
> +
> +static int gdsc_enable(struct generic_pm_domain *domain)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	int ret;
> +
> +	ret = gdsc_toggle_logic(sc, true);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * If clocks to this power domain were already on, they will take an
> +	 * additional 4 clock cycles to re-enable after the power domain is
> +	 * enabled. Delay to account for this. A delay is also needed to ensure
> +	 * clocks are not enabled within 400ns of enabling power to the
> +	 * memories.
> +	 */
> +	udelay(1);
> +
> +	return 0;
> +}
> +
> +static int gdsc_disable(struct generic_pm_domain *domain)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	int ret = 0;
> +
> +	ret = gdsc_toggle_logic(sc, false);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

return gdsc_toggle_logic(sc, false);

> +}
> +
> +int gdsc_init(struct generic_pm_domain *domain, struct regmap *regmap)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	u32 mask;
> +	u32 val;
> +	int on;
> +
> +	sc->regmap = regmap;
> +
> +	/*
> +	 * Disable HW trigger: collapse/restore occur based on registers writes.
> +	 * Disable SW override: Use hardware state-machine for sequencing.
> +	 * Configure wait time between states.
> +	 */
> +	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
> +	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> +	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> +	regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
> +
> +	on = gdsc_is_enabled(sc);
> +
> +	pm_genpd_init(&sc->pd, NULL, !on);
> +	sc->pd.power_off = gdsc_disable;
> +	sc->pd.power_on = gdsc_enable;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gdsc_init);

gdsc_init is used in common.c, no need to export it.

<snip>

-- 
regards,
Stan
