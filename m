From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 8 Jun 2011 10:56:17 +0800
Subject: [PATCH v2 1/3] mmc: support sdhci-mmp2
In-Reply-To: <86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
	<86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
Message-ID: <BANLkTinTKV3DwVdi8p-BYCZ4ON_ce4T74g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 7:51 AM, Philip Rakity <prakity@marvell.com> wrote:
>
> On May 29, 2011, at 10:42 PM, zhangfei gao wrote:
>
>>>
>>> There is a little room for simplification, I think:
>>>
>>>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>>>> +{
>>>> + ? ? /* Micro SD does not support write-protect feature */
>>>> + ? ? return 0;
>>>> +}
>>>
>>> You shouldn't need to provide an empty get_ro function, the
>>> default is that there is no write-protect.
>>
>> Thanks Arnd for review.
>> The reason to put get_ro here is some board use micro sd, while some
>> board design is general sd card.
>> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
>> return 1 in our controller, so it shows read only.
>> So add one call back for the board with micro sd card via flag.
>
>
>
> The code sets get_ro is for all the controllers. ? Some board designs may connect the WP signal.
>
> The host->ops field should be filled in using information in the board
> file using a flag such as the example with ?PXA_FLAG_CARD_PERMANENT.
>
> eg
>
> ? ? ? ?if (pdata && pdata->flags & PXA_FLAG_NO_WP) {
> ? ? ? ? ? ? ? ?***** etc ****
> ? ? ? ?}
>
>

This method is used in v1,
The method makes sdhci_ops non-const and have to dynamically alloc
sdhci_ops, since host->ops is pointer.
Will keep use const sdhci_ops, recommended by Arnd.

>
>
>
