From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 24 Apr 2014 21:00:49 +0800
Subject: [PATCH v8 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <201404241428.10248.arnd@arndb.de>
References: <1397869980-21187-1-git-send-email-zhangfei.gao@linaro.org>
 <201404221630.07865.arnd@arndb.de> <53568398.2030800@linaro.org>
 <201404241428.10248.arnd@arndb.de>
Message-ID: <53590B01.8070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/24/2014 08:28 PM, Arnd Bergmann wrote:
> On Tuesday 22 April 2014, zhangfei wrote:
>> On 04/22/2014 10:30 PM, Arnd Bergmann wrote:
>>> On Tuesday 22 April 2014, zhangfei wrote:
>>>> On 04/22/2014 04:22 PM, Arnd Bergmann wrote:
>
>>> But it means that the hip04_mdio driver potentially won't work if connected
>>> to something other than a Marvell PHY.
>>>
>>> I noticed that the marvell_of_reg_init() does this at init time:
>>>
>>> saved_page = phy_read(phydev, MII_MARVELL_PHY_PAGE);
>>> ... /* perform init */
>>> if (page_changed)
>>>        phy_write(phydev, MII_MARVELL_PHY_PAGE, saved_page);
>>>
>>> Is this a bug? Maybe it should always set page 0 when leaving
>>> this function.
>>>
>> It is correct behavior return to the original page.
>>
>> First get_phy_id, then match driver according to the id, then operation
>> in the specific driver have the chance to run, including
>> marvell_of_reg_init etc.
>>
>> Just unlucky the default value of PHY_PAGE after power on is not 0.
>
> Ok, so it's actually not possible to detect this case prior to having
> to work around it.
>
> How about adding a DT property as a flag to tell the driver whether
> to set the page to zero or not? That would let the driver work
> with different types of PHY implementations, or skip the code if
> there is firmware that can already set it up to page zero.
>

Currently we suspect it maybe caused by bootloader (uefi) has accessed 
page register and forgot to recover, still in double confirm.
Even it not caused by uefi, we can set to page 0 in uefi, and let mdio 
driver common to other phy.
So we may remove the bus->reset, and let uefi do the preparation.

Thanks
