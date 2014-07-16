From: Vincent.Yang@tw.fujitsu.com (Vincent.Yang)
Date: Wed, 16 Jul 2014 19:07:49 +0800
Subject: [PATCH 2/8] mmc: sdhci: host: add new f_sdh30
In-Reply-To: <5526913.sJ4RMkanr6@wuerfel>
References: <1405232971-4607-1-git-send-email-mollie.wu@linaro.org>
 <7710458.qT0KZ5qsA6@wuerfel>
 <830AC58E49A426478AC39824BC0FA915D8B8FF0609@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
 <5526913.sJ4RMkanr6@wuerfel>
Message-ID: <830AC58E49A426478AC39824BC0FA915D8B8FF061A@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>On Wednesday 16 July 2014 17:35:41 Vincent. Yang wrote:
>
>> >
>> >> +unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>> >> +{
>> >> +     return F_SDH30_MIN_CLOCK;
>> >> +}
>> >> +
>> >> +void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>> >> +{
>> >> +     struct f_sdhost_priv *priv = sdhci_priv(host);
>> >> +
>> >> +     if (gpio_is_valid(priv->gpio_select_1v8))
>> >> +             gpio_direction_output(priv->gpio_select_1v8, 1);
>> >> +
>> >> +     if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0) {
>> >> +             sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
>> >> +             mmiowb();
>> >> +     }
>> >
>> >Can you explain the mmiowb call here?
>>
>> This came from the original 3.0 based driver. It's trying to be a
>> write memory barrier. It wants to ensure the clock control change
>> actually happened before the following code.
>> I'll change it to a regular wmb in next version.
>
>Note that with 'readw'/writew', you shouldn't need any extra barriers.
>If sdhci_writew() is readw_relaxed(), wmb() is the correct barrier.

Hi Arnd,
The sdhci_writew() is using writew(), so I shouldn't need any extra
barriers. I'll remove them in next version.
Thanks a lot for your review!


Best regards,
Vincent Yang

>
>> >> +
>> >> +     if (!of_property_read_u32(pdev->dev.of_node, "bus-width",
>&bus_width))
>> >{
>> >> +             switch (bus_width) {
>> >> +             case 8:
>> >> +                     dev_info(dev, "Applying 8 bit bus width\n");
>> >> +                     host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>> >> +                     break;
>> >> +             case 4:
>> >> +                     dev_info(dev, "Applying 4 bit bus width\n");
>> >> +                     host->mmc->caps |= MMC_CAP_4_BIT_DATA;
>> >> +                     break;
>> >> +             case 1:
>> >> +             default:
>> >> +                     dev_err(dev, "Invalid bus width: %u\n", bus_width);
>> >> +                     break;
>> >> +             }
>> >> +     }
>> >
>> >This should probably be done in generic sdhci code somewhere. How about
>> >adding it to sdhci_get_of_property instead_
>>
>> I should use generic mmc_of_parse for it. I'll update it in next version.
>
>Ah right, I thought we had this in common code already but couldn't find
>it. Using mmc_of_parse() is definitely the correct solution here.
>
>> >> +     priv->clk_sd4 = clk_get(&pdev->dev, "sd_sd4clk");
>> >> +     if (!IS_ERR(priv->clk_sd4)) {
>> >> +             ret = clk_prepare_enable(priv->clk_sd4);
>> >> +             if (ret < 0) {
>> >> +                     dev_err(dev, "Failed to enable sd4 clock: %d\n", ret);
>> >> +                     goto err_clk1;
>> >> +             }
>> >> +     }
>> >> +     priv->clk_b = clk_get(&pdev->dev, "sd_bclk");
>> >> +     if (!IS_ERR(priv->clk_b)) {
>> >> +             ret = clk_prepare_enable(priv->clk_b);
>> >> +             if (ret < 0) {
>> >> +                     dev_err(dev, "Failed to enable clk_b clock: %d\n", ret);
>> >> +                     goto err_clk2;
>> >> +             }
>> >> +     }
>> >
>> >Please pick clock names that match what some of the other drivers use.
>>
>> I'll use "iface" and "core" for clock names because they match what used
>> in sdhci-msm driver.
>
>Ok, makes sense.
>
>        Arnd
