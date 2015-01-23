From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jan 2015 15:18:47 +0100
Subject: [PATCH v2 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's
 caps according to erratum ERR-7878951
In-Reply-To: <CAPv3WKe3BNLv1ODA1ZZ2ALWeEr2LrO0vZxi=mG3G+ObxSakeSA@mail.gmail.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>	<1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKe3BNLv1ODA1ZZ2ALWeEr2LrO0vZxi=mG3G+ObxSakeSA@mail.gmail.com>
Message-ID: <54C25847.8030701@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On 23/01/2015 12:33, Marcin Wojtas wrote:
> Dear Gregory,
> 
> 
>> @@ -118,8 +118,11 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>         return 0;
>>  }
>>
>> -static int armada_38x_quirks(struct sdhci_host *host)
>> +static int armada_38x_quirks(struct platform_device *pdev,
>> +                            struct sdhci_host *host)
>>  {
>> +       struct device_node *np = pdev->dev.of_node;
>> +
>>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>>         /*
>>          * According to erratum 'FE-2946959' both SDR50 and DDR50
>> @@ -129,6 +132,20 @@ static int armada_38x_quirks(struct sdhci_host *host)
>>          */
>>         host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
>> +
>> +       /*
>> +        * According to erratum 'ERR-7878951' Armada 38x SDHCI
>> +        * controller has different capabilities than the ones shown
>> +        * in its registers
>> +        */
>> +       host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +       if (of_get_property(np, "no-1-8-v", NULL)) {
>> +               host->caps &= ~SDHCI_CAN_VDD_180;
>> +               host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
>> +       } else
>> +               host->caps &= ~SDHCI_CAN_VDD_330;
> 
> In this "else" there is one thing missing
> host->mmc->caps |= MMC_CAP_1_8V_DDR;
> because it's not set by default, however it's not a must - please see
> my remark below.
> 
>> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_USE_SDR50_TUNING);
>> +
>>         return 0;
>>  }
>>
>> @@ -333,7 +350,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>                 clk_prepare_enable(pxa->clk_core);
>>
>>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>> -               ret = armada_38x_quirks(host);
>> +               ret = armada_38x_quirks(pdev, host);
>>                 if (ret < 0)
>>                         goto err_quirks;
>>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>> @@ -341,9 +358,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>                         goto err_mbus_win;
>>         }
>>
>> -       /* enable 1/8V DDR capable */
>> -       host->mmc->caps |= MMC_CAP_1_8V_DDR;
>> -
> 
> Now, with this change MMC_CAP_1_8V_DDR is disabled for devices other
> than Armada 38x, that use sdhci-pxav3. There are two options:
> 1. Move those lines above the place where armada_38x_quirks is called
> (IMO the easiest option - 'else' in this function would not need to be
> supplemented, as I pointed above)
> 2. Leave it "as is" here, but a condition below is needed (+
> supplementation of 'else' in armada_38x_quirks)
>  if (!of_device_is_compatible(np, "marvell,armada-380-sdhci"))
> 

I will take the first option.

A third version is coming soon addressing also Mark's comments.

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
