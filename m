From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 11 Dec 2013 13:06:41 +0800
Subject: [PATCH 5/6] mmc: sdhci: calculate max_discard_to dynamically for
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
In-Reply-To: <20131211040511.GJ18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-6-git-send-email-b29396@freescale.com>
 <20131211040511.GJ18380@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=R1K3g+h-0FWprRjqJ_wtsF=DyV4pY3coxocanfaOwWig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 12:05 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 10, 2013 at 08:56:07PM +0800, Dong Aisheng wrote:
>>  static inline void sdhci_update_clock(struct sdhci_host *host)
>> @@ -2939,10 +2952,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>       if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>>               host->timeout_clk = mmc->f_max / 1000;
>
> Since max_discard_to calculation below will not happen for
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK case, does it still make sense to
> keep the above code?
>

Right, i missed to remove it.
Will update in v2.

> Or put it in the other way, if we keep the above code and do not make
> the change below, will there be any problem besides the max_discard_to
> initialization plays for nothing?
>
> All in all, I'm just confused why we keep the above code and make the
> change below at the same time.
>

THe max_discard_to should be dynamically updated for
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
when changing the clock, so we can remove above lines.

Regards
Dong Aisheng

> Shawn
>
>>
>> -     if (host->ops->get_max_timeout)
>> -             mmc->max_discard_to = host->ops->get_max_timeout(host);
>> -     else
>> -             mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>> +     if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
>> +             if (host->ops->get_max_timeout)
>> +                     mmc->max_discard_to = host->ops->get_max_timeout(host);
>> +             else
>> +                     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>> +     }
>>
>>       mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>>
>> --
>> 1.7.2.rc3
>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
