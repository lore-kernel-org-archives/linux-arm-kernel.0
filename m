From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 18 Feb 2013 14:58:29 +0800
Subject: [V7 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <5121CD94.4060109@ti.com>
References: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
 <1361167838-22929-2-git-send-email-chao.xie@marvell.com>
 <5121CD94.4060109@ti.com>
Message-ID: <CADApbei9u2LLSgA7E0vwRZ-iKAh7usqETzrsMSqdT5+6WZ3y+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 2:43 PM, kishon <kishon@ti.com> wrote:
> Hi,
>
>
> On Monday 18 February 2013 11:40 AM, Chao Xie wrote:
>>
>> The PHY is seperated from usb controller.
>> The usb controller used in marvell pxa168/pxa910/mmp2 are same,
>> ...
>> +
>> +#define UTMI_OTG_ADDON_OTG_ON                  (1 << 0)
>> +
>> +enum mv_usb2_phy_type {
>> +       PXA168_USB,
>> +       PXA910_USB,
>> +       MMP2_USB,
>> +};
>
>
> Is this enum being used somewhere?
>
Yes, the PHY setting has a little difference between these SOCes.
I have to use these types to track which SOC is used.
>
>> +
>> +static unsigned int u2o_get(void __iomem *base, unsigned int offset)
>> +{
>> +       return readl(base + offset);
>> +}
>> +
>> +static void u2o_set(void __iomem *base, unsigned int offset,
>> +               unsigned int value)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(base + offset);
>> +       reg |= value;
>> +       writel(reg, base + offset);
>> +       readl(base + offset);
>
>
> spurious readl.
>
Writing to the PHY setting registers has to make sure that every
writing has been issued already.
The design engineer suggest us to add reading after the writing. It
can make sure the writing has
taken effect.

>> +}
>> +
>> +static void u2o_clear(void __iomem *base, unsigned int offset,
>> +               unsigned int value)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(base + offset);
>> +       reg &= ~value;
>> +       writel(reg, base + offset);
>> +       readl(base + offset);
>
>
> ditto..
>
Same reason. The clear is a writing operation
>> +}
>> +
>> +static void u2o_write(void __iomem *base, unsigned int offset,
>> +               unsigned int value)
>> +{
>> +       writel(value, base + offset);
>> +       readl(base + offset);
>
>
> ditto..
>
Same reason.
>> +}
>> +
>> +static int _mv_usb2_phy_init(struct mv_usb2_phy *mv_phy)
>> +{
>> +       struct platform_device *pdev = mv_phy->pdev;
>> +       unsigned int loops = 0;
>> +       void __iomem *base = mv_phy->base;
>> +
>> +       dev_dbg(&pdev->dev, "phy init\n");
>> +
>> +       /* Initialize the USB PHY power */
>> +       if (mv_phy->type == PXA910_USB) {
>> +               u2o_set(base, UTMI_CTRL,
>> (1<<UTMI_CTRL_INPKT_DELAY_SOF_SHIFT)
>> +                       | (1<<UTMI_CTRL_PU_REF_SHIFT));
>> +       }
>> +

>> 4<<UTMI_TX_IMPCAL_VTH_SHIFT
>> +               | 8<<UTMI_TX_REG_EXT_FS_RCAL_SHIFT |
>> 3<<UTMI_TX_AMP_SHIFT);
>> +
>> phy);
>> +       int i = 0;
>> +
>> +       mutex_lock(&mv_phy->phy_lock);
>> +       if (mv_phy->refcount++ == 0) {
>
>
> shouldn't this be --mv_phy->refcount == 0?
>
you are right.

>
>> +               _mv_usb2_phy_shutdown(mv_phy);
>> +               for (i = 0; i < mv_phy->clks_num; i++)
>> +                       clk_disable_unprepare(mv_phy->clks[i]);
>> +       }
>> +       usb_add_phy_dev(&mv_phy->phy);
>> +
>> +       platform_set_drvdata(pdev, mv_phy);
>> +
>> +       dev_info(&pdev->dev, "mv usb2 phy initialized\n");
>
>
> dev_info makes the boot log noisy.
>
It is the only print in boot log for usb phy.
I can change it to be dev_dbg.

>> +
>> +       return 0;
>> +}
>> +
>> +static int mv_usb2_phy_remove(struct platform_device *pdev)
>> +{
>> +       struct mv_usb2_phy *mv_phy = platform_get_drvdata(pdev);
>> +
>> +struct mv_usb_phy_platform_data {
>> +       unsigned int    clknum;
>> +       char            **clkname;
>> +};
>> +
>>   #endif
>> diff --git a/include/linux/usb/mv_usb2.h b/include/linux/usb/mv_usb2.h
>> new file mode 100644
>> index 0000000..19a1d67
>> --- /dev/null
>> +++ b/include/linux/usb/mv_usb2.h
>> @@ -0,0 +1,40 @@
>> +/*
>> + * Copyright (C) 2012 Marvell Inc.
>
>
> why is this different from drivers/usb/phy/mv_usb2_phy.c?
>
The license has some misaligned. I will modify it.

>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef __MV_USB2_H
>> +#define __MV_USB2_H
>> +
>> +#define MV_USB2_PHY_INDEX      0
>> +#define MV_USB2_OTG_PHY_INDEX  1
>> +
>> +struct mv_usb2_phy {
>> +       struct usb_phy          phy;
>> +       struct platform_device  *pdev;
>> +       struct mutex            phy_lock;
>> +       unsigned int            refcount;
>> +       unsigned int            type;
>> +       void __iomem            *base;
>> +       struct clk              **clks;
>> +       unsigned int            clks_num;
>> +};
>> +
>> +#if defined(CONFIG_MV_USB2_PHY) || defined(CONFIG_MV_USB2_PHY_MODULE)
>> +
>> +
>> +#else
>> +
>> +
>> +#endif
>
> This should be removed.
>
You are right.

> Thanks
> Kishon
