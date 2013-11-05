From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Tue, 05 Nov 2013 13:15:43 +0400
Subject: [PATCH v2 2/4] clk: exynos5410: register clocks using common clock
 framework
In-Reply-To: <1421095.b3lQaz2kV9@flatron>
References: <1381763305-7085-1-git-send-email-v.tyrtov@samsung.com>
 <1381763305-7085-3-git-send-email-v.tyrtov@samsung.com>
 <1421095.b3lQaz2kV9@flatron>
Message-ID: <5278B73F.1090508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01.11.2013 20:58, Tomasz Figa wrote:
> Hi,
>
> On Monday 14 of October 2013 19:08:23 Vyacheslav Tyrtov wrote:
>> From: Tarek Dakhran <t.dakhran@samsung.com>
>>
>> The EXYNOS5410 clocks are statically listed and registered
>> using the Samsung specific common clock helper functions.
>>
>> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
>> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
>> ---
>>   .../devicetree/bindings/clock/exynos5410-clock.txt |  37 +++
>>   drivers/clk/samsung/Makefile                       |   1 +
>>   drivers/clk/samsung/clk-exynos5410.c               | 251
>> +++++++++++++++++++++ include/dt-bindings/clock/exynos5410.h
>>   | 175 ++++++++++++++ 4 files changed, 464 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/clock/exynos5410-clock.txt create
>> mode 100644 drivers/clk/samsung/clk-exynos5410.c
>>   create mode 100644 include/dt-bindings/clock/exynos5410.h
> The driver looks pretty good now, thanks for addressing my comments to
> previous version. There are still few issues remaining, though. Please see
> my comments inline.
>
> [snip]
>> diff --git a/drivers/clk/samsung/clk-exynos5410.c
>> b/drivers/clk/samsung/clk-exynos5410.c new file mode 100644
>> index 0000000..c5eba08
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-exynos5410.c
> [snip]
>> +static struct of_device_id ext_clk_match[] __initdata = {
>> +	{ .compatible = "samsung,clock-oscclk", .data = (void *)0, },
>> +	{ },
>> +};
> I don't see anything in binding documentation mentioning this compatible
> value. Anyway, since there is already a generic binding for fixed rate
> clocks, this shouldn't be needed at all.
>
>> +
>> +/* register exynos5410 clocks */
>> +static void __init exynos5410_clk_init(struct device_node *np)
>> +{
>> +	void __iomem *reg_base;
>> +
>> +	reg_base = of_iomap(np, 0);
>> +	if (!reg_base)
>> +		panic("%s: failed to map registers\n", __func__);
>> +
>> +	samsung_clk_init(np, reg_base, CLK_NR_CLKS,
>> +			exynos5410_clk_regs,
> ARRAY_SIZE(exynos5410_clk_regs),
>> +			NULL, 0);
>> +	samsung_clk_of_register_fixed_ext(exynos5410_frt_ext_clks,
>> +			ARRAY_SIZE(exynos5410_frt_ext_clks),
>> +			ext_clk_match);
> This call could be dropped after moving to generic fixed rate clock
> bindings.
>
> Best regards,
> Tomasz

Already done. Will be added in patch v3.


Thank you for comments, Tomasz.

Best regards,
     Tarek Dakhran
