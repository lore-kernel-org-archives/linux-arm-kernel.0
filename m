From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 23 Jan 2015 12:12:59 +0100
Subject: [PATCH v2 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's caps
 according to erratum ERR-7878951
In-Reply-To: <20150123110303.GD23493@leverpostej>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
 <1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
 <20150123110303.GD23493@leverpostej>
Message-ID: <CAPv3WKfGtJOYO+t+OzawhHyK4vpGAFFmK487ybUtZB7RL05c1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

2015-01-23 12:03 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> [...]
>
>> +     /*
>> +      * According to erratum 'ERR-7878951' Armada 38x SDHCI
>> +      * controller has different capabilities than the ones shown
>> +      * in its registers
>> +      */
>> +     host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +     if (of_get_property(np, "no-1-8-v", NULL)) {
>
> Please use of_property_read_bool(np, "no-1-8-v")
>
>> +             host->caps &= ~SDHCI_CAN_VDD_180;
>> +             host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
>
> Is SDHCI_CAN_VDD_330 always set elsewhere in this case?

Yes, it's always set in SDHCI_CAPABILITIES register of Armada 38x
(assigned to host->caps few lines above), as well as
SDHCI_CAN_VDD_180. The point is, that in reality they can't be used
simultaneously for this device, i.e. voltage switching is impossible.

Thanks,
Marcin

>
>> +     } else
>> +             host->caps &= ~SDHCI_CAN_VDD_330;
>
