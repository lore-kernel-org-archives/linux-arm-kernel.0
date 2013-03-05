From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 5 Mar 2013 10:03:01 +0800
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <20130304142143.GG3397@arwen.pp.htv.fi>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
 <1361419646-9052-2-git-send-email-chao.xie@marvell.com>
 <20130304142143.GG3397@arwen.pp.htv.fi>
Message-ID: <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 4, 2013 at 10:21 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Feb 20, 2013 at 11:07:11PM -0500, Chao Xie wrote:
>> The PHY is seperated from usb controller.
>> The usb controller used in marvell pxa168/pxa910/mmp2 are same,
>> but PHY initialization may be different.
>> the usb controller can support udc/otg/ehci, and for each of
>> the mode, it need PHY to initialized before use the controller.
>> Direclty writing the phy driver will make the usb controller
>> driver to be simple and portable.
>> The PHY driver will be used by marvell udc/otg/ehci.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>>  drivers/usb/phy/Kconfig              |    7 +
>>  drivers/usb/phy/Makefile             |    1 +
>>  drivers/usb/phy/mv_usb2_phy.c        |  402 ++++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/mv_usb.h |    9 +-
>>  include/linux/usb/mv_usb2.h          |   32 +++
>>  5 files changed, 448 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/usb/phy/mv_usb2_phy.c
>>  create mode 100644 include/linux/usb/mv_usb2.h
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index 65217a5..5479760 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -73,3 +73,10 @@ config SAMSUNG_USBPHY
>>       help
>>         Enable this to support Samsung USB phy controller for samsung
>>         SoCs.
>> +
>> +config MV_USB2_PHY
>> +     tristate "Marvell USB 2.0 PHY Driver"
>> +     depends on USB || USB_GADGET
>
> NAK, PHYs don't depend on the gadget framework.

Sure, i will remove it.

>
>> +     help
>> +       Enable this to support Marvell USB 2.0 phy driver for Marvell
>> +       SoC.
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index b13faa1..3835316 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_MV_U3D_PHY)            += mv_u3d_phy.o
>>  obj-$(CONFIG_USB_EHCI_TEGRA) += tegra_usb_phy.o
>>  obj-$(CONFIG_USB_RCAR_PHY)           += rcar-phy.o
>>  obj-$(CONFIG_SAMSUNG_USBPHY)         += samsung-usbphy.o
>> +obj-$(CONFIG_MV_USB2_PHY)            += mv_usb2_phy.o
>> diff --git a/drivers/usb/phy/mv_usb2_phy.c b/drivers/usb/phy/mv_usb2_phy.c
>> new file mode 100644
>> index 0000000..a81e5e4
>> --- /dev/null
>> +++ b/drivers/usb/phy/mv_usb2_phy.c
>> @@ -0,0 +1,402 @@
>> +/*
>> + * Copyright (C) 2013 Marvell Inc.
>> + *
>> + * Author:
>> + *   Chao Xie <xiechao.mail@gmail.com>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>>
>> +#define UTMI_CTRL            0x4
>> +#define UTMI_PLL             0x8
>> +#define UTMI_TX                      0xc
>> +#define UTMI_RX                      0x10
>> +#define UTMI_IVREF           0x14
>> +#define UTMI_T0                      0x18
>> +#define UTMI_T1                      0x1c
>> +#define UTMI_T2                      0x20
>> +#define UTMI_T3                      0x24
>> +#define UTMI_T4                      0x28
>> +#define UTMI_T5                      0x2c
>> +#define UTMI_RESERVE         0x30
>> +#define UTMI_USB_INT         0x34
>> +#define UTMI_DBG_CTL         0x38
>> +#define UTMI_OTG_ADDON               0x3c
>
> prepend these with MV_USB_

Fine.

>
>> +enum mv_usb2_phy_type {
>> +     PXA168_USB,
>> +     PXA910_USB,
>> +     MMP2_USB,
>> +};
>
>
> ewww... you really don't need (and *shouldn't* use) u2o_set() or
> u2o_clear(). They clearly prevent compiler from optimizing variable
> usage and could cause pressure on your interconnect. By writing and
> reading multiple times for no reason.
>

The APIs defined here is for device operation. The device register
read/write is not same as memory.
When a silicon comes, it may not be stable, and will have done some
workaround epecially for the
device register read/write. to define the APIs for the register
read/write will help to implement the workaround
without changing phy init code every time.
Now the only constrain is should read back the registers if you have
writen to it.
It will low down the performance, but it does not matter. Because phy
init will only done once when you initialize it.
I will think about reove the u2o_xxx APIs.

>> +static int _mv_usb2_phy_init(struct mv_usb2_phy *mv_phy)
>> +{
>> +     struct platform_device *pdev = mv_phy->pdev;
>> +     unsigned int loops = 0;
>> +     void __iomem *base = mv_phy->base;
>> +
>> +     dev_dbg(&pdev->dev, "phy init\n");
>
> remove this debugging message.
>
>> +     /* Initialize the USB PHY power */
>> +     if (mv_phy->type == PXA910_USB) {
>
> you _do_ have a REVISION register. Are you 100% certain that revision is
> the same on all your devices ? It seems to me that you should be doing
> proper revision detection instead of adding the hacky enumeration of
> yours.

We do not have revison registers and will do not want ot define
#ifdef CPU_PXA910 or CPU_PXA_XXX
or
use is_cpu_pxa910 or cpu_pxa_xxx
because it is not acceptable. for example, if we have new SOC and it
use the same PHY as pxa910
i have to change the USB driver code to support it. for example
#ifdef CPU_PXA910 || CPU_XXX

So i have to depends on the device_id to do the work.
>
>> +     /* UTMI_IVREF */
>> +     if (mv_phy->type == PXA168_USB)
>> +             /* fixing Microsoft Altair board interface with NEC hub issue -
>> +              * Set UTMI_IVREF from 0x4a3 to 0x4bf */
>
> wrong comment style. Run *ALL* your patches through checkpatch.pl
> --strict and sparse.
>

It seems that checkpatch.pl can not detect everything. I really use
checpatch.pl for
every patch i sent to maillist.
sorry for that, i will fix it.

>> +             u2o_write(base, UTMI_IVREF, 0x4bf);
>> +
>> +     /* toggle VCOCAL_START bit of UTMI_PLL */
>> +     udelay(200);
>
> why the udelay() calls ? Add a comment to code explaining them.
>
>> +     u2o_set(base, UTMI_PLL, VCOCAL_START);
>> +     udelay(40);
>> +     u2o_clear(base, UTMI_PLL, VCOCAL_START);
>> +
>> +     /* toggle REG_RCAL_START bit of UTMI_TX */
>> +     udelay(400);
>> +     u2o_set(base, UTMI_TX, REG_RCAL_START);
>> +     udelay(40);
>> +     u2o_clear(base, UTMI_TX, REG_RCAL_START);
>> +     udelay(400);
>> +
>> +     /* Make sure PHY PLL is ready */
>> +     loops = 0;
>> +     while ((u2o_get(base, UTMI_PLL) & PLL_READY) == 0) {
>> +             mdelay(1);
>> +             loops++;
>> +             if (loops > 100) {
>> +                     dev_warn(&pdev->dev, "calibrate timeout, UTMI_PLL %x\n",
>> +                             u2o_get(base, UTMI_PLL));
>
> if this fails, shouldn't you return an error code ?
>

yes. it should return the error code.

>> +static int _mv_usb2_phy_shutdown(struct mv_usb2_phy *mv_phy)
>> +{
>> +     void __iomem *base = mv_phy->base;
>> +
>> +     if (mv_phy->type == PXA168_USB)
>> +             u2o_clear(base, UTMI_OTG_ADDON, UTMI_OTG_ADDON_OTG_ON);
>> +
>> +     u2o_clear(base, UTMI_CTRL, UTMI_CTRL_RXBUF_PDWN);
>> +     u2o_clear(base, UTMI_CTRL, UTMI_CTRL_TXBUF_PDWN);
>> +     u2o_clear(base, UTMI_CTRL, UTMI_CTRL_USB_CLK_EN);
>> +     u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
>> +     u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
>
> NAK, this is stupid, read once, clear bits you want to clear and write
> only once.
>

I will check with silicon design engineer. becuase all the phy init
code is delivered by them.
I can not tell that if there are any speciall reason they will do so
because the device register
read/write is not same as normal memory.

>> +     return 0;
>> +}
>> +
>> +static int mv_usb2_phy_init(struct usb_phy *phy)
>> +{
>> +     struct mv_usb2_phy *mv_phy = container_of(phy, struct mv_usb2_phy, phy);
>> +     int i = 0;
>> +
>> +     mutex_lock(&mv_phy->phy_lock);
>
> what's this mutex for ?
>
>> +     if (mv_phy->refcount++ == 0) {
>
> can this device really be used simultaneously by multiple devices ?
>

Sure, we have another EHCI device, it will share the PHY with this USB
controller.
So we will use refcount and mutext to protect the phy init.

>> +     for (i = 0; i < mv_phy->clks_num; i++) {
>> +             mv_phy->clks[i] = devm_clk_get(&pdev->dev,
>> +                                             pdata->clkname[i]);
>
> *NEVER* pass clock names via platform_data, this is utterly wrong.
>
without device tree support, the only way we can get the clock is the pdata.
the use phy have mutiple clocks.
So what do you suggest to handle it?

>> +             if (IS_ERR(mv_phy->clks[i])) {
>> +                     dev_err(&pdev->dev, "failed to get clock %s\n",
>> +                             pdata->clkname[i]);
>> +                     return PTR_ERR(mv_phy->clks[i]);
>> +             }
>> +     }
>> +     r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (r == NULL) {
>> +             dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
>> +             return -ENODEV;
>> +     }
>> +     mv_phy->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>
> use devm_ioremap_resource() instead.
>
fine.

>> +static struct platform_driver mv_usb2_phy_driver = {
>> +     .probe  = mv_usb2_phy_probe,
>> +     .remove = mv_usb2_phy_remove,
>> +     .driver = {
>> +             .name   = "pxa168-usb-phy",
>> +     },
>> +     .id_table = mv_usb2_phy_ids,
>> +};
>> +
>> +static int __init mv_usb2_phy_driver_init(void)
>> +{
>> +     return platform_driver_register(&mv_usb2_phy_driver);
>> +}
>> +arch_initcall(mv_usb2_phy_driver_init);
>
> NAK, use module_platform_driver() like everybody else and handle
> registration ordering with -EPROBE_DEFER.
>

The reason i do not use module_platform_driver is the compiling
sequence of each directory of driver/usb/
the phy is compiled after otg/ehci. So it means that it can not find
the usb phy, and will register fail.


>> diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
>> index 944b01d..fd3d1b4 100644
>> --- a/include/linux/platform_data/mv_usb.h
>> +++ b/include/linux/platform_data/mv_usb.h
>> @@ -47,9 +47,12 @@ struct mv_usb_platform_data {
>>       /* Force a_bus_req to be asserted */
>>        unsigned int    otg_force_a_bus_req:1;
>>
>> -     int     (*phy_init)(void __iomem *regbase);
>> -     void    (*phy_deinit)(void __iomem *regbase);
>>       int     (*set_vbus)(unsigned int vbus);
>> -     int     (*private_init)(void __iomem *opregs, void __iomem *phyregs);
>
> should be part of a separate patch.
>
>>  };
>> +
>> +struct mv_usb_phy_platform_data {
>> +     unsigned int    clknum;
>> +     char            **clkname;
>> +};
>
> NAK for this platform_data.
>

> --
> balbi
