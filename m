From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 10:22:04 +0200
Subject: [PATCH v8 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <5356063C.6070100@linaro.org>
References: <1397869980-21187-1-git-send-email-zhangfei.gao@linaro.org>
 <535561BE.9070303@cogentembedded.com> <5356063C.6070100@linaro.org>
Message-ID: <10652983.rXrAGMo8Yn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 14:03:40 zhangfei wrote:
> On 04/22/2014 02:21 AM, Sergei Shtylyov wrote:
> > On 04/21/2014 10:03 PM, Florian Fainelli wrote:
> >
> >>>> Hisilicon hip04 platform mdio driver
> >>>> Reuse Marvell phy drivers/net/phy/marvell.c
> >
> >>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >>> [...]
> >
> >>>> diff --git a/drivers/net/ethernet/hisilicon/hip04_mdio.c
> >>>> b/drivers/net/ethernet/hisilicon/hip04_mdio.c
> >>>> new file mode 100644
> >>>> index 0000000..19826a3
> >>>> --- /dev/null
> >>>> +++ b/drivers/net/ethernet/hisilicon/hip04_mdio.c
> >>>> @@ -0,0 +1,185 @@
> >>>> +static int hip04_mdio_reset(struct mii_bus *bus)
> >>>> +{
> >>>> +       int temp, err, i;
> >>>> +
> >>>> +       for (i = 0; i < PHY_MAX_ADDR; i++) {
> >>>> +               hip04_mdio_write(bus, i, 22, 0);
> >
> >>>     Why? What kind of a register this is? <uapi/linux/mii.h> tells me
> >>> it's
> >>> MII_SREVISION...
> >
> >> I think this rather means clause 22 as opposed to clause 45.
> >
> >     No, the corresponding hip04_mdio_write()'s parameter is a register
> > #, so this is a write of 0 to register #22. A comment certainly wouldn't
> > hurt here...
> 
> It's private register of the phy marvell 88e1512.
> To make it clearer using define instead.
> #define MII_MARVELL_PHY_PAGE    22
> 
> The registers has been grouped into several pages, access register need 
> choose which page first.

You shouldn't touch the PHY private registers in the main driver though,
this should be purely handled by drivers/net/phy/marvell.c.

I don't see support for 88e1512 there, only 88e1510 and lots of older
ones, but I assume it isn't hard to add.

	Arnd
