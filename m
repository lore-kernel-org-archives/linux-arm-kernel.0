From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 25 Nov 2016 16:04:50 +0200
Subject: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
In-Reply-To: <CAPDyKFr9uEjVQmTNP0KK8Zj9mxCW3i564E=47vTK0RLvXCjw3Q@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <0390e7a05b6163deabb545f93729ea615eeaaee2.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpqPSqiEi=0UW5LoZmy+y-KHm9nbcGKBSy3RzchdLU9cA@mail.gmail.com>
 <dd230463-04f6-df31-7056-1a185eb6cfc7@marvell.com>
 <CAPDyKFr9uEjVQmTNP0KK8Zj9mxCW3i564E=47vTK0RLvXCjw3Q@mail.gmail.com>
Message-ID: <88cb424b-7fbb-625f-1d83-be3418d4ae29@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/16 15:34, Ulf Hansson wrote:
> On 24 November 2016 at 13:41, Ziji Hu <huziji@marvell.com> wrote:
>> On 2016/11/24 18:43, Ulf Hansson wrote:
>>> On 31 October 2016 at 12:09, Gregory CLEMENT
>>> <gregory.clement@free-electrons.com> wrote:
>>>> From: Ziji Hu <huziji@marvell.com>
>>>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>>>> +                                            struct mmc_ios *ios)
>>>> +{
>>>> +       struct sdhci_host *host = mmc_priv(mmc);
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>> +
>>>> +       /*
>>>> +        * Before SD/SDIO set signal voltage, SD bus clock should be
>>>> +        * disabled. However, sdhci_set_clock will also disable the Internal
>>>> +        * clock in mmc_set_signal_voltage().
>>>
>>> If that's the case then that is wrong in the generic sdhci code.
>>> What's the reason why it can't be fixed there instead of having this
>>> workaround?
>>>
>>     In my very own opinion, SD Spec doesn't specify whether SDCLK should be
>>     enabled or not during power setting.
>>     Enabling SDCLK might be a special condition only required by our SDHC.
>>     I try to avoid breaking other vendors' SDHC functionality
>>     if their SDHCs require SDCLK disabled.
>>     Thus I prefer to keep it inside our SDHC driver.
> 
> I let Adrian comment on this.
> 
> For sure we should avoid breaking other sdhci variant, but on the
> other hand *if* the generic code is wrong we should fix it!

Yes, this looks like something that could perhaps be fixed in sdhci.  I will
look into it.
