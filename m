From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 30 Jun 2014 12:58:57 +0200
Subject: [PATCH v5 05/14] clk: Add generic driver for Maxim PMIC clocks
In-Reply-To: <CAKew6eU5X=WxhECtwUUwbXe_fCRU4bD6B7caWiA2dwcBfThd-g@mail.gmail.com>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>	<1403806546-31122-6-git-send-email-javier.martinez@collabora.co.uk>
 <CAKew6eU5X=WxhECtwUUwbXe_fCRU4bD6B7caWiA2dwcBfThd-g@mail.gmail.com>
Message-ID: <53B142F1.1050407@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yadwinder,

Thanks a lot for your feedback.

On 06/30/2014 06:01 AM, Yadwinder Singh Brar wrote:
> Hi Javier,
> 
> On Thu, Jun 26, 2014 at 11:45 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> Maxim Integrated Power Management ICs are very similar with
>> regard to their clock outputs. Most of the clock drivers for
>> these chips are duplicating code and are simpler enough that
>> can be converted to use a generic driver to consolidate code
>> and avoid duplication.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>
>> Changes since v4:
>>  - Return recalc 0 if clock isn't enabled in Suggested by Yadwinder Singh Brar.
>>
> 
> It seems you didn't implement or posted same patch again :) .
> 

Yeah, I did implement it but seems I was sleepy when I posted the series since I
managed to completely screw up the patch-set... More on that below.

>> Changes since v3:
>>  - Add current copyright information. Suggested by Krzysztof Kozlowski
>>  - Do a single allocation for struct max_gen_clk. Suggested by Krzysztof Kozlowski
>>  - Add EXPORT_SYMBOL() for exported symbols. Suggested by Krzysztof Kozlowski
>>
>>  drivers/clk/Kconfig       |   3 +
>>  drivers/clk/Makefile      |   1 +
>>  drivers/clk/clk-max-gen.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/clk-max-gen.h |  32 ++++++++
>>  4 files changed, 231 insertions(+)
>>  create mode 100644 drivers/clk/clk-max-gen.c
>>  create mode 100644 drivers/clk/clk-max-gen.h
>>
> 
> [ .. ]
> 
>> +
>> +static unsigned long max_gen_recalc_rate(struct clk_hw *hw,
>> +                                        unsigned long parent_rate)
>> +{
>> +       return 32768;
>> +}
> 
> Its still same here.
> 

Instead of squashing the delta in this patch I did on "[PATCH v4 05/14] clk: Add
generic driver for Maxim PMIC clocks" [0] so you can look the
max_gen_recalc_rate() on that patch.

I made the same mistake when squashing the mfd changes into the patch adding the
regulator driver [1] :-(

Sorry for the mess... I'll fix that for the next version.

>> +
>> +struct clk_ops max_gen_clk_ops = {
>> +       .prepare        = max_gen_clk_prepare,
>> +       .unprepare      = max_gen_clk_unprepare,
>> +       .is_prepared    = max_gen_clk_is_prepared,
>> +       .recalc_rate    = max_gen_recalc_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(max_gen_clk_ops);
>> +
>> +static struct clk *max_gen_clk_register(struct device *dev,
>> +                                       struct max_gen_clk *max_gen)
>> +{
>> +       struct clk *clk;
>> +       struct clk_hw *hw = &max_gen->hw;
>> +
>> +       clk = clk_register(dev, hw);
>> +       if (IS_ERR(clk))
>> +               return clk;
>> +
>> +       max_gen->lookup = kzalloc(sizeof(struct clk_lookup), GFP_KERNEL);
> 
> As I suggested in other patch[1] also, its better to use
> clkdev_alloc() instead of kzalloc() here.
> 

Perfect, I'll do it on the next version.

>> +       if (!max_gen->lookup)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       max_gen->lookup->con_id = hw->init->name;
> 
> Also IMO,  init->name should be over-written if name is provided in DT,
> otherwise generic "clock-output-names" property will go futile,
> perhaps it should be done before clk_register.
> 

Even though Documentation/devicetree/bindings/clock/clock-bindings.txt says that
the "clock-output-names" property is optional I agree with you that will be
better to support it. So I'll add it on the next version as well.

> Regards,
> Yadwinder
> 

Best regards,
Javier

[0]: http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33085.html
[1]: http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33168.html
