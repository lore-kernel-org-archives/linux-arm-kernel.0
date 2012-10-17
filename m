From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 17 Oct 2012 18:00:37 +0530
Subject: [PATCH] usb: phy: samsung: Introducing usb phy driver for hsotg
In-Reply-To: <005801cdac56$8da0c120$a8e24360$%kim@samsung.com>
References: <1349256393-11741-1-git-send-email-p.paneri@samsung.com>
 <1350036934-6051-1-git-send-email-p.paneri@samsung.com>
 <005801cdac56$8da0c120$a8e24360$%kim@samsung.com>
Message-ID: <CAD6zSYPSSZwtfRO_TkP06uL6Ma-dVNbZrw=9suYOcx295GY0-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 17, 2012 at 4:30 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Praveen Paneri wrote:
>>
>> platform_set_drvdata() required for driver's remove function, so adding
>> it back.
>>
>> From v6:
>> Added TODO for phy bindings with controller
>> Dropped platform_set_drvdata() from driver probe
>>
>> This driver uses usb_phy interface to interact with s3c-hsotg. Supports
>> phy_init and phy_shutdown functions to enable/disable phy. Tested with
>> smdk6410 and smdkv310. More SoCs can be brought under later.
>>
>> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  .../devicetree/bindings/usb/samsung-usbphy.txt     |   11 +
>>  drivers/usb/phy/Kconfig                            |    8 +
>>  drivers/usb/phy/Makefile                           |    1 +
>>  drivers/usb/phy/samsung-usbphy.c                   |  357
> ++++++++++++++++++++
>>  include/linux/platform_data/samsung-usbphy.h       |   27 ++
>>  5 files changed, 404 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung-
>> usbphy.txt
>>  create mode 100644 drivers/usb/phy/samsung-usbphy.c
>>  create mode 100644 include/linux/platform_data/samsung-usbphy.h
>>
>> diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> new file mode 100644
>> index 0000000..7b26e2d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> @@ -0,0 +1,11 @@
>> +* Samsung's usb phy transceiver
>> +
>> +The Samsung's phy transceiver is used for controlling usb otg phy for
>> +s3c-hsotg usb device controller.
>> +TODO: Adding the PHY binding with controller(s) according to the under
>> +developement generic PHY driver.
>> +
>> +Required properties:
>> +- compatible : should be "samsung,exynos4210-usbphy"
>> +- reg : base physical address of the phy registers and length of memory
>> mapped
>> +     region.
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index 63c339b..313685f 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -32,3 +32,11 @@ config MV_U3D_PHY
>>       help
>>         Enable this to support Marvell USB 3.0 phy controller for Marvell
>>         SoC.
>> +
>> +config SAMSUNG_USBPHY
>> +     bool "Samsung USB PHY controller Driver"
>> +     depends on USB_S3C_HSOTG
>> +     select USB_OTG_UTILS
>> +     help
>> +       Enable this to support Samsung USB phy controller for samsung
>> +       SoCs.
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index b069f29..55dcfc1 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_OMAP_USB2)                       +=
> omap-usb2.o
>>  obj-$(CONFIG_USB_ISP1301)            += isp1301.o
>>  obj-$(CONFIG_MV_U3D_PHY)             += mv_u3d_phy.o
>>  obj-$(CONFIG_USB_EHCI_TEGRA) += tegra_usb_phy.o
>> +obj-$(CONFIG_SAMSUNG_USBPHY)         += samsung-usbphy.o
>> diff --git a/drivers/usb/phy/samsung-usbphy.c b/drivers/usb/phy/samsung-
>> usbphy.c
>> new file mode 100644
>> index 0000000..14c182f
>> --- /dev/null
>> +++ b/drivers/usb/phy/samsung-usbphy.c
>
> Hi,
>
> Basically I agree and this is a good approach to support usb phy for Samsung
> stuff...but there are some comments ;)
>
>> @@ -0,0 +1,357 @@
>> +/* linux/drivers/usb/phy/samsung-usbphy.c
>> + *
>> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>> + *              http://www.samsung.com
>> + *
>> + * Author: Praveen Paneri <p.paneri@samsung.com>
>> + *
>> + * Samsung USB2.0 High-speed OTG transceiver, talks to S3C HS OTG
>> controller
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/usb/otg.h>
>> +#include <linux/platform_data/samsung-usbphy.h>
>> +
>> +/* Register definitions */
>> +
>> +#define S3C_PHYPWR                           (0x00)
>> +
> IMHO, according to the file name, samsung-usbphy, SAMSUNG_ is better here?
Sure I will change this for register names and drop S3C_ from bit definitions.
>
>
>> +#define S3C_PHYPWR_NORMAL_MASK                       (0x19 << 0)
>> +#define S3C_PHYPWR_OTG_DISABLE                       (1 << 4)
>> +#define S3C_PHYPWR_ANALOG_POWERDOWN          (1 << 3)
>> +#define S3C_PHYPWR_FORCE_SUSPEND             (1 << 1)
>> +/* For Exynos4 */
>> +#define EXYNOS4_PHYPWR_NORMAL_MASK           (0x39 << 0)
>
> Hmm...is this right? If so, need to use exact name for the definition.
Name should be changed, will do that.
>
> See arch/arm/mach-exynos/include/mach/regs-usb-phy.h
>
>> +#define EXYNOS4_PHYPWR_SLEEP                 (1 << 5)
>
> Ditto.
>
>> +
>> +#define S3C_PHYCLK                           (0x04)
>> +
>> +#define S3C_PHYCLK_MODE_SERIAL                       (1 << 6)
>
> MODE_USB11?
Yes! Will update this as well.
>
>> +#define S3C_PHYCLK_EXT_OSC                   (1 << 5)
>> +#define S3C_PHYCLK_COMMON_ON_N                       (1 << 4)
>
> There are Samsung SoCs which is having two PHYs, so I think, we need to
> design this with considering it.
Yes! I do plan to add support for other SoCs. We will have to update
the register definition accordingly for PHY0 and PHY1.
>
>> +#define S3C_PHYCLK_ID_PULL                   (1 << 2)
>> +#define S3C_PHYCLK_CLKSEL_MASK                       (0x3 << 0)
>> +#define S3C_PHYCLK_CLKSEL_SHIFT                      (0)
>> +#define S3C_PHYCLK_CLKSEL_48M                        (0x0 << 0)
>> +#define S3C_PHYCLK_CLKSEL_12M                        (0x2 << 0)
>> +#define S3C_PHYCLK_CLKSEL_24M                        (0x3 << 0)
>
> As you know, the values for CLKSEL are different on each Samsung SoCs...if
Yeah those bit definitions have to be added here, just as they are in
the file you mentioned.
See arch/arm/mach-exynos/include/mach/regs-usb-phy.h
> we use this patch, we need to implement for other SoCs many things. In
> addition, this patch says can support EXYNOS4210 but not actually...
I have tested on SMDKV310 and SMDK6410 with s3c-hsotg. So, host phy
control support is yet to be added.

>
>> +
>> +#define S3C_RSTCON                           (0x08)
>> +
>> +#define S3C_RSTCON_PHYCLK                    (1 << 2)
>> +#define S3C_RSTCON_HCLK                              (1 << 1)
>> +#define S3C_RSTCON_PHY                               (1 << 0)
>> +
>> +#ifndef MHZ
>> +#define MHZ (1000*1000)
>> +#endif
>> +
>> +enum samsung_cpu_type {
>> +     TYPE_S3C64XX,
>> +     TYPE_EXYNOS4210,
>> +};
>> +
>> +/*
>> + * struct samsung_usbphy - transceiver driver state
>> + * @phy: transceiver structure
>> + * @plat: platform data
>> + * @dev: The parent device supplied to the probe function
>> + * @clk: usb phy clock
>> + * @regs: usb phy register memory base
>> + * @ref_clk_freq: reference clock frequency selection
>> + * @cpu_type: machine identifier
>> + */
>> +struct samsung_usbphy {
>> +     struct usb_phy  phy;
>> +     struct samsung_usbphy_data *plat;
>> +     struct device   *dev;
>> +     struct clk      *clk;
>> +     void __iomem    *regs;
>> +     int             ref_clk_freq;
>> +     int             cpu_type;
>> +};
>> +
>> +#define phy_to_sphy(x)               container_of((x), struct
> samsung_usbphy,
>> phy)
>> +
>> +/*
>> + * Returns reference clock frequency selection value
>> + */
>> +static int samsung_usbphy_get_refclk_freq(struct samsung_usbphy *sphy)
>> +{
>> +     struct clk *ref_clk;
>> +     int refclk_freq = 0;
>> +
>> +     ref_clk = clk_get(sphy->dev, "xusbxti");
>> +     if (IS_ERR(ref_clk)) {
>
> IS_ERR_OR_NULL(ref_clk)?
sure
>
>> +             dev_err(sphy->dev, "Failed to get reference clock\n");
>> +             return PTR_ERR(ref_clk);
>> +     }
>> +
>> +     switch (clk_get_rate(ref_clk)) {
>> +     case 12 * MHZ:
>> +             refclk_freq |= S3C_PHYCLK_CLKSEL_12M;
>
> Just,
>
> +               refclk_freq = S3C_PHYCLK_CLKSEL_12M;
>
> because its defalut value is 0...BTW, how do you think to support other SoCs
> such as EXYNOS4210, EXYNOS4X12?
Will make use of sphy->cpu_type here. No?
>
>> +             break;
>> +     case 24 * MHZ:
>> +             refclk_freq |= S3C_PHYCLK_CLKSEL_24M;
>
> Ditto.
>
>> +             break;
>> +     default:
>> +     case 48 * MHZ:
>> +             /* default reference clock */
>> +             refclk_freq |= S3C_PHYCLK_CLKSEL_48M;
>
> Ditto...and default refernec clock for EXYNOS4 is 24MHz...
Okay! So it needs an if statement here then.
>
>> +             break;
>> +     }
>> +     clk_put(ref_clk);
>> +
>> +     return refclk_freq;
>> +}
>> +
>
> Hmm...I need more time to look at this again...
Thank you :)
In that case, I will wait for further comments from you and then only
send my subsequent patches.

Regards,
Praveen
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
