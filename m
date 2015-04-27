From: stripathi@apm.com (Suman Tripathi)
Date: Mon, 27 Apr 2015 20:33:25 +0530
Subject: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
In-Reply-To: <8525627.D1S9aInyMV@wuerfel>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
 <1429630959-32649-3-git-send-email-stripathi@apm.com>
 <8525627.D1S9aInyMV@wuerfel>
Message-ID: <CAOHikRDkQwG+7EUddXmx427ZpEOjqTt22H_zzozABOE3a963tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> index bef250e..9f6a4b9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>
>                 if (of_get_property(np, "broken-cd", NULL))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +               if (of_get_property(np, "delay-after-power", NULL))
> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> +
> +               if (of_get_property(np, "no-hispd", NULL))
> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +               if (of_get_property(np, "broken-adma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +               if (of_get_property(np, "broken-dma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +               if (of_get_property(np, "no-cmd23", NULL))
> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>
>                 if (of_get_property(np, "no-1-8-v", NULL))
>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>

Any property you add needs to be documented in the DT binding.

If possible, add generic properties for each bug you have mmc.txt
rather than the driver specific sdhci.txt, and implement the
I will add the binding in mmc.txt. I thought this was present but not.

parsing in a common function that is used for all mmc hosts.
As per mine understanding the sdhci_get_of_porperty is a common
parsing function  . Am I wrong ??

An alternative would be to set all these bits based on the compatible
string of your host, if that is the only one that has all these bugs.

The host driver  (arasan) is reused but this quirks are needed due to
board issues. so I have a control over dtb only to fix this.

On Tue, Apr 21, 2015 at 9:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
>> index bef250e..9f6a4b9 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>>
>>                 if (of_get_property(np, "broken-cd", NULL))
>>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +
>> +               if (of_get_property(np, "delay-after-power", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>> +
>> +               if (of_get_property(np, "no-hispd", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> +
>> +               if (of_get_property(np, "broken-adma", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>> +
>> +               if (of_get_property(np, "broken-dma", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> +
>> +               if (of_get_property(np, "no-cmd23", NULL))
>> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>
>>                 if (of_get_property(np, "no-1-8-v", NULL))
>>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>
>
> Any property you add needs to be documented in the DT binding.
>
> If possible, add generic properties for each bug you have mmc.txt
> rather than the driver specific sdhci.txt, and implement the
> parsing in a common function that is used for all mmc hosts.
>
> An alternative would be to set all these bits based on the compatible
> string of your host, if that is the only one that has all these bugs.
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
