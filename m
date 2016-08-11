From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 11 Aug 2016 13:57:50 +0200
Subject: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
In-Reply-To: <cf38cffa-558e-a5fc-9ecb-b8f46f07153f@samsung.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
 <0e38d62a-b3d0-30ca-fca9-bb740ae54d0a@denx.de>
 <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
 <CGME20160807020731epcas1p1ba77eafc6a099ac660a4bf5fe3789fef@epcas1p1.samsung.com>
 <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
 <cf38cffa-558e-a5fc-9ecb-b8f46f07153f@samsung.com>
Message-ID: <d61bd21c-4c93-13ed-7e60-68a42453f591@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.08.2016 um 13:12 schrieb Jaehoon Chung:
> On 08/07/2016 11:07 AM, Shawn Lin wrote:
>> ? 2016/8/6 22:18, Stefan Wahren ??:
>>> Hi Marek,
>>>
>>>> Marek Vasut <marex@denx.de> hat am 6. August 2016 um 15:14 geschrieben:
>>>>
>>>>
>>>> On 08/06/2016 02:55 PM, Stefan Wahren wrote:
>>>>> This patch based on the work of Fabio Estevam:
>>>>> "[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
>>>>> 'no-1-8-v' is present"
>>>>>
>>>>> It adds the support for 3.3V only DDR MMC hosts.
>>>>
>>>> Do such cards even exist ? Do you have a link where I can find some ?
>>>
>>> i never said anything about SD cards. I mean eMMC modules which usually have 8
>>> data pins like this one [1].
>>>
>>> Please don't blame me if it's not compatible to i.MX28. It's only an example.
>>>
>>> [1] -
>>> http://datasheet.octopart.com/THGBM3G4D1FBAIGH2H-Toshiba-datasheet-20748880.pdf
>>
>>
>> I download the datasheet you mentioned, and I explicitly see it
>> describe 1V8 everywhere, especially for the section of "ELECTRICAL
>> CHARACTERISTICS".
>>
>> I never see one eMMC claiming DDR52 capability but doesn't support 1V8
>> so far. Could you kindly share me the part number of the eMMC you are
>> using? :)
>>
>>>
>>>>
>>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> ---
>>>>>  drivers/mmc/core/host.c  |    2 ++
>>>>>  drivers/mmc/core/mmc.c   |    6 ++++++
>>>>>  include/linux/mmc/host.h |    1 +
>>>>>  3 files changed, 9 insertions(+)
>>>>>
>>>>> Changes to Fabio's patch:
>>>>> - rebase to current linux-next
>>>>> - rename DT property to mmc-ddr-3_3v
>>>>> - use EXT_CSD_CARD_TYPE_DDR_52 instead of new define
>>>>>
>>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>>> index 98f25ff..4c971de 100644
>>>>> --- a/drivers/mmc/core/host.c
>>>>> +++ b/drivers/mmc/core/host.c
>>>>> @@ -301,6 +301,8 @@ int mmc_of_parse(struct mmc_host *host)
>>>>>      if (of_property_read_bool(np, "wakeup-source") ||
>>>>>          of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
>>>>>          host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>>>>> +    if (of_property_read_bool(np, "mmc-ddr-3_3v"))
>>>>> +        host->caps2 |= MMC_CAP2_3_3V_ONLY_DDR;
>>>>>      if (of_property_read_bool(np, "mmc-ddr-1_8v"))
>>>>>          host->caps |= MMC_CAP_1_8V_DDR;
>>>>>      if (of_property_read_bool(np, "mmc-ddr-1_2v"))
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index f2d185c..8a933d5 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -210,6 +210,12 @@ static void mmc_select_card_type(struct mmc_card *card)
>>>>>          avail_type |= EXT_CSD_CARD_TYPE_HS_52;
>>>>>      }
>>>>>
>>>>> +    if (caps2 & MMC_CAP2_3_3V_ONLY_DDR &&
>>>>> +        card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>>>>> +        hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>>>> +        avail_type |= EXT_CSD_CARD_TYPE_DDR_52;
>>>>> +    }
>
> did you know EXT_CSD_CARD_TYPE_DDR_52 -> TYPE_DDR_1_8V and TYPE_DDR_1_2V?

Thanks for pointing out. Fabio's patch was better here.

As i wrote to Shawn the subject line is incorrect. I want to add 3.3V 
only support for hosts not for "card".

According to the comments EXT_CSD_CARD_TYPE_DDR_1_8V stands for 1.8V or 
3.3V. So i better add EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY even the "card" 
supports 1.8V.
