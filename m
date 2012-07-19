From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 20 Jul 2012 02:15:10 +0530
Subject: Devicetree: Initialization order of mmc block devices?
In-Reply-To: <5006C40D.300@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>
 <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
 <50068696.8070408@de.bosch.com>
 <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
 <5006C40D.300@de.bosch.com>
Message-ID: <CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2012 19:41, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
> On 07/18/2012 03:47 PM, Jassi Brar wrote:
>>
>> On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>>
>>> If a SD card is inserted at boot time, its "mmcblk0", the embedded
>>> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel
>>> the
>>> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>>>
>> How about  root=UUID=<eMMC-partition>  ?
>
> Because we are talking about an embedded device, it is very difficult to get
> a UUID of a eMMC partition into kernel command line with U-Boot. Handling of
> UUID is also a big effort at board manufacturing.
>
I don't realize how bad is it if a common UUID is used on each cloned
eMMC(non-removable) of every instance of a device. But of course only
you know what's best for your product.

>
> This problem can occur on many devices with embedded MMC and removable SD,
> e.g. smart phones. So I think we should find an solution to define MMC scan
> order or device number/name in a device tree.
>
I assume your issue is that due to async nature of mmc scanning, the
eMMC is detected later than external card, despite being the probe for
eMMC's slot initiated first ?
If so, we can do by simply associating 'N' of 'mmcblkN' with the slot
index i.e, mmc_host.index (instead of mmc_blk_data.name_idx). Which is
always in the order of probe calling. And we don't need to modify, or
expect more of, DT for that. Though I suspect there must be some
serious reason why it's not already done that way.
