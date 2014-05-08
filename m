From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 08 May 2014 14:30:55 +0200
Subject: [PATCH v10 03/15] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <CAPDyKFqbN61EgiTbktL-vm+L7q06OTeedCTVXJsP16ZZZd8g8A@mail.gmail.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>	<1399046249-19472-4-git-send-email-hdegoede@redhat.com>	<CAPDyKFoinhyob7GZLgH4Dm7KdHCxj1+OpuZYKDK3OkU8RFsY8A@mail.gmail.com>	<53678DB4.60209@redhat.com>	<CAPDyKFpAGNLaKagJ_RPt1vbz70pNWJzo-s6Ao50Mh0gFrRLN0g@mail.gmail.com>	<536B69FA.5090600@redhat.com>
 <CAPDyKFqbN61EgiTbktL-vm+L7q06OTeedCTVXJsP16ZZZd8g8A@mail.gmail.com>
Message-ID: <536B78FF.2020808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/08/2014 02:17 PM, Ulf Hansson wrote:
> On 8 May 2014 13:26, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 05/05/2014 10:33 PM, Ulf Hansson wrote:
>>> [snip]
>>>
>>>> On 05/05/2014 02:41 PM, Ulf Hansson wrote:
>>>>>> +struct sunxi_mmc_host {
>>>>>> +       struct mmc_host *mmc;
>>>>>> +       struct regulator *vmmc;
>>>>>
>>>>> Instead of having a specific regulator for this driver, please use the
>>>>> mmc_regulator_get_supply API.
>>>>
>>>> We cannot use mmc_regulator_get_supply because for the sunxi mmc controller
>>>> not only vqmmc but also vmmc itself is optional, and mmc_regulator_get_supply
>>>> calls devm_regulator_get rather then devm_regulator_get_optional for vmmc.
>>>
>>> Is that because the mmc controller handle the power to the card or
>>> because you have a fixed supply?
>>>
>>> Having a fixed regulator supply could easily be set up in DT, which
>>> then also dynamically gives you the ocr mask instead of having a them
>>> "hard coded".
>>
>> It is because the sdcard slot power tends to be hooked directly to the 3.3V
>> of the board. So in a sense this is a fixed regulator, but I really, REALLY
>> don't want to add fixed regulator boilerplate to all sunxi dts files for this.
> 
> So, how would you then distinguish between let's say a 3.1V and 3.3V
> fixed regulator? That is something that is board specific, thus I
> don't think you can get away from not adding them to DT.

All boards I've seen sofar use 3.3V which seems sensible since that is
what the spec says you must supply to SDSC cards. I agree that if a board
differs from the standard 3.3V, a fixed regulator node specifying the
voltage should be added.

Regards,

Hans
