From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 2 Apr 2015 14:44:29 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: Get current parent clock for power
 domain on/off
In-Reply-To: <551D362B.90901@collabora.co.uk>
References: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
 <551D362B.90901@collabora.co.uk>
Message-ID: <CAJKOXPc1dfHAaUQd+3HDhNwQW8xYDeoYFgN6QMkmQPEnLGtG-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-02 14:29 GMT+02:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> Hello Krzysztof,
>
> On 04/02/2015 10:06 AM, Krzysztof Kozlowski wrote:
>> Using a fixed (by DTS) parent for clocks when turning on the power domain
>> may introduce issues in other drivers. For example when such driver
>> changes the parent during runtime and expects that he is the only place
>> of such change.
>>
>> Do not rely entirely on DTS providing the fixed parent for such clocks.
>> Instead if "pclkN" clock name is missing, grab a current parent of clock
>> with clk_get_parent().
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/arm/exynos/power_domain.txt | 8 +++++---
>>  arch/arm/mach-exynos/pm_domains.c                             | 9 ++++++---
>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> index 5da38c5ed476..0fc1312f6fd5 100644
>> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>> @@ -19,9 +19,11 @@ Optional Properties:
>>       domains.
>>  - clock-names: The following clocks can be specified:
>>       - oscclk: Oscillator clock.
>> -     - pclkN, clkN: Pairs of parent of input clock and input clock to the
>> -             devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
>> -             are supported currently.
>> +     - pclkN, clkN: Input clocks (clkN) to the devices in this power domain.
>> +             Optionally with parrents (pclkN). If such parent is provided
>> +             it will be used for reparenting the given clock when domain
>> +             is turned on. Otherwise the parent before power down will be
>> +             used. Maximum of 4 pairs (N = 0 to 3) are supported currently.
>>       - asbN: Clocks required by asynchronous bridges (ASB) present in
>>               the power domain. These clock should be enabled during power
>>               domain on/off operations.
>> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
>> index cbe56b35aea0..c55bcf52a6ad 100644
>> --- a/arch/arm/mach-exynos/pm_domains.c
>> +++ b/arch/arm/mach-exynos/pm_domains.c
>> @@ -37,6 +37,7 @@ struct exynos_pm_domain {
>>       struct clk *oscclk;
>>       struct clk *clk[MAX_CLK_PER_DOMAIN];
>>       struct clk *pclk[MAX_CLK_PER_DOMAIN];
>> +     unsigned int pclk_dynamic:MAX_CLK_PER_DOMAIN;
>>       struct clk *asb_clk[MAX_CLK_PER_DOMAIN];
>>  };
>>
>> @@ -62,6 +63,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>>               for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
>>                       if (IS_ERR(pd->clk[i]))
>>                               break;
>> +                     /* If parent was not set in DT, save current parent */
>> +                     if (pd->pclk_dynamic & (1 << i))
>
> Small nit: I personally think that using the BIT(i) macro for shifting bits
> is more readable but I guess is a matter of personal taste.

Right, it seems I always forget about BIT macro.
I'll respin with BIT() and your review/tested tags.

Thanks for feedback and testing!

Best regards,
Krzysztof
