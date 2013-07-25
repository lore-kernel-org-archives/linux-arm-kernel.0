From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Jul 2013 17:32:12 +0800
Subject: [PATCH 3/6] ASoC: usp-pcm: add CPU DAI driver for PCM simulated
 from USP
In-Reply-To: <20130719181313.GT9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
 <20130719181313.GT9858@sirena.org.uk>
Message-ID: <CAGsJ_4xNdxFWyN6NUEL36W9n+4Cj=01+QGi+xaeODm9u8pdP9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/20 Mark Brown <broonie@kernel.org>:
> On Fri, Jul 19, 2013 at 07:07:19PM +0800, Barry Song wrote:
>
>> +static int sirf_usp_pcm_divider(struct snd_soc_dai *dai, int div_id, int rate)
>> +{
>> +     struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
>> +
>> +     u32 clk_rate = clk_get_rate(susp->clk);
>> +     u32 clk_div = (clk_rate/(2*rate)) - 1;
>> +     u32 clk_div_hi = (clk_div & 0xC00)>>10;
>> +     u32 clk_div_lo = (clk_div & 0x3FF);
>> +
>> +     writel((clk_div_lo<<21) | readl(susp->base + USP_MODE2),
>> +             susp->base + USP_MODE2);
>> +     writel((clk_div_hi<<30) | readl(susp->base + USP_TX_FRAME_CTRL),
>> +             susp->base + USP_TX_FRAME_CTRL);
>> +
>> +     return 0;
>> +}
>
> I'd be happier if this did some validation on the supplied rate (for
> example, checking that it's less than the master rate) and had arguments
> specifying which clock was being affected (in case there's more in
> future revisions).

sounds good.

>
> Also what exactly is the rate being set - can the driver just figure
> this out automatically from the sample rate?

here it is generating the right pcm clock by an internal DIVISOR in USP module.

For USP_MODE2:
30:21 (R/W) USP_CLK_DIVISOR 10?h0 USP serial clock divider

For USP_TX_FRAME_CTRL:
31:30 (R/W) USP_CLK_DIVISOR 2?h0 This is the two bit [11:10] of
USP_CLK_DIVISOR in USP_MODE2

for figuring this out automatically from the sample rate, do you mean
a lookup table for common sample rate?

>
>> +#ifdef CONFIG_PM
>> +static int sirf_usp_pcm_suspend(struct platform_device *pdev,
>> +     pm_message_t state)
>> +{
>> +     struct sirf_usp *susp = platform_get_drvdata(pdev);
>> +
>> +     susp->mode1_reg = readl(susp->base + USP_MODE1);
>> +     susp->mode2_reg = readl(susp->base + USP_MODE2);
>> +     sirf_usp_controller_uninit(susp);
>> +     clk_disable_unprepare(susp->clk);
>> +
>> +     return 0;
>> +}
>
> Can this be done as runtime PM as well?  Seems like it'd save power.

agree.

>
>> +     susp->clk = clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(susp->clk)) {
>> +             dev_err(&pdev->dev, "Get clock failed.\n");
>> +             return PTR_ERR(susp->clk);
>> +     }
>
> devm_clk_get().

agree. missed this one.

-barry
