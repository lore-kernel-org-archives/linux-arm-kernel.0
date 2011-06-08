From: prakity@marvell.com (Philip Rakity)
Date: Tue, 7 Jun 2011 20:59:41 -0700
Subject: [PATCH v2 1/3] mmc: support sdhci-mmp2
In-Reply-To: <BANLkTinTKV3DwVdi8p-BYCZ4ON_ce4T74g@mail.gmail.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
	<86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
	<BANLkTinTKV3DwVdi8p-BYCZ4ON_ce4T74g@mail.gmail.com>
Message-ID: <6B2AC372-8A17-41B9-AA5F-BBE5189D17C4@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Jun 7, 2011, at 7:56 PM, zhangfei gao wrote:

> On Wed, Jun 8, 2011 at 7:51 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> On May 29, 2011, at 10:42 PM, zhangfei gao wrote:
>> 
>>>> 
>>>> There is a little room for simplification, I think:
>>>> 
>>>>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>>>>> +{
>>>>> +     /* Micro SD does not support write-protect feature */
>>>>> +     return 0;
>>>>> +}
>>>> 
>>>> You shouldn't need to provide an empty get_ro function, the
>>>> default is that there is no write-protect.
>>> 
>>> Thanks Arnd for review.
>>> The reason to put get_ro here is some board use micro sd, while some
>>> board design is general sd card.
>>> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
>>> return 1 in our controller, so it shows read only.
>>> So add one call back for the board with micro sd card via flag.
>> 
>> 
>> 
>> The code sets get_ro is for all the controllers.   Some board designs may connect the WP signal.
>> 
>> The host->ops field should be filled in using information in the board
>> file using a flag such as the example with  PXA_FLAG_CARD_PERMANENT.
>> 
>> eg
>> 
>>        if (pdata && pdata->flags & PXA_FLAG_NO_WP) {
>>                ***** etc ****
>>        }
>> 
>> 
> 
> This method is used in v1,
> The method makes sdhci_ops non-const and have to dynamically alloc
> sdhci_ops, since host->ops is pointer.
> Will keep use const sdhci_ops, recommended by Arnd.


Not acceptable.  


There are  3 cases for  WP signal

a) They are connected to the controller using GPIO
b( They are NOT connected and the corresponding  pin is not used
c) They are NOT connected and the corresponding  pin is used by something else.

case a)
	program GPIO as is done today in brownstone and aspen

case b)
	configure the MFP pin to be pull high/low to indicate NO WP.  The pin cannot be left floating

case c)
	you need a quirk and the call back.
