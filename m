From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 09 Dec 2014 11:43:01 +0530
Subject: [PATCH 03/19] clk: samsung: exynos5433: Add clocks for CMU_PERIC
 domain
In-Reply-To: <54864C90.9040205@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-4-git-send-email-cw00.choi@samsung.com>
 <54858C13.8020704@samsung.com> <54864C90.9040205@samsung.com>
Message-ID: <548692ED.4080301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 09 December 2014 06:42 AM, Chanwoo Choi wrote:
> Hi Pankaj,
>
> On 12/08/2014 08:31 PM, Pankaj Dubey wrote:
>> Hi Chanwoo,
>>
>> On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
>>> This patch adds missing divider/gate clocks of CMU_PERIC domain
>>> which includes I2S/PCM/SPDIF/PWM/SLIMBUS IPs. The SPI/I2S may use
>>> external input clock which has 'ioclk_*' prefix.
>>>
>>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> [ideal.song: Change clk flags of to pclk_gpio_* clk, pclk_gpio_* should be always on.]
>>> Signed-off-by: Inha Song <ideal.song@samsung.com>
>>> Acked-by: Inki Dae <inki.dae@samsung.com>
>>> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
>>> ---
>>>    drivers/clk/samsung/clk-exynos5433.c   | 80 +++++++++++++++++++++++++++++++++-
>>>    include/dt-bindings/clock/exynos5433.h | 34 ++++++++++++++-
>>>    2 files changed, 112 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>>> index 88e8cac..a48b36c 100644
>>> --- a/drivers/clk/samsung/clk-exynos5433.c
>>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>>> @@ -256,6 +256,14 @@ static struct samsung_fixed_rate_clock top_fixed_clks[] __initdata = {
>>>        FRATE(0, "ioclk_audiocdclk0", NULL, CLK_IS_ROOT, 100000000),
>>>        /* Xi2s1SDI input clock for SPDIF */
>>>        FRATE(0, "ioclk_spdif_extclk", NULL, CLK_IS_ROOT, 100000000),
>>> +    /* XspiCLK[4:0] input clock for SPI */
>>> +    FRATE(0, "ioclk_spi4_clk_in", NULL, CLK_IS_ROOT, 50000000),
>>> +    FRATE(0, "ioclk_spi3_clk_in", NULL, CLK_IS_ROOT, 50000000),
>>> +    FRATE(0, "ioclk_spi2_clk_in", NULL, CLK_IS_ROOT, 50000000),
>>> +    FRATE(0, "ioclk_spi1_clk_in", NULL, CLK_IS_ROOT, 50000000),
>>> +    FRATE(0, "ioclk_spi0_clk_in", NULL, CLK_IS_ROOT, 50000000),
>>> +    /* Xi2s1SCLK input clock for I2S1_BCLK */
>>> +    FRATE(0, "ioclk_i2s1_bclk_in", NULL, CLK_IS_ROOT, 12288000),
>>>    };
>>>
>>>    static struct samsung_mux_clock top_mux_clks[] __initdata = {
>>> @@ -760,6 +768,7 @@ CLK_OF_DECLARE(exynos5433_cmu_mif, "samsung,exynos5433-cmu-mif",
>>>     * Register offset definitions for CMU_PERIC
>>>     */
>>>    #define DIV_PERIC            0x0600
>>> +#define DIV_STAT_PERIC            0x0700
>>>    #define ENABLE_ACLK_PERIC        0x0800
>>>    #define ENABLE_PCLK_PERIC0        0x0900
>>>    #define ENABLE_PCLK_PERIC1        0x0904
>>> @@ -770,6 +779,7 @@ CLK_OF_DECLARE(exynos5433_cmu_mif, "samsung,exynos5433-cmu-mif",
>>>
>>>    static unsigned long peric_clk_regs[] __initdata = {
>>>        DIV_PERIC,
>>> +    DIV_STAT_PERIC,
>>
>> IMO, this line should have been added in first place itself when you added peric_clk_regs.
>
> Why? I want to locate it according to address base.

Since DIV_PERIC and DIV_STAT_PERIC both has same address base, why not 
to add DIV_STAT_PERIC at the same place when you added DIV_PERIC?

Anyways, this was just my opinion as I don't see any dependency why we 
should add it here? I left this up to you.

>
>>
>>>        ENABLE_ACLK_PERIC,
>>>        ENABLE_PCLK_PERIC0,
>>>        ENABLE_PCLK_PERIC1,
>>> @@ -779,14 +789,57 @@ static unsigned long peric_clk_regs[] __initdata = {
>>>        ENABLE_IP_PERIC2,
>>>    };
>>>
>>> +static struct samsung_div_clock peric_div_clks[] __initdata = {
>>> +    /* DIV_PERIC */
>>> +    DIV(CLK_DIV_SCLK_SCI, "div_sclk_sci", "fin_pll", DIV_PERIC, 4, 8),
>>
>> As per UM I have DIV_SCLK_SCI has 4 bit wide as [7:4] please cross verify.
>
> You're right. It is my mistake. I'll fix it.
>
> Best Regards,
> Chanwoo Choi
>
Thanks,
Pankaj Dubey
