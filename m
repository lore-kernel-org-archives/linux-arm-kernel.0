From: p.paneri@samsung.com (Praveen Paneri)
Date: Mon, 6 Aug 2012 15:21:18 +0530
Subject: [PATCH 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <201208061123.18065.heiko@sntech.de>
References: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
 <CAD6zSYMkrPLuV+8ev4pz8M7qW8pFo2Q12jmW-pHqvdVREuW=Tw@mail.gmail.com>
 <CAH9JG2Wo83_rO6fEazWij9wo=w7atdCqeuqJUmCPJYeYQ4t5dw@mail.gmail.com>
 <201208061123.18065.heiko@sntech.de>
Message-ID: <CAD6zSYPyRGgxVXFhcLSqjOpERq-jLrsqnjYNXM3jKsjymiLaTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 6, 2012 at 2:53 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Montag, 6. August 2012, 10:23:52 schrieb Kyungmin Park:
>> Hi Praveen,
>>
>> On 8/6/12, Praveen Paneri <p.paneri@samsung.com> wrote:
>> > Hi Heiko,
>> >
>> > On Mon, Aug 6, 2012 at 3:24 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> >> Hi Praveen,
>> >>
>> >> Am Mittwoch, 1. August 2012, 15:05:47 schrieb Praveen Paneri:
>> >>> This driver uses usb_phy interface to interact with s3c-hsotg. Supports
>> >>> phy_init and phy_shutdown functions to enable/disable phy. Tested with
>> >>> smdk6410 and smdkv310. More SoCs can be brought under later.
>> >>
>> >> Looks cool.
>> >
>> > Thanks
>> >
>> >> From what I've seen the phy controllers on newer Samsung SoCs are still
>> >> somewhat similar to the one on my s3c2416/2450 machines. So hopefully at
>> >> some
>> >> point after the driver has settled, I'll find the time to add support
>> >> for these to the phy driver.
>> >
>> > Yes! that's great.
>> >
>> >> Out of curiosity, what does the "sec" in sec_usbphy for?
>> >
>> > Its Samsung Electronics Co. :)
>>
>> I'm also prefer to use 'samsung' or 'exynos'. Since I didn't see the
>> 'sec' prefix for samsung drivers.
>
> I'd second that. All new generic samsung drivers look like this (i.e. gpio-
> samsung, pwm-samsung).
>
> Just checked the datasheets again. This general phy type is used in some form
> down to the S3C2443, so I'd prefer something with samsung in the name :-)
Yes! That makes sense. I will change the name to samsung_usbphy

Praveen
>
>
> Heiko
>
>>
>> Thank you,
>> Kyungmin Park
>>
>> > Praveen
>> >
>> >>> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
>> >>
>> >> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> >>
>> >>
>> >> Heiko
>> >>
>> >>> ---
>> >>>
>> >>>  .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>> >>>  drivers/usb/phy/Kconfig                            |    8 +
>> >>>  drivers/usb/phy/Makefile                           |    1 +
>> >>>  drivers/usb/phy/sec_usbphy.c                       |  354
>> >>>
>> >>> ++++++++++++++++++++ drivers/usb/phy/sec_usbphy.h
>> >>>
>> >>>  48 +++
>> >>>  include/linux/platform_data/s3c-hsotg.h            |    5 +
>> >>>  6 files changed, 425 insertions(+), 0 deletions(-)
>> >>>  create mode 100644
>> >>>
>> >>> Documentation/devicetree/bindings/usb/samsung-usbphy.txt create mode
>> >>> 100644 drivers/usb/phy/sec_usbphy.c
>> >>>
>> >>>  create mode 100644 drivers/usb/phy/sec_usbphy.h
>> >>>
>> >>> diff --git a/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> >>> b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt new file
>> >>> mode 100644
>> >>> index 0000000..fefd9c8
>> >>> --- /dev/null
>> >>> +++ b/Documentation/devicetree/bindings/usb/samsung-usbphy.txt
>> >>> @@ -0,0 +1,9 @@
>> >>> +* Samsung's usb phy transceiver
>> >>> +
>> >>> +The Samsung's phy transceiver is used for controlling usb otg phy for
>> >>> +s3c-hsotg usb device controller.
>> >>> +
>> >>> +Required properties:
>> >>> +- compatible : should be "samsung,exynos4210-usbphy"
>> >>> +- reg : base physical address of the phy registers and length of
>> >>> memory mapped +      region.
>> >>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> >>> index e7cf84f..abbebe2 100644
>> >>> --- a/drivers/usb/phy/Kconfig
>> >>> +++ b/drivers/usb/phy/Kconfig
>> >>> @@ -15,3 +15,11 @@ config USB_ISP1301
>> >>>
>> >>>         To compile this driver as a module, choose M here: the
>> >>>         module will be called isp1301.
>> >>>
>> >>> +
>> >>> +config SEC_USBPHY
>> >>> +       bool "Samsung USB PHY controller Driver"
>> >>> +       depends on USB_S3C_HSOTG
>> >>> +       select USB_OTG_UTILS
>> >>> +       help
>> >>> +         Enable this to support Samsung USB phy controller for samsung
>> >>> +         SoCs.
>> >>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> >>> index eca095b..6bb66f0 100644
>> >>> --- a/drivers/usb/phy/Makefile
>> >>> +++ b/drivers/usb/phy/Makefile
>> >>> @@ -5,3 +5,4 @@
>> >>>
>> >>>  ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
>> >>>
>> >>>  obj-$(CONFIG_USB_ISP1301)            += isp1301.o
>> >>>
>> >>> +obj-$(CONFIG_SEC_USBPHY)             += sec_usbphy.o
>> >>> diff --git a/drivers/usb/phy/sec_usbphy.c
>> >>> b/drivers/usb/phy/sec_usbphy.c new file mode 100644
>> >>> index 0000000..33119eb
>> >>> --- /dev/null
>> >>> +++ b/drivers/usb/phy/sec_usbphy.c
>> >>> @@ -0,0 +1,354 @@
>> >>> +/* linux/drivers/usb/phy/sec_usbphy.c
>> >>> + *
>> >>> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>> >>> + *              http://www.samsung.com
>> >>> + *
>> >>> + * Author: Praveen Paneri <p.paneri@samsung.com>
>> >>> + *
>> >>> + * Samsung USB2.0 High-speed OTG transceiver, talks to S3C HS OTG
>> >>> controller + *
>> >>> + * This program is free software; you can redistribute it and/or
>> >>> modify + * it under the terms of the GNU General Public License
>> >>> version 2 as + * published by the Free Software Foundation.
>> >>> + *
>> >>> + * This program is distributed in the hope that it will be useful,
>> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >>> + * GNU General Public License for more details.
>> >>> + *
>> >>> + * You should have received a copy of the GNU General Public License
>> >>> + * along with this program; if not, write to the Free Software
>> >>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> >>> +*/
>> >>> +
>> >>> +#include <linux/module.h>
>> >>> +#include <linux/platform_device.h>
>> >>> +#include <linux/clk.h>
>> >>> +#include <linux/delay.h>
>> >>> +#include <linux/err.h>
>> >>> +#include <linux/io.h>
>> >>> +#include <linux/of.h>
>> >>> +#include <linux/usb/otg.h>
>> >>> +#include <linux/platform_data/s3c-hsotg.h>
>> >>> +
>> >>> +#include "sec_usbphy.h"
>> >>> +
>> >>> +enum sec_cpu_type {
>> >>> +     TYPE_S3C64XX,
>> >>> +     TYPE_EXYNOS4210,
>> >>> +};
>> >>> +
>> >>> +/*
>> >>> + * struct sec_usbphy - transceiver driver state
>> >>> + * @phy: transceiver structure
>> >>> + * @plat: platform data
>> >>> + * @dev: The parent device supplied to the probe function
>> >>> + * @clk: usb phy clock
>> >>> + * @regs: usb phy register memory base
>> >>> + * @cpu_type: machine identifier
>> >>> + */
>> >>> +struct sec_usbphy {
>> >>> +     struct usb_phy  phy;
>> >>> +     struct s3c_usbphy_plat *plat;
>> >>> +     struct device   *dev;
>> >>> +     struct clk      *clk;
>> >>> +     void __iomem    *regs;
>> >>> +     int             cpu_type;
>> >>> +};
>> >>> +
>> >>> +#define phy_to_sec(x)                container_of((x), struct
>> >>> sec_usbphy, phy)
>> >>> +
>> >>> +/*
>> >>> + * Enables or disables the phy clock
>> >>> + * returns 0 on success else the error
>> >>> + */
>> >>> +static int sec_usbphy_clk_control(struct sec_usbphy *sec, bool on)
>> >>> +{
>> >>> +     if (on) {
>> >>> +             if (!sec->clk) {
>> >>> +                     sec->clk = clk_get(sec->dev, "otg");
>> >>> +                     if (IS_ERR(sec->clk)) {
>> >>> +                             dev_err(sec->dev, "Failed to get otg
>> >>> clock\n");
>> >>> +                             return PTR_ERR(sec->clk);
>> >>> +                     }
>> >>> +             }
>> >>> +             clk_enable(sec->clk);
>> >>> +     } else {
>> >>> +             clk_disable(sec->clk);
>> >>> +             clk_put(sec->clk);
>> >>> +     }
>> >>> +
>> >>> +     return 0;
>> >>> +}
>> >>> +
>> >>> +/*
>> >>> + * Returns reference clock frequency
>> >>> + */
>> >>> +static int sec_usbphy_get_refclk_freq(struct sec_usbphy *sec)
>> >>> +{
>> >>> +     struct clk *ref_clk;
>> >>> +     int refclk_freq = 0;
>> >>> +
>> >>> +     ref_clk = clk_get(sec->dev, "xusbxti");
>> >>> +     if (IS_ERR(ref_clk)) {
>> >>> +             dev_err(sec->dev, "Failed to get reference clock\n");
>> >>> +             return PTR_ERR(ref_clk);
>> >>> +     }
>> >>> +
>> >>> +     switch (clk_get_rate(ref_clk)) {
>> >>> +     case 12 * MHZ:
>> >>> +             refclk_freq |= S3C_PHYCLK_CLKSEL_12M;
>> >>> +             break;
>> >>> +     case 24 * MHZ:
>> >>> +             refclk_freq |= S3C_PHYCLK_CLKSEL_24M;
>> >>> +             break;
>> >>> +     default:
>> >>> +     case 48 * MHZ:
>> >>> +             /* default reference clock */
>> >>> +             refclk_freq |= S3C_PHYCLK_CLKSEL_48M;
>> >>> +             break;
>> >>> +     }
>> >>> +     clk_put(ref_clk);
>> >>> +
>> >>> +     return refclk_freq;
>> >>> +}
>> >>> +
>> >>> +static void sec_usbphy_enable(struct sec_usbphy *sec)
>> >>> +{
>> >>> +     void __iomem *regs = sec->regs;
>> >>> +     u32 phypwr;
>> >>> +     u32 phyclk;
>> >>> +     u32 rstcon;
>> >>> +
>> >>> +     /* set clock frequency for PLL */
>> >>> +     phyclk = sec_usbphy_get_refclk_freq(sec);
>> >>> +     phypwr = readl(regs + S3C_PHYPWR);
>> >>> +     rstcon = readl(regs + S3C_RSTCON);
>> >>> +
>> >>> +     switch (sec->cpu_type) {
>> >>> +     case TYPE_S3C64XX:
>> >>> +             phyclk &= ~(S3C_PHYCLK_COMMON_ON_N);
>> >>> +             phypwr &= ~S3C_PHYPWR_NORMAL_MASK;
>> >>> +             rstcon |= S3C_RSTCON_PHY;
>> >>> +             break;
>> >>> +     case TYPE_EXYNOS4210:
>> >>> +             phypwr &= ~EXYNOS4_PHYPWR_NORMAL_MASK;
>> >>> +             rstcon |= S3C_RSTCON_PHY;
>> >>> +     default:
>> >>> +             break;
>> >>> +     }
>> >>> +
>> >>> +     writel(phyclk, regs + S3C_PHYCLK);
>> >>> +     /* set to normal of PHY0 */
>> >>> +     writel(phypwr, regs + S3C_PHYPWR);
>> >>> +     /* reset all ports of PHY and Link */
>> >>> +     writel(rstcon, regs + S3C_RSTCON);
>> >>> +     udelay(10);
>> >>> +     rstcon &= ~S3C_RSTCON_PHY;
>> >>> +     writel(rstcon, regs + S3C_RSTCON);
>> >>> +}
>> >>> +
>> >>> +static void sec_usbphy_disable(struct sec_usbphy *sec)
>> >>> +{
>> >>> +     void __iomem *regs = sec->regs;
>> >>> +     u32 phypwr;
>> >>> +
>> >>> +     phypwr = readl(regs + S3C_PHYPWR);
>> >>> +
>> >>> +     switch (sec->cpu_type) {
>> >>> +     case TYPE_S3C64XX:
>> >>> +             phypwr |= S3C_PHYPWR_NORMAL_MASK;
>> >>> +             break;
>> >>> +     case TYPE_EXYNOS4210:
>> >>> +             phypwr |= EXYNOS4_PHYPWR_NORMAL_MASK;
>> >>> +     default:
>> >>> +             break;
>> >>> +     }
>> >>> +
>> >>> +     /* unset to normal of PHY0 */
>> >>> +     writel(phypwr, regs + S3C_PHYPWR);
>> >>> +}
>> >>> +
>> >>> +/*
>> >>> + * The function passed to the usb driver for phy initialization
>> >>> + */
>> >>> +static int sec_usbphy_init(struct usb_phy *phy)
>> >>> +{
>> >>> +     struct sec_usbphy *sec;
>> >>> +     int ret = 0;
>> >>> +
>> >>> +     sec = phy_to_sec(phy);
>> >>> +
>> >>> +     /* Enable the phy clock */
>> >>> +     ret = sec_usbphy_clk_control(sec, true);
>> >>> +     if (ret) {
>> >>> +             dev_err(sec->dev, "phy clock enable failed\n");
>> >>> +             return ret;
>> >>> +     }
>> >>> +
>> >>> +     /* Disable phy isolation */
>> >>> +     if (sec->plat && sec->plat->pmu_isolation)
>> >>> +             sec->plat->pmu_isolation(false);
>> >>> +
>> >>> +     /* Initialize usb phy registers */
>> >>> +     sec_usbphy_enable(sec);
>> >>> +     return ret;
>> >>> +}
>> >>> +
>> >>> +/*
>> >>> + * The function passed to the usb driver for phy shutdown
>> >>> + */
>> >>> +static void sec_usbphy_shutdown(struct usb_phy *phy)
>> >>> +{
>> >>> +     struct sec_usbphy *sec;
>> >>> +
>> >>> +     sec = phy_to_sec(phy);
>> >>> +
>> >>> +     /* De-initialize usb phy registers */
>> >>> +     sec_usbphy_disable(sec);
>> >>> +
>> >>> +     /* Enable phy isolation */
>> >>> +     if (sec->plat && sec->plat->pmu_isolation)
>> >>> +             sec->plat->pmu_isolation(true);
>> >>> +
>> >>> +     /* Disable the phy clock */
>> >>> +     sec_usbphy_clk_control(sec, false);
>> >>> +}
>> >>> +
>> >>> +static const struct of_device_id sec_usbphy_dt_match[];
>> >>> +
>> >>> +static inline int sec_usbphy_get_driver_data(struct platform_device
>> >>> *pdev)
>> >>> +{
>> >>> +#ifdef CONFIG_OF
>> >>> +     int data;
>> >>> +     if (pdev->dev.of_node) {
>> >>> +             const struct of_device_id *match;
>> >>> +             match = of_match_node(sec_usbphy_dt_match,
>> >>> pdev->dev.of_node);
>> >>> +             data = (int) match->data;
>> >>> +             return data;
>> >>> +     }
>> >>> +#endif
>> >>> +     return platform_get_device_id(pdev)->driver_data;
>> >>> +}
>> >>> +
>> >>> +static int __devinit sec_usbphy_probe(struct platform_device *pdev)
>> >>> +{
>> >>> +     struct sec_usbphy *sec;
>> >>> +     struct s3c_usbphy_plat *pdata;
>> >>> +     struct device *dev = &pdev->dev;
>> >>> +     struct resource *phy_mem;
>> >>> +     void __iomem    *phy_base;
>> >>> +     int     ret;
>> >>> +
>> >>> +     pdata = pdev->dev.platform_data;
>> >>> +     if (!pdata) {
>> >>> +             dev_err(&pdev->dev, "%s: no platform data defined\n",
>> >>> __func__);
>> >>> +             return -EINVAL;
>> >>> +     }
>> >>> +
>> >>> +     phy_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >>> +     if (!phy_mem) {
>> >>> +             dev_err(dev, "%s: missing mem resource\n", __func__);
>> >>> +             return -ENODEV;
>> >>> +     }
>> >>> +
>> >>> +     phy_base = devm_request_and_ioremap(dev, phy_mem);
>> >>> +     if (!phy_base) {
>> >>> +             dev_err(dev, "%s: register mapping failed\n", __func__);
>> >>> +             return -ENXIO;
>> >>> +     }
>> >>> +
>> >>> +     sec = devm_kzalloc(dev, sizeof(*sec), GFP_KERNEL);
>> >>> +     if (!sec)
>> >>> +             return -ENOMEM;
>> >>> +
>> >>> +     sec->dev                = &pdev->dev;
>> >>> +     sec->plat               = pdata;
>> >>> +     sec->regs               = phy_base;
>> >>> +     sec->phy.dev            = sec->dev;
>> >>> +     sec->phy.label          = "sec-usbphy";
>> >>> +     sec->phy.init           = sec_usbphy_init;
>> >>> +     sec->phy.shutdown       = sec_usbphy_shutdown;
>> >>> +     sec->cpu_type           = sec_usbphy_get_driver_data(pdev);
>> >>> +
>> >>> +     ret = usb_add_phy(&sec->phy, USB_PHY_TYPE_USB2);
>> >>> +     if (ret)
>> >>> +             goto err;
>> >>> +
>> >>> +     platform_set_drvdata(pdev, sec);
>> >>> +
>> >>> +     dev_info(&pdev->dev, "Initialized samsung USB OTG PHY module\n");
>> >>> +err:
>> >>> +     return ret;
>> >>> +}
>> >>> +
>> >>> +static int __exit sec_usbphy_remove(struct platform_device *pdev)
>> >>> +{
>> >>> +     struct sec_usbphy *sec = platform_get_drvdata(pdev);
>> >>> +
>> >>> +     usb_remove_phy(&sec->phy);
>> >>> +
>> >>> +     if (sec->clk) {
>> >>> +             clk_put(sec->clk);
>> >>> +             sec->clk = NULL;
>> >>> +     }
>> >>> +
>> >>> +     return 0;
>> >>> +}
>> >>> +
>> >>> +#ifdef CONFIG_OF
>> >>> +static const struct of_device_id sec_usbphy_dt_match[] = {
>> >>> +     {
>> >>> +             .compatible = "samsung,s3c64xx-usbphy",
>> >>> +             .data = (void *)TYPE_S3C64XX,
>> >>> +     }, {
>> >>> +             .compatible = "samsung,exynos4210-usbphy",
>> >>> +             .data = (void *)TYPE_EXYNOS4210,
>> >>> +     },
>> >>> +     {},
>> >>> +};
>> >>> +MODULE_DEVICE_TABLE(of, sec_usbphy_dt_match);
>> >>> +#else
>> >>> +#define sec_usbphy_dt_match NULL
>> >>> +#endif
>> >>> +
>> >>> +static struct platform_device_id sec_usbphy_driver_ids[] = {
>> >>> +     {
>> >>> +             .name           = "s3c64xx-usbphy",
>> >>> +             .driver_data    = TYPE_S3C64XX,
>> >>> +     }, {
>> >>> +             .name           = "exynos4210-usbphy",
>> >>> +             .driver_data    = TYPE_EXYNOS4210,
>> >>> +     },
>> >>> +     {},
>> >>> +};
>> >>> +
>> >>> +MODULE_DEVICE_TABLE(platform, sec_usbphy_driver_ids);
>> >>> +
>> >>> +static struct platform_driver sec_usbphy_driver = {
>> >>> +     .probe          = sec_usbphy_probe,
>> >>> +     .remove         = __devexit_p(sec_usbphy_remove),
>> >>> +     .id_table       = sec_usbphy_driver_ids,
>> >>> +     .driver         = {
>> >>> +             .name   = "sec-usbphy",
>> >>> +             .owner  = THIS_MODULE,
>> >>> +             .of_match_table = sec_usbphy_dt_match,
>> >>> +     },
>> >>> +};
>> >>> +
>> >>> +static int __init sec_usbphy_driver_init(void)
>> >>> +{
>> >>> +     return platform_driver_register(&sec_usbphy_driver);
>> >>> +}
>> >>> +subsys_initcall(sec_usbphy_driver_init);
>> >>> +
>> >>> +static void __exit sec_usbphy_driver_exit(void)
>> >>> +{
>> >>> +     return platform_driver_unregister(&sec_usbphy_driver);
>> >>> +}
>> >>> +module_exit(sec_usbphy_driver_exit);
>> >>> +
>> >>> +MODULE_DESCRIPTION("Samsung USB phy controller");
>> >>> +MODULE_AUTHOR("Praveen Paneri <p.paneri@samsung.com>");
>> >>> +MODULE_LICENSE("GPL");
>> >>> +MODULE_ALIAS("platform:sec-usbphy");
>> >>> diff --git a/drivers/usb/phy/sec_usbphy.h
>> >>> b/drivers/usb/phy/sec_usbphy.h new file mode 100644
>> >>> index 0000000..06e81d4
>> >>> --- /dev/null
>> >>> +++ b/drivers/usb/phy/sec_usbphy.h
>> >>> @@ -0,0 +1,48 @@
>> >>> +/*
>> >>> + * Copyright (C) 2012 Samsung Electronics Co.Ltd
>> >>> + * Author: Yulgon Kim <yulgon.kim@samsung.com>
>> >>> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
>> >>> + * Author: Praveen Paneri <p.paneri@samsung.com>
>> >>> + *
>> >>> + * This program is free software; you can redistribute  it and/or
>> >>> modify
>> >>> it + * under  the terms of  the GNU General  Public License as
>> >>> published by the + * Free Software Foundation;  either version 2 of
>> >>> the  License, or
>> >>> (at your + * option) any later version.
>> >>> + */
>> >>> +
>> >>> +#ifndef __SEC_USBPHY_H
>> >>> +#define __SEC_USBPHY_H
>> >>> +
>> >>> +#define S3C_PHYPWR                           (0x00)
>> >>> +
>> >>> +#define S3C_PHYPWR_NORMAL_MASK                       (0x19 << 0)
>> >>> +#define S3C_PHYPWR_OTG_DISABLE                       (1 << 4)
>> >>> +#define S3C_PHYPWR_ANALOG_POWERDOWN          (1 << 3)
>> >>> +#define S3C_PHYPWR_FORCE_SUSPEND             (1 << 1)
>> >>> +/* For Exynos4 */
>> >>> +#define EXYNOS4_PHYPWR_NORMAL_MASK           (0x39 << 0)
>> >>> +#define EXYNOS4_PHYPWR_SLEEP                 (1 << 5)
>> >>> +
>> >>> +#define S3C_PHYCLK                           (0x04)
>> >>> +
>> >>> +#define S3C_PHYCLK_MODE_SERIAL                       (1 << 6)
>> >>> +#define S3C_PHYCLK_EXT_OSC                   (1 << 5)
>> >>> +#define S3C_PHYCLK_COMMON_ON_N                       (1 << 4)
>> >>> +#define S3C_PHYCLK_ID_PULL                   (1 << 2)
>> >>> +#define S3C_PHYCLK_CLKSEL_MASK                       (0x3 << 0)
>> >>> +#define S3C_PHYCLK_CLKSEL_SHIFT                      (0)
>> >>> +#define S3C_PHYCLK_CLKSEL_48M                        (0x0 << 0)
>> >>> +#define S3C_PHYCLK_CLKSEL_12M                        (0x2 << 0)
>> >>> +#define S3C_PHYCLK_CLKSEL_24M                        (0x3 << 0)
>> >>> +
>> >>> +#define S3C_RSTCON                           (0x08)
>> >>> +
>> >>> +#define S3C_RSTCON_PHYCLK                    (1 << 2)
>> >>> +#define S3C_RSTCON_HCLK                              (1 << 1)
>> >>> +#define S3C_RSTCON_PHY                               (1 << 0)
>> >>> +
>> >>> +#ifndef MHZ
>> >>> +#define MHZ (1000*1000)
>> >>> +#endif
>> >>> +
>> >>> +#endif /* __SEC_USBPHY_H */
>> >>> diff --git a/include/linux/platform_data/s3c-hsotg.h
>> >>> b/include/linux/platform_data/s3c-hsotg.h index 8b79e09..25ed31e 100644
>> >>> --- a/include/linux/platform_data/s3c-hsotg.h
>> >>> +++ b/include/linux/platform_data/s3c-hsotg.h
>> >>> @@ -35,6 +35,11 @@ struct s3c_hsotg_plat {
>> >>>
>> >>>       int (*phy_exit)(struct platform_device *pdev, int type);
>> >>>
>> >>>  };
>> >>>
>> >>> +struct s3c_usbphy_plat {
>> >>> +     void (*pmu_isolation)(int on);
>> >>> +};
>> >>> +
>> >>>
>> >>>  extern void s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd);
>> >>>
>> >>> +extern void s3c_usbphy_set_platdata(struct s3c_usbphy_plat *pd);
>> >>>
>> >>>  #endif /* __LINUX_USB_S3C_HSOTG_H */
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> >> the body of a message to majordomo at vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-samsung-soc" in
>> > the body of a message to majordomo at vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
