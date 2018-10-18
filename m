From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Oct 2018 11:40:09 +0200
Subject: [PATCH v3 3/6] clocksource: exynos_mct: Refactor resources
 allocation
In-Reply-To: <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
References: <CGME20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3@eucas1p1.samsung.com>
 <20181017134159.9656-1-m.szyprowski@samsung.com>
 <20181017134159.9656-4-m.szyprowski@samsung.com>
 <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
Message-ID: <20181018094011eucas1p11831fa3b26007be54af17d57852e120b~eqoUWGdbK0807208072eucas1p1I@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018-10-17 16:29, Krzysztof Kozlowski wrote:
> On Wed, 17 Oct 2018 at 15:42, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Move interrupts allocation from exynos4_timer_resources() into separate
>> function together with the interrupt number parsing code from
>> mct_init_dt(), so the code for managing interrupts is kept together.
>> While touching exynos4_timer_resources() function, move of_iomap() to it.
>> No functional changes.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/clocksource/exynos_mct.c | 49 +++++++++++++++++++-------------
>>  1 file changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>> index 49413900b24c..02ad55db390b 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>>         return 0;
>>  }
>>
>> -static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
>> +static int __init exynos4_timer_resources(struct device_node *np)
>>  {
>> -       int err, cpu;
>>         struct clk *mct_clk, *tick_clk;
>>
>> +       reg_base = of_iomap(np, 0);
>> +       if (!reg_base)
>> +               panic("%s: unable to ioremap mct address space\n", __func__);
>> +
>>         tick_clk = of_clk_get_by_name(np, "fin_pll");
>>         if (IS_ERR(tick_clk))
>>                 panic("%s: unable to determine tick clock rate\n", __func__);
>> @@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>>                 panic("%s: unable to retrieve mct clock instance\n", __func__);
>>         clk_prepare_enable(mct_clk);
>>
>> -       reg_base = base;
>> -       if (!reg_base)
>> -               panic("%s: unable to ioremap mct address space\n", __func__);
>> +       return 0;
>> +}
>> +
>> +static int __init exynos4_timer_interrupts(struct device_node *np,
>> +                                          unsigned int int_type)
>> +{
>> +       int i, err, cpu;
>> +
>> +       mct_int_type = int_type;
> This does not look good. Before, assignment was done before call to
> exynos4_timer_resources(). Now, if I follow the path correctly, it
> will be after. Therefore the exynos4_timer_resources() will use wrong
> value. This should pop up during tests.

After refactoring exynos4_timer_resource() doesn't use int_type, but you
are right, there is one item missing: nr_irqs as local variable, what
causes the driver to mess with the global one, what is fatal to the
system. I will send a fixed version in a few minutes.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
