From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 16 Jan 2017 13:28:07 +0100
Subject: [PATCH 04/10] sata: hardreset: retry if phys link is down
In-Reply-To: <20170115231049.GC14446@mtj.duckdns.org>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-5-git-send-email-bgolaszewski@baylibre.com>
 <20170115231049.GC14446@mtj.duckdns.org>
Message-ID: <CAMpxmJUxSmNwGn+gEDZN0njnbMhmG4=1Oc1p56O7KiToBjp_FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-16 0:10 GMT+01:00 Tejun Heo <tj@kernel.org>:
> Hello,
>
> On Fri, Jan 13, 2017 at 01:37:58PM +0100, Bartosz Golaszewski wrote:
>> The sata core driver already retries to resume the link because some
>> controllers ignore writes to the SControl register.
>>
>> We have a use case with the da850 SATA controller where at PLL0
>> frequency of 456MHz (needed to properly service the LCD controller)
>> the chip becomes unstable and the hardreset operation is ignored the
>> first time 50% of times.
>>
>> Retrying just the resume operation doesn't work - we need to issue
>> the phy/wake reset again to make it work.
>>
>> If ata_phys_link_offline() returns true in sata_link_hardreset(),
>> retry a couple times before really giving up.
>
> I think it'd be better to implement the driver specific implementation
> rather than changing the behavior for everybody.
>
> Thanks.
>

For v2 I created a new ahci-locally exported function:
ahci_do_hardreset() that allows to retrieve the online state of the
link and used it in the da850-specific hardreset implementation.

Hope that'll be good.

Thanks,
Bartosz Golaszewski
