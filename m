From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Sun, 28 Oct 2018 23:12:59 +0800
Subject: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
In-Reply-To: <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
 <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
 <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
Message-ID: <d284b4dd-b479-f7a7-1527-7e36b4b7451f@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On 2018/10/25 20:54, Jerome Brunet wrote:
> On Thu, 2018-10-25 at 19:48 +0800, Jianxin Pan wrote:
>> Hi Jerome,
>>
>> On 2018/10/24 17:01, Jerome Brunet wrote:
>>> On Thu, 2018-10-18 at 13:07 +0800, Jianxin Pan wrote:
>>>> From: Yixun Lan <yixun.lan@amlogic.com>
>>>>
>>>> The patch will add a MMC clock controller driver which used by MMC or NAND,
>>>> It provide a mux and divider clock, and three phase clocks - core, tx, tx.
>>>>
[...]
>>>>  
>>>> -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
>>>> +static void clk_regmap_div_init(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
>>>> +	unsigned int val;
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_read(clk->map, div->offset, &val);
>>>> +	if (ret)
>>>> +		return;
>>>>  
>>>> +	val &= (clk_div_mask(div->width) << div->shift);
>>>> +	if (!val)
>>>> +		regmap_update_bits(clk->map, div->offset,
>>>> +				   clk_div_mask(div->width) << div->shift,
>>>> +				   clk_div_mask(div->width));
>>>
>>> This is wrong for several reasons:
>>> * You should hard code the initial value in the driver.
>>> * If shift is not 0, I doubt this will give the expected result.
>>
>> The value 0x00 of divider means nand clock off then read/write nand register is forbidden.
> 
> That is not entirely true, you can access the clock register or you'd be in a
> chicken and egg situation.
> 
>> Should we set the initial value in nand driver, or in sub emmc clk driver?
> 
> In the nand driver, which is the consumer of the clock. see my previous comments
> about it.
> 
> If your device (nand in your case) needs a (sane) clock before doing anything
> else, just call clk_set_rate() and enable it with clk_prepare_enable().
> 
> Look at our MMC driver, this is the first thing done after registering the
> clocks.
> 
> The controller does no care at all about the clock rate or state. It is up to
> the consumer to express their needs.
> 
> On a more general note:
> I agree that having a 0 value for CLK_DIVIDER_ONE_BASED divider makes no sense.
> If you think this point needs to be addressed, please:
> 
> * make separated generic patch
> * against driver/clk/clk-divider.c 
> * addressing specifically CLK_DIVIDER_ONE_BASED dividers (not all, as your
> change does)
> * with some comments explaining the intent.
In our emmc driver, the CLK_DIV_MASK is hard coded before clock registering in meson_mmc_clk_init():
 clk_reg |= CLK_DIV_MASK;
 writel(clk_reg, host->regs + SD_EMMC_CLOCK);
It's hard coded In previous version of nand driver.  I will drop the new ops.

In addition , Martin suggested in previous discussions that "sclk-div" could be used [0][1]. 
This divider is just like a "sclk-div" with sclk->hi->width ==0. 


> 
>>  
>>>
>>>> +}
>>>
>>> Please drop this. 
OK. Thank you.
>>>
>>>> +
>>>> +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
>>>>  const struct clk_ops clk_regmap_divider_ops = {
>>>>  	.recalc_rate = clk_regmap_div_recalc_rate,
>>>>  	.round_rate = clk_regmap_div_round_rate,
>>>> @@ -122,6 +139,14 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>>>>  };
>>>>  EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
>>>>  
[...]
>>>> +
>>>> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
>>>> +	.offset		= SD_EMMC_CLOCK,
>>>> +	.mask		= 0x3,
>>>> +	.shift		= 6,
>>>> +	.flags		= CLK_DIVIDER_ROUND_CLOSEST,
> 
> Missed that earlier
> 
> This flag makes no sense for a mux.
> Anyway this particular mux should never round up has doing so would be unsafe.
> The clock provided to the nand or the eMMC should be the requested or lower.
> 
OK, I will drop it. Thanks for your time.
>>>> +};
>>>> +
>>>> +static struct clk_regmap_div_data mmc_clkc_div_data = {
>>>> +	.offset		= SD_EMMC_CLOCK,
>>>> +	.shift		= 0,
>>>> +	.width		= 6,
>>>> +	.flags		= CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
> 
> Same here, drop CLK_DIVIDER_ROUND_CLOSEST
OK, I will drop it. Thank you!
> 
>>>> +};
>>>> +
>>>> +static struct meson_clk_phase_data mmc_clkc_core_phase = {
>>>> +	.ph = {
>>>> +		.reg_off	= SD_EMMC_CLOCK,
>>>> +		.shift	= 8,
[...]
> 
> .
> 

[0] https://patchwork.kernel.org/patch/10607157/#22238243
[1]https://lore.kernel.org/lkml/CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ at mail.gmail.com/T/#u
