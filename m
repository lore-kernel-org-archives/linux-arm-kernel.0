From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Thu, 11 Oct 2018 16:09:19 +0800
Subject: [PATCH v4 1/3] clk: meson: add emmc sub clock phase delay driver
In-Reply-To: <8ba84364847ae800fcfcab34573a25996d8724fd.camel@baylibre.com>
References: <20180809070724.11935-1-yixun.lan@amlogic.com>
 <20180809070724.11935-2-yixun.lan@amlogic.com>
 <8ba84364847ae800fcfcab34573a25996d8724fd.camel@baylibre.com>
Message-ID: <0a4aa8d5-8b23-b8cb-fda3-1d2e73845ba7@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jerome,

Sorry to miss this mail. I thought Yixun has finished this patchset. 
I will continue his work.

On 2018/8/10 20:27, Jerome Brunet wrote:
> On Thu, 2018-08-09 at 15:07 +0800, Yixun Lan wrote:
>> Export the emmc sub clock phase delay ops which will be used
>> by the emmc sub clock driver itself.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  drivers/clk/meson/Makefile          |  2 +-
>>  drivers/clk/meson/clk-phase-delay.c | 96 +++++++++++++++++++++++++++++
>>  drivers/clk/meson/clkc.h            | 13 ++++
>>  3 files changed, 110 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/meson/clk-phase-delay.c
>>
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 72ec8c40d848..39ce5661b654 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -2,7 +2,7 @@
>>  # Makefile for Meson specific clk
>>  #
>>  
>> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
>> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o clk-phase-delay.o
>>  obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
>>  obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
>> new file mode 100644
>> index 000000000000..6f226814cfec
>> --- /dev/null
>> +++ b/drivers/clk/meson/clk-phase-delay.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson MMC Sub Clock Controller Driver
>> + *
>> + * Copyright (c) 2017 Baylibre SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include "clkc.h"
>> +
>> +#define SD_EMMC_CLOCK			0
> 
> Drop this and use struct parm please.
> 
OK. I will use struct parm instead. Thanks for your time.
>> +
>> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_phase_delay_data *ph =
>> +		meson_clk_get_phase_delay_data(clk);
>> +	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
>> +	unsigned long period_ps, p, d;
>> +	int degrees;
>> +	u32 val;
>> +
>> +	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
>> +	p = (val & ph->phase_mask) >> __ffs(ph->phase_mask);
>> +	degrees = p * 360 / phase_num;
>> +
>> +	if (ph->delay_mask) {
>> +		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
>> +					 clk_hw_get_rate(hw));
>> +		d = (val & ph->delay_mask) >> __ffs(ph->delay_mask);
>> +		degrees += d * ph->delay_step_ps * 360 / period_ps;
>> +		degrees %= 360;
>> +	}
>> +
>> +	return degrees;
>> +}
>> +
>> +static void meson_clk_apply_phase_delay(struct clk_regmap *clk,
>> +					unsigned int phase,
>> +					unsigned int delay)
>> +{
>> +	struct meson_clk_phase_delay_data *ph = clk->data;
>> +	u32 val;
>> +
>> +	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
>> +
>> +	val &= ~ph->phase_mask;
>> +	val |= phase << __ffs(ph->phase_mask);
>> +
>> +	if (ph->delay_mask) {
> 
> This imply that delay is delay is optional. In such case, it would be a regular
> "phase" and we already have a  driver for this. Please remove all the related
> code and make this parameter required for this clock type.
> 
OK. I will use APIs from clk-phase.c for ?core' phase. 
> In the future, maybe we'll merge the 2 drivers.
> 
>> +		val &= ~ph->delay_mask;
>> +		val |= delay << __ffs(ph->delay_mask);
>> +	}
>> +
>> +	regmap_write(clk->map, SD_EMMC_CLOCK, val);
>> +}
>> +
>> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_phase_delay_data *ph =
>> +		meson_clk_get_phase_delay_data(clk);
>> +	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
>> +	unsigned long period_ps, d = 0, r;
>> +	u64 p;
>> +
>> +	p = degrees % 360;
>> +
>> +	if (!ph->delay_mask) {
>> +		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
>> +	} else {
>> +		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
>> +					 clk_hw_get_rate(hw));
>> +
>> +		/* First compute the phase index (p), the remainder (r) is the
>> +		 * part we'll try to acheive using the delays (d).
>> +		 */
>> +		r = do_div(p, 360 / phase_num);
>> +		d = DIV_ROUND_CLOSEST(r * period_ps,
>> +				      360 * ph->delay_step_ps);
>> +		d = min(d, ph->delay_mask >> __ffs(ph->delay_mask));
>> +	}
>> +
>> +	meson_clk_apply_phase_delay(clk, p, d);
>> +	return 0;
>> +}
>> +
>> +const struct clk_ops meson_clk_phase_delay_ops = {
>> +	.get_phase = meson_clk_phase_delay_get_phase,
>> +	.set_phase = meson_clk_phase_delay_set_phase,
>> +};
>> +EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
>> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
>> index 24cec16b6038..499834dd34f2 100644
>> --- a/drivers/clk/meson/clkc.h
>> +++ b/drivers/clk/meson/clkc.h
>> @@ -113,6 +113,18 @@ struct clk_regmap _name = {						\
>>  	},								\
>>  };
>>  
>> +struct meson_clk_phase_delay_data {
>> +	unsigned long			phase_mask;
>> +	unsigned long			delay_mask;
> 
> Like every other clock drivers in the amlogic directory, please use struct parm
> to decribe the fields.
> 
OK. I will use struct parm to describe phase and delay register fields.
>> +	unsigned int			delay_step_ps;
>> +};
>> +
>> +static inline struct meson_clk_phase_delay_data *
>> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
>> +{
>> +	return (struct meson_clk_phase_delay_data *)clk->data;
>> +}
>> +
>>  /* clk_ops */
>>  extern const struct clk_ops meson_clk_pll_ro_ops;
>>  extern const struct clk_ops meson_clk_pll_ops;
>> @@ -120,5 +132,6 @@ extern const struct clk_ops meson_clk_cpu_ops;
>>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>>  extern const struct clk_ops meson_clk_mpll_ops;
>>  extern const struct clk_ops meson_clk_phase_ops;
>> +extern const struct clk_ops meson_clk_phase_delay_ops;
>>  
>>  #endif /* __CLKC_H */
> 
> 
> .
> 
