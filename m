From: ran.wang_1@nxp.com (Ran Wang)
Date: Fri, 7 Sep 2018 09:48:41 +0000
Subject: [PATCH 3/3] soc: fsl: add RCPM driver
In-Reply-To: <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
 <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
 <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com>
Message-ID: <AM5PR0402MB2865E57EDC0DE8B0047282A2F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On September 05, 2018 at 11:22 Yang Li wrote:
> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Wednesday, September 05, 2018 11:22
> To: dongsheng.wang at hxt-semitech.com
> Cc: Ran Wang <ran.wang_1@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linuxppc-
> dev <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>
> Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
> 
> On Tue, Sep 4, 2018 at 9:58 PM Wang, Dongsheng <dongsheng.wang@hxt-
> semitech.com> wrote:
> >
> > Please change your comments style.
> 
> Although this doesn't get into the Linux kernel coding style documentation
> yet, Linus seems changed his mind to prefer // than /*
> */ comment style now.
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml
> .org%2Flkml%2F2017%2F11%2F25%2F133&amp;data=02%7C01%7Cran.wang_
> 1%40nxp.com%7Cc0d88e6690384e02b95108d612dec235%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C0%7C636717145285126200&amp;sdata=JIoCZp
> WhRyW76EqgSflfTDA1f0gMQGKa%2FcbvSc5CO%2Fw%3D&amp;reserved=0
> So the
> // style should be acceptable for now.
> 
> >
> > On 2018/8/31 11:56, Ran Wang wrote:
> > > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > > Control and Power Management), which performs all device-level tasks
> > > associated with power management such as wakeup source control.
> > >
> > > This driver depends on FSL platform PM driver framework which help
> > > to isolate user and PM service provider (such as RCPM driver).
> > >
> > > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > > Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > >  drivers/soc/fsl/Kconfig   |    6 ++
> > >  drivers/soc/fsl/Makefile  |    1 +
> > >  drivers/soc/fsl/ls-rcpm.c |  153
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 160 insertions(+), 0 deletions(-)  create mode
> > > 100644 drivers/soc/fsl/ls-rcpm.c
> > >
> > > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> > > 6517412..882330d 100644
> > > --- a/drivers/soc/fsl/Kconfig
> > > +++ b/drivers/soc/fsl/Kconfig
> > > @@ -30,3 +30,9 @@ config FSL_PLAT_PM
> > >         have to know the implement details of wakeup function it require.
> > >         Besides, it is also easy for service side to upgrade its logic when
> > >         design changed and remain user side unchanged.
> > > +
> > > +config LS_RCPM
> > > +     bool "Freescale RCPM support"
> > > +     depends on (FSL_PLAT_PM)
> > > +     help
> > > +       This feature is to enable specified wakeup source for system sleep.
> > > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> > > index 8f9db23..43ff71a 100644
> > > --- a/drivers/soc/fsl/Makefile
> > > +++ b/drivers/soc/fsl/Makefile
> > > @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)            += qe/
> > >  obj-$(CONFIG_CPM)                    += qe/
> > >  obj-$(CONFIG_FSL_GUTS)                       += guts.o
> > >  obj-$(CONFIG_FSL_PLAT_PM)    += plat_pm.o
> > > +obj-$(CONFIG_LS_RCPM)                += ls-rcpm.o
> 
> Probably use "_" instead of "-" for alignment.

OK, will update in next version

> > > diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
> > > new file mode 100644 index 0000000..b0feb88
> > > --- /dev/null
> > > +++ b/drivers/soc/fsl/ls-rcpm.c
> > > @@ -0,0 +1,153 @@
> > > +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.c - Freescale
> > > +Layerscape RCPM driver
> 
> The file name here is not the same as the real file name.

Got it, will correct it.

> > > +//
> > > +// Copyright 2018 NXP
> > > +//
> > > +// Author: Ran Wang <ran.wang_1@nxp.com>,
> 
> Where do you need the comma in the end?

My bad, will remove comma in next version.

> > > +
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/slab.h>
> > > +#include <soc/fsl/plat_pm.h>
> > > +
> > > +#define MAX_COMPATIBLE_NUM   10
> > > +
> > > +struct rcpm_t {
> > > +     struct device *dev;
> > > +     void __iomem *ippdexpcr_addr;
> > > +     bool big_endian;        /* Big/Little endian of RCPM module */
> > > +};
> > > +
> > > +// rcpm_handle - Configure RCPM reg according to wake up source
> > > +request // @user_dev: pointer to user's device struct // @flag: to
> > > +enable(true) or disable(false) wakeup source // @handle_priv:
> > > +pointer to struct rcpm_t instance // // Return 0 on success other
> > > +negative errno
> 
> Although Linus preferred this // comment style.  I'm not sure if this will be
> handled correctly by the kernel-doc compiler.
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> w.kernel.org%2Fdoc%2Fhtml%2Fv4.18%2Fdoc-guide%2Fkernel-
> doc.html&amp;data=02%7C01%7Cran.wang_1%40nxp.com%7Cc0d88e669038
> 4e02b95108d612dec235%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636717145285126200&amp;sdata=H7GkUNOLVG%2FCcZESzhtHBeHCbO9
> %2FK4k9EdH30Cxq2%2BM%3D&amp;reserved=0

So, do you think I need to change all comment style back to '/* ... */' ?
Actually I feel a little bit confused here.

Regards,
Ran

> > > +static int rcpm_handle(struct device *user_dev, bool flag, void
> > > +*handle_priv) {
> > > +     struct rcpm_t *rcpm;
> > > +     bool big_endian;
> > > +     const char  *dev_compatible_array[MAX_COMPATIBLE_NUM];
> > > +     void __iomem *ippdexpcr_addr;
> > > +     u32 ippdexpcr;
> > > +     u32 set_bit;
> > > +     int ret, num, i;
> > > +
> > > +     rcpm = handle_priv;
> > > +     big_endian = rcpm->big_endian;
> > > +     ippdexpcr_addr = rcpm->ippdexpcr_addr;
> > > +
> > > +     num = device_property_read_string_array(user_dev, "compatible",
> > > +                     dev_compatible_array, MAX_COMPATIBLE_NUM);
> > > +     if (num < 0)
> > > +             return num;
> > > +
> > > +     for (i = 0; i < num; i++) {
> > > +             if (!device_property_present(rcpm->dev,
> > > +                                     dev_compatible_array[i]))
> > > +                     continue;
> > > +             else {
> > Remove this else.
> > > +                     ret = device_property_read_u32(rcpm->dev,
> > > +                                     dev_compatible_array[i], &set_bit);
> > > +                     if (ret)
> > > +                             return ret;
> > > +
> > > +                     if (!device_property_present(rcpm->dev,
> > > +
> > > + dev_compatible_array[i]))
> > This has been checked. Continue ? or return ENODEV?
> > > +                             return -ENODEV;
> > > +                     else {
> > Remove this else.
> > > +                             ret = device_property_read_u32(rcpm->dev,
> > > +                                             dev_compatible_array[i], &set_bit);
> > > +                             if (ret)
> > > +                                     return ret;
> > > +
> > > +                             if (big_endian)
> > > +                                     ippdexpcr = ioread32be(ippdexpcr_addr);
> > > +                             else
> > > +                                     ippdexpcr =
> > > + ioread32(ippdexpcr_addr);
> > > +
> > > +                             if (flag)
> > > +                                     ippdexpcr |= set_bit;
> > > +                             else
> > > +                                     ippdexpcr &= ~set_bit;
> > > +
> > > +                             if (big_endian) {
> > > +                                     iowrite32be(ippdexpcr, ippdexpcr_addr);
> > > +                                     ippdexpcr = ioread32be(ippdexpcr_addr);
> > > +                             } else
> > if (x) {
> > ....
> > ....
> > }  else {
> >
> > }
> > > +                                     iowrite32(ippdexpcr,
> > > + ippdexpcr_addr);
> > > +
> > > +                             return 0;
> > > +                     }
> > > +             }
> > > +     }
> > > +
> > > +     return -ENODEV;
> > > +}
> > > +
> > > +static int ls_rcpm_probe(struct platform_device *pdev) {
> > > +     struct resource *r;
> > > +     struct rcpm_t *rcpm;
> > > +
> > > +     r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +     if (!r)
> > > +             return -ENODEV;
> > > +
> > > +     rcpm = kmalloc(sizeof(*rcpm), GFP_KERNEL);
> > kzalloc is better.
> > > +     if (!rcpm)
> > > +             return -ENOMEM;
> > > +
> > > +     rcpm->big_endian = device_property_read_bool(&pdev->dev,
> > > + "big-endian");
> > > +
> > > +     rcpm->ippdexpcr_addr = devm_ioremap_resource(&pdev->dev, r);
> > > +     if (IS_ERR(rcpm->ippdexpcr_addr))
> > > +             return PTR_ERR(rcpm->ippdexpcr_addr);
> > > +
> > > +     rcpm->dev = &pdev->dev;
> > > +     platform_set_drvdata(pdev, rcpm);
> > > +
> > > +     return register_fsl_platform_wakeup_source(rcpm_handle, rcpm);
> > > +}
> > > +
> > > +static int ls_rcpm_remove(struct platform_device *pdev) {
> > > +     struct rcpm_t   *rcpm;
> > Not need a table.
> >
> > Cheers,
> > -Dongsheng
> >
> > > +
> > > +     rcpm = platform_get_drvdata(pdev);
> > > +     deregister_fsl_platform_wakeup_source(rcpm);
> > > +     kfree(rcpm);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct of_device_id ls_rcpm_of_match[] = {
> > > +     { .compatible = "fsl,qoriq-rcpm-2.1", },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ls_rcpm_of_match);
> > > +
> > > +static struct platform_driver ls_rcpm_driver = {
> > > +     .driver = {
> > > +             .name = "ls-rcpm",
> > > +             .of_match_table = ls_rcpm_of_match,
> > > +     },
> > > +     .probe = ls_rcpm_probe,
> > > +     .remove = ls_rcpm_remove,
> > > +};
> > > +
> > > +static int __init ls_rcpm_init(void) {
> > > +     return platform_driver_register(&ls_rcpm_driver);
> > > +}
> > > +subsys_initcall(ls_rcpm_init);
> > > +
> > > +static void __exit ls_rcpm_exit(void) {
> > > +     platform_driver_unregister(&ls_rcpm_driver);
> > > +}
> > > +module_exit(ls_rcpm_exit);
> >
> >
