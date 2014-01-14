From: zhangfei.gao@gmail.com (Zhangfei Gao)
Date: Tue, 14 Jan 2014 18:04:55 +0800
Subject: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <002901cf110d$993b4880$cbb1d980$%jun@samsung.com>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
 <002901cf110d$993b4880$cbb1d980$%jun@samsung.com>
Message-ID: <CAMj5BkgCzg-Nqm-FX_36-1ShGsL9x1HALmtywm-0sHtp53wR5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
>> +                           unsigned long *best_parent_rate,
>> +                           struct clk **best_parent_p)
>> +{
>> +     struct clk_mmc *mclk = to_mmc(hw);
>> +     unsigned long best = 0;
>> +
>> +     if ((rate <= 13000000) && (mclk->id == HI3620_MMC_CIUCLK1)) {
> No need to check HI3620_MMC_CIUCLK2 and HI3620_MMC_CIUCLK3?

Yes, only emmc, id=HI3620_MMC_CIUCLK1, using init clk 13M, while
others use init clock 25M.
Add this to handle init mmc init clk 400K and return source clock rate
13M, from your suggestion in fact.

>
>> +             rate = 13000000;
>> +             best = 26000000;
>> +     } else if (rate <= 26000000) {
>> +             rate = 25000000;
>> +             best = 180000000;
>> +     } else if (rate <= 52000000) {
>> +             rate = 50000000;
>> +             best = 360000000;
>> +     } else if (rate <= 100000000) {
>> +             rate = 100000000;
>> +             best = 720000000;
>> +     } else {
>> +             /* max is 180M */
>> +             rate = 180000000;
>> +             best = 1440000000;
>> +     }
>> +     *best_parent_rate = best;
>> +     return rate;
>> +}

>> +static int mmc_clk_prepare(struct clk_hw *hw)
>> +{
>> +     struct clk_mmc *mclk = to_mmc(hw);
>> +     unsigned long rate;
>> +
>> +     if (mclk->id == HI3620_MMC_CIUCLK1)
> HI3620_SD_CIUCLK was used in previous version.
Yes, fixed, though it can work on the dev board.

> Is it fixed with HI3620_MMC_CIUCLK1?
> And, please clarify in case of HI3620_MMC_CIUCLK2 and HI3620_MMC_CIUCLK3 as well.

Only HI3620_MMC_CIUCLK1 use 13M for init, all others use 25M on hi3620.

>
> Thanks,
> Seungwon Jeon
>
>> +             rate = 13000000;
>> +     else
>> +             rate = 25000000;
>> +
>> +     return mmc_clk_set_timing(hw, rate);
>> +}
>> +

Thanks
