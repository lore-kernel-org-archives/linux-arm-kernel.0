From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 29 Jan 2015 11:01:44 +0100
Subject: [PATCH v2 1/7] mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities
 for the Armada 38x flavor
In-Reply-To: <54CA006F.8060108@free-electrons.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
 <1422010594-1735-2-git-send-email-gregory.clement@free-electrons.com>
 <CAPDyKFp=TxkL4BPMxVU+pMPoCQ1xPq0XZ+ZPpBFFaDnNtFjynw@mail.gmail.com>
 <54C9EFC9.7090809@free-electrons.com>
 <CAPDyKFqXLb+BOrotBv9UKDeSCriK2k9qmxKoUrWTKK7uM2oLTw@mail.gmail.com>
 <54CA006F.8060108@free-electrons.com>
Message-ID: <CAPDyKFoq+Z_n0GHkA4tWJp6vV_T+Fo3zm=CBfmNS+KN70qqwZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 10:42, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Ulf,
>
> On 29/01/2015 10:31, Ulf Hansson wrote:
>> [...]
>>
>>>> Seems like this function can be void instead of always returning 0.
>>>
>>> In patch 4 "mmc: sdhci-pxav3: Modify clock settings for the SDR50 and
>>> DDR50 modes", this function can return other values than 0.
>>>
>>> I could change the prototype in patch 4, but it would also imply
>>> removing the test of the return value in this patch and adding in back
>>> patch 4. By returning a value in this patch, it reduced the amount of
>>> change over the patches.
>>>
>>> But if you still prefer than I this function return void in this
>>> patch, I can do it.
>>
>> No worries, let's keep it as an int. But then I have a few other
>> comments, see below.
>
> OK
>
>>
>>>
>>>
>>> Thanks,
>>>
>>> Gregory
>>>
>>>
>>>>
>>>>> +{
>>>>> +       host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>>>>> +       /*
>>>>> +        * According to erratum 'FE-2946959' both SDR50 and DDR50
>>>>> +        * modes require specific clock adjustments in SDIO3
>>>>> +        * Configuration register, if the adjustment is not done,
>>>>> +        * remove them from the capabilities.
>>>>> +        */
>>>>> +       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>  static void pxav3_reset(struct sdhci_host *host, u8 mask)
>>>>>  {
>>>>>         struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
>>>>> @@ -319,6 +333,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>>>>                 clk_prepare_enable(pxa->clk_core);
>>>>>
>>>>>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>>>>> +               ret = armada_38x_quirks(host);
>>>>> +               if (ret < 0)
>>
>> Since in patch 4 you return a proper error code, let's also adopt to
>> that here by changing to:
>>
>> "if (IS_ERR(ret))
>
> The function returns an int and IS_ERR expects a pointer. I am not sure
> this macro would be appropriate here.

You are right. Don't know what I was thinking. :-)

Kind regards
Uffe
