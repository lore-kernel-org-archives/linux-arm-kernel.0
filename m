From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 17:44:40 +0800
Subject: [PATCH 04/11] mmc: sunxi: Keep default timing phase settings for
 new timing mode
In-Reply-To: <CAPDyKFoOsp7ATFY-0N4ExVWQb=z1kCJqowLv7g7CSBK4jWVj_A@mail.gmail.com>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-5-wens@csie.org>
 <CAPDyKFoOsp7ATFY-0N4ExVWQb=z1kCJqowLv7g7CSBK4jWVj_A@mail.gmail.com>
Message-ID: <CAGb2v674ZT-4O-FD4T3uK9pZEOZT5UtUFa8L90bUa2YKdbftig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 5:16 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 July 2017 at 08:42, Chen-Yu Tsai <wens@csie.org> wrote:
>> The register for the "new timing mode" also has bit fields for setting
>> output and sample timing phases. According to comments in Allwinner's
>> BSP kernel, the default values are good enough.
>>
>> Keep the default values already in the hardware when setting new timing
>> mode, instead of overwriting the whole register.
>>
>> Fixes: 9a37e53e451e ("mmc: sunxi: Enable the new timings for the A64 MMC
>>                       controllers")
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> It looks like this change doesn't depend on anything else? Do you want
> me to pick it up for fixes and adding stable tag?

Yes, please.

ChenYu

>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index d6fa2214aaae..0fb4e4c119e1 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -793,8 +793,12 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>>         }
>>         mmc_writel(host, REG_CLKCR, rval);
>>
>> -       if (host->cfg->needs_new_timings)
>> -               mmc_writel(host, REG_SD_NTSR, SDXC_2X_TIMING_MODE);
>> +       if (host->cfg->needs_new_timings) {
>> +               /* Don't touch the delay bits */
>> +               rval = mmc_readl(host, REG_SD_NTSR);
>> +               rval |= SDXC_2X_TIMING_MODE;
>> +               mmc_writel(host, REG_SD_NTSR, rval);
>> +       }
>>
>>         ret = sunxi_mmc_clk_set_phase(host, ios, rate);
>>         if (ret)
>> --
>> 2.13.2
>>
