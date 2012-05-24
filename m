From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 24 May 2012 14:30:04 +0530
Subject: [PATCH 1/6] ARM: Exynos4: Fix the incorrect hierarchy of spi
 controller bus clock
In-Reply-To: <006601cd397e$a9932df0$fcb989d0$%kim@samsung.com>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-2-git-send-email-thomas.abraham@linaro.org>
 <006601cd397e$a9932df0$fcb989d0$%kim@samsung.com>
Message-ID: <CAJuYYwT7oscA6_fHLqSke0-STF7ssVput8NniP9QkqwX2_L2bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2012 12:57, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> The sclk_spi clock is derived currently from the first level divider
>> (MMCx_RATIO) which is incorrect. The output of the first level clock
>> is divided by a second level divider (MMCx_PRE_RATIO), the output of
>> which is used as the spi bus clock (sclk_spi). Fix the clock hierarchy
>> issues for the sclk_spi clock.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
>> ---
>> ?arch/arm/mach-exynos/clock-exynos4.c | ? 48
> ++++++++++++++++++++++++++++--
>> ---
>> ?1 files changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-
>> exynos/clock-exynos4.c
>> index 10a46a9..b5f0507 100644
>> --- a/arch/arm/mach-exynos/clock-exynos4.c
>> +++ b/arch/arm/mach-exynos/clock-exynos4.c
>> @@ -1242,40 +1242,70 @@ static struct clksrc_clk exynos4_clk_sclk_mmc3 = {
>> ? ? ? .reg_div = { .reg = EXYNOS4_CLKDIV_FSYS2, .shift = 24, .size = 8 },
>> ?};
>>
>> +static struct clksrc_clk exynos4_clk_mdout_spi0 = {
>
> In this case, it's expected that 'exynos4_clk_dout_spi0' will be used even
> though this indicates the clock of mux_out and divider_out together.
>
>> + ? ? .clk ? ?= {
>> + ? ? ? ? ? ? .name ? ? ? ? ? = "sclk_spi_mdout",
>
> So, this should be 'dout_spi0'

This clock instance has both a mux and a divider. So I used mdout to
mean that there is both a mux and a divider in this clock instance. If
you insist on changing the name to dout_spi0, I will change it.

Thanks,
Thomas.

>
>> + ? ? ? ? ? ? .devname ? ? ? ?= "exynos4210-spi.0",
>
> [...]
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
