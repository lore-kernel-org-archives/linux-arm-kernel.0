From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 11 Aug 2016 20:12:59 +0900
Subject: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
In-Reply-To: <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
 <0e38d62a-b3d0-30ca-fca9-bb740ae54d0a@denx.de>
 <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
 <CGME20160807020731epcas1p1ba77eafc6a099ac660a4bf5fe3789fef@epcas1p1.samsung.com>
 <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
Message-ID: <cf38cffa-558e-a5fc-9ecb-b8f46f07153f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2016 11:07 AM, Shawn Lin wrote:
> ? 2016/8/6 22:18, Stefan Wahren ??:
>> Hi Marek,
>>
>>> Marek Vasut <marex@denx.de> hat am 6. August 2016 um 15:14 geschrieben:
>>>
>>>
>>> On 08/06/2016 02:55 PM, Stefan Wahren wrote:
>>>> This patch based on the work of Fabio Estevam:
>>>> "[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
>>>> 'no-1-8-v' is present"
>>>>
>>>> It adds the support for 3.3V only DDR MMC hosts.
>>>
>>> Do such cards even exist ? Do you have a link where I can find some ?
>>
>> i never said anything about SD cards. I mean eMMC modules which usually have 8
>> data pins like this one [1].
>>
>> Please don't blame me if it's not compatible to i.MX28. It's only an example.
>>
>> [1] -
>> http://datasheet.octopart.com/THGBM3G4D1FBAIGH2H-Toshiba-datasheet-20748880.pdf
> 
> 
> I download the datasheet you mentioned, and I explicitly see it
> describe 1V8 everywhere, especially for the section of "ELECTRICAL
> CHARACTERISTICS".
> 
> I never see one eMMC claiming DDR52 capability but doesn't support 1V8
> so far. Could you kindly share me the part number of the eMMC you are
> using? :)
> 
>>
>>>
>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> ---
>>>>  drivers/mmc/core/host.c  |    2 ++
>>>>  drivers/mmc/core/mmc.c   |    6 ++++++
>>>>  include/linux/mmc/host.h |    1 +
>>>>  3 files changed, 9 insertions(+)
>>>>
>>>> Changes to Fabio's patch:
>>>> - rebase to current linux-next
>>>> - rename DT property to mmc-ddr-3_3v
>>>> - use EXT_CSD_CARD_TYPE_DDR_52 instead of new define
>>>>
>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>> index 98f25ff..4c971de 100644
>>>> --- a/drivers/mmc/core/host.c
>>>> +++ b/drivers/mmc/core/host.c
>>>> @@ -301,6 +301,8 @@ int mmc_of_parse(struct mmc_host *host)
>>>>      if (of_property_read_bool(np, "wakeup-source") ||
>>>>          of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
>>>>          host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>>>> +    if (of_property_read_bool(np, "mmc-ddr-3_3v"))
>>>> +        host->caps2 |= MMC_CAP2_3_3V_ONLY_DDR;
>>>>      if (of_property_read_bool(np, "mmc-ddr-1_8v"))
>>>>          host->caps |= MMC_CAP_1_8V_DDR;
>>>>      if (of_property_read_bool(np, "mmc-ddr-1_2v"))
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index f2d185c..8a933d5 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -210,6 +210,12 @@ static void mmc_select_card_type(struct mmc_card *card)
>>>>          avail_type |= EXT_CSD_CARD_TYPE_HS_52;
>>>>      }
>>>>
>>>> +    if (caps2 & MMC_CAP2_3_3V_ONLY_DDR &&
>>>> +        card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>>>> +        hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>>> +        avail_type |= EXT_CSD_CARD_TYPE_DDR_52;
>>>> +    }

did you know EXT_CSD_CARD_TYPE_DDR_52 -> TYPE_DDR_1_8V and TYPE_DDR_1_2V?
It means card can use to the 1.8v and 1.2v ddr mode.
So this patch is strange..You added capability for only supporting 3_3v.

Confusing...

Best Regards,
Jaehoon Chung

>>>> +
>>>>      if (caps & MMC_CAP_1_8V_DDR &&
>>>>          card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>>>>          hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index aa4bfbf..db0775d 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -311,6 +311,7 @@ struct mmc_host {
>>>>  #define MMC_CAP2_HS400_ES    (1 << 20)    /* Host supports enhanced strobe */
>>>>  #define MMC_CAP2_NO_SD        (1 << 21)    /* Do not send SD commands during
>>>> initialization */
>>>>  #define MMC_CAP2_NO_MMC        (1 << 22)    /* Do not send (e)MMC commands during
>>>> initialization */
>>>> +#define MMC_CAP2_3_3V_ONLY_DDR    (1 << 23)    /* Only supports 3.3V DDR */
>>>>
>>>>      mmc_pm_flag_t        pm_caps;    /* supported pm features */
>>>>
>>>>
>>>
>>>
>>> -- 
>>> Best regards,
>>> Marek Vasut
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
