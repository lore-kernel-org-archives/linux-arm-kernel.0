From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 22 Apr 2014 22:16:06 +0800
Subject: [PATCH v8 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <10652983.rXrAGMo8Yn@wuerfel>
References: <1397869980-21187-1-git-send-email-zhangfei.gao@linaro.org>
 <535561BE.9070303@cogentembedded.com> <5356063C.6070100@linaro.org>
 <10652983.rXrAGMo8Yn@wuerfel>
Message-ID: <535679A6.4020103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/22/2014 04:22 PM, Arnd Bergmann wrote:

>> It's private register of the phy marvell 88e1512.
>> To make it clearer using define instead.
>> #define MII_MARVELL_PHY_PAGE    22
>>
>> The registers has been grouped into several pages, access register need
>> choose which page first.
>
> You shouldn't touch the PHY private registers in the main driver though,
> this should be purely handled by drivers/net/phy/marvell.c.
>
> I don't see support for 88e1512 there, only 88e1510 and lots of older
> ones, but I assume it isn't hard to add.
>

88e1512 driver is already supported, same as 88e1510.
#define MARVELL_PHY_ID_MASK             0xfffffff0
So it should support 88e151x.

Reset is required here for get_phy_id, otherwise only 0 can be get.
phy_device_create will not be called, and can not match any driver.

However in the experiment, it is found BMCR_RESET is not required in fact.
Only hip04_mdio_write(bus, i, MII_MARVELL_PHY_PAGE, 0) has to be set.
88e151x registers are divided into pages.
Generic MII registers is in page 0, including MII_PHYSID1 and MII_PHYSID2.
Unfortunately the default page is not 0, so get_phy_id will fail.

So bus->reset still required to set the page to 0, prepared for get_phy_id.

Thanks
