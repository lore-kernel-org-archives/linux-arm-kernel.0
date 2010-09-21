From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 21 Sep 2010 23:56:55 +0200
Subject: [PATCH 02/11] ARM: pxa: Toradex Colibri PXA270 CF support
In-Reply-To: <AANLkTinUHyFqCbTPYv73U8r8Df=eW74ns82LiT9yiH7K@mail.gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
	<1284604382-23683-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTinUHyFqCbTPYv73U8r8Df=eW74ns82LiT9yiH7K@mail.gmail.com>
Message-ID: <201009212356.55506.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 20. z??? 2010 16:16:54 Eric Miao napsal(a):
> On Thu, Sep 16, 2010 at 10:32 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > This driver also contains structures to eventually support PXA320. This
> > is planned to be added in a later patch.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Acked-by: Daniel Mack <daniel@caiaq.de>
> > ---
> >  arch/arm/mach-pxa/colibri-pxa270-evalboard.c |   18 ++
> >  drivers/pcmcia/Kconfig                       |    2 +-
> >  drivers/pcmcia/Makefile                      |    1 +
> >  drivers/pcmcia/pxa2xx_colibri.c              |  214
> > ++++++++++++++++++++++++++ 4 files changed, 234 insertions(+), 1
> > deletions(-)
> >  create mode 100644 drivers/pcmcia/pxa2xx_colibri.c
> > 
> > diff --git a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c index 0f3b632..6177ff5
> > 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > @@ -51,6 +51,24 @@ static mfp_cfg_t colibri_pxa270_evalboard_pin_config[]
> > __initdata = { GPIO89_USBH1_PEN,
> >        GPIO119_USBH2_PWR,
> >        GPIO120_USBH2_PEN,
> > +
> > +       /* PCMCIA */
> > +       GPIO85_nPCE_1,
> > +       GPIO54_nPCE_2,
> > +       GPIO55_nPREG,
> > +       GPIO50_nPIOR,
> > +       GPIO51_nPIOW,
> > +       GPIO49_nPWE,
> > +       GPIO48_nPOE,
> > +       GPIO57_nIOIS16,
> > +       GPIO56_nPWAIT,
> > +       GPIO104_PSKTSEL,
> > +       GPIO53_GPIO,    /* RESET */
> > +       GPIO83_GPIO,    /* BVD1 */
> > +       GPIO82_GPIO,    /* BVD2 */
> > +       GPIO1_GPIO,     /* READY */
> > +       GPIO84_GPIO,    /* DETECT */
> > +       GPIO107_GPIO,   /* PPEN */
> >  };
> > 
> >  /***********************************************************************
> > ******* diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> > index c80a7a6..e9acf03 100644
> > --- a/drivers/pcmcia/Kconfig
> > +++ b/drivers/pcmcia/Kconfig
> > @@ -215,7 +215,7 @@ config PCMCIA_PXA2XX
> >        depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
> >                    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
> >                    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2
> > \ -                   || MACH_VPAC270 || MACH_BALLOON3)
> > +                   || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI)
> >        select PCMCIA_SOC_COMMON
> >        help
> >          Say Y here to include support for the PXA2xx PCMCIA controller
> > diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> > index 8d9386a..2fee7ef 100644
> > --- a/drivers/pcmcia/Makefile
> > +++ b/drivers/pcmcia/Makefile
> > @@ -70,6 +70,7 @@ pxa2xx-obj-$(CONFIG_MACH_E740)                      
> >  += pxa2xx_e740.o pxa2xx-obj-$(CONFIG_MACH_STARGATE2)            +=
> > pxa2xx_stargate2.o pxa2xx-obj-$(CONFIG_MACH_VPAC270)              +=
> > pxa2xx_vpac270.o pxa2xx-obj-$(CONFIG_MACH_BALLOON3)             +=
> > pxa2xx_balloon3.o +pxa2xx-obj-$(CONFIG_MACH_COLIBRI)              +=
> > pxa2xx_colibri.o
> > 
> >  obj-$(CONFIG_PCMCIA_PXA2XX)                    += pxa2xx_base.o
> > $(pxa2xx-obj-y)
> > 
> > diff --git a/drivers/pcmcia/pxa2xx_colibri.c
> > b/drivers/pcmcia/pxa2xx_colibri.c new file mode 100644
> > index 0000000..4ed876c
> > --- /dev/null
> > +++ b/drivers/pcmcia/pxa2xx_colibri.c
> > @@ -0,0 +1,214 @@
> > +/*
> > + * linux/drivers/pcmcia/pxa2xx_colibri.c
> > + *
> > + * Driver for Toradex Colibri PXA270 CF socket
> > + *
> > + * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +
> > +#include <asm/mach-types.h>
> > +
> > +#include "soc_common.h"
> > +
> > +#define        COLIBRI270_RESET_GPIO   53
> > +#define        COLIBRI270_PPEN_GPIO    107
> > +#define        COLIBRI270_BVD1_GPIO    83
> > +#define        COLIBRI270_BVD2_GPIO    82
> > +#define        COLIBRI270_DETECT_GPIO  84
> > +#define        COLIBRI270_READY_GPIO   1
> > +
> > +static struct {
> > +       int     reset_gpio;
> > +       int     ppen_gpio;
> > +       int     bvd1_gpio;
> > +       int     bvd2_gpio;
> > +       int     detect_gpio;
> > +       int     ready_gpio;
> > +} colibri_pcmcia_gpio;
> > +
> > +static struct pcmcia_irqs colibri_irqs[] = {
> > +       {
> > +               .sock = 0,
> > +               .str  = "PCMCIA CD"
> > +       },
> > +};
> > +
> > +static int colibri_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
> > +{
> > +       int ret;
> > +
> > +       ret = gpio_request(colibri_pcmcia_gpio.detect_gpio, "DETECT");
> > +       if (ret)
> > +               goto err1;
> > +       ret = gpio_direction_input(colibri_pcmcia_gpio.detect_gpio);
> > +       if (ret)
> > +               goto err2;
> > +
> > +       ret = gpio_request(colibri_pcmcia_gpio.ready_gpio, "READY");
> > +       if (ret)
> > +               goto err2;
> > +       ret = gpio_direction_input(colibri_pcmcia_gpio.ready_gpio);
> > +       if (ret)
> > +               goto err3;
> > +
> > +       ret = gpio_request(colibri_pcmcia_gpio.bvd1_gpio, "BVD1");
> > +       if (ret)
> > +               goto err3;
> > +       ret = gpio_direction_input(colibri_pcmcia_gpio.bvd1_gpio);
> > +       if (ret)
> > +               goto err4;
> > +
> > +       ret = gpio_request(colibri_pcmcia_gpio.bvd2_gpio, "BVD2");
> > +       if (ret)
> > +               goto err4;
> > +       ret = gpio_direction_input(colibri_pcmcia_gpio.bvd2_gpio);
> > +       if (ret)
> > +               goto err5;
> > +
> > +       ret = gpio_request(colibri_pcmcia_gpio.ppen_gpio, "PPEN");
> > +       if (ret)
> > +               goto err5;
> > +       ret = gpio_direction_output(colibri_pcmcia_gpio.ppen_gpio, 0);
> > +       if (ret)
> > +               goto err6;
> > +
> > +       ret = gpio_request(colibri_pcmcia_gpio.reset_gpio, "RESET");
> > +       if (ret)
> > +               goto err6;
> > +       ret = gpio_direction_output(colibri_pcmcia_gpio.reset_gpio, 1);
> > +       if (ret)
> > +               goto err7;
> > +
> > +       colibri_irqs[0].irq =
> > gpio_to_irq(colibri_pcmcia_gpio.detect_gpio); +      
> > skt->socket.pci_irq = gpio_to_irq(colibri_pcmcia_gpio.ready_gpio); +
> > +       return soc_pcmcia_request_irqs(skt, colibri_irqs,
> > +                                       ARRAY_SIZE(colibri_irqs));
> > +
> > +err7:
> > +       gpio_free(colibri_pcmcia_gpio.detect_gpio);
> > +err6:
> > +       gpio_free(colibri_pcmcia_gpio.ready_gpio);
> > +err5:
> > +       gpio_free(colibri_pcmcia_gpio.bvd1_gpio);
> > +err4:
> > +       gpio_free(colibri_pcmcia_gpio.bvd2_gpio);
> > +err3:
> > +       gpio_free(colibri_pcmcia_gpio.reset_gpio);
> > +err2:
> > +       gpio_free(colibri_pcmcia_gpio.ppen_gpio);
> > +err1:
> > +       return ret;
> > +}
> 
> I'd like to advocate for my newly introduced API for such usage:
> 
> gpio_request_array() in include/asm-generic/gpio.h

Can we do this in a separate patch?
> 
> > +
> > +static void colibri_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
> > +{
> > +       gpio_free(colibri_pcmcia_gpio.detect_gpio);
> > +       gpio_free(colibri_pcmcia_gpio.ready_gpio);
> > +       gpio_free(colibri_pcmcia_gpio.bvd1_gpio);
> > +       gpio_free(colibri_pcmcia_gpio.bvd2_gpio);
> > +       gpio_free(colibri_pcmcia_gpio.reset_gpio);
> > +       gpio_free(colibri_pcmcia_gpio.ppen_gpio);
> > +}
> > +
> > +static void colibri_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
> > +                                       struct pcmcia_state *state)
> > +{
> > +
> > +       state->detect =
> > !!gpio_get_value(colibri_pcmcia_gpio.detect_gpio); +       state->ready
> >  = !!gpio_get_value(colibri_pcmcia_gpio.ready_gpio); +       state->bvd1
> >   = !!gpio_get_value(colibri_pcmcia_gpio.bvd1_gpio); +       state->bvd2
> >   = !!gpio_get_value(colibri_pcmcia_gpio.bvd2_gpio);
> 
> Can we make colibri_pcmcia_gpio some part of the *skt private data?

I looked and didn't see anything, if you have anything specific in mind, can you 
point me to it ?
> 
> > +       state->wrprot = 0;
> > +       state->vs_3v  = 1;
> > +       state->vs_Xv  = 0;
> > +}
> > +
> > +static int
> > +colibri_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
> > +                               const socket_state_t *state)
> > +{
> > +       gpio_set_value(colibri_pcmcia_gpio.ppen_gpio,
> > +                       !(state->Vcc == 33 && state->Vpp < 50));
> > +       gpio_set_value(colibri_pcmcia_gpio.reset_gpio, state->flags &
> > SS_RESET); +       return 0;
> > +}
> > +
> > +static void colibri_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
> > +{
> > +}
> > +
> > +static void colibri_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
> > +{
> > +}
> > +
> > +static struct pcmcia_low_level colibri_pcmcia_ops = {
> > +       .owner                  = THIS_MODULE,
> > +
> > +       .first                  = 0,
> > +       .nr                     = 1,
> > +
> > +       .hw_init                = colibri_pcmcia_hw_init,
> > +       .hw_shutdown            = colibri_pcmcia_hw_shutdown,
> > +
> > +       .socket_state           = colibri_pcmcia_socket_state,
> > +       .configure_socket       = colibri_pcmcia_configure_socket,
> > +
> > +       .socket_init            = colibri_pcmcia_socket_init,
> > +       .socket_suspend         = colibri_pcmcia_socket_suspend,
> > +};
> > +
> > +static struct platform_device *colibri_pcmcia_device;
> > +
> > +static int __init colibri_pcmcia_init(void)
> > +{
> > +       int ret;
> > +
> > +       colibri_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia",
> > -1); +       if (!colibri_pcmcia_device)
> > +               return -ENOMEM;
> > +
> > +       /* Colibri PXA270 */
> > +       if (machine_is_colibri()) {
> > +               colibri_pcmcia_gpio.reset_gpio  = COLIBRI270_RESET_GPIO;
> > +               colibri_pcmcia_gpio.ppen_gpio   = COLIBRI270_PPEN_GPIO;
> > +               colibri_pcmcia_gpio.bvd1_gpio   = COLIBRI270_BVD1_GPIO;
> > +               colibri_pcmcia_gpio.bvd2_gpio   = COLIBRI270_BVD2_GPIO;
> > +               colibri_pcmcia_gpio.detect_gpio = COLIBRI270_DETECT_GPIO;
> > +               colibri_pcmcia_gpio.ready_gpio  = COLIBRI270_READY_GPIO;
> > +       }
> > +
> > +       ret = platform_device_add_data(colibri_pcmcia_device,
> > +               &colibri_pcmcia_ops, sizeof(colibri_pcmcia_ops));
> > +
> > +       if (!ret)
> > +               ret = platform_device_add(colibri_pcmcia_device);
> > +
> > +       if (ret)
> > +               platform_device_put(colibri_pcmcia_device);
> > +
> > +       return ret;
> > +}
> > +
> > +static void __exit colibri_pcmcia_exit(void)
> > +{
> > +       platform_device_unregister(colibri_pcmcia_device);
> > +}
> > +
> > +module_init(colibri_pcmcia_init);
> > +module_exit(colibri_pcmcia_exit);
> > +
> > +MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
> > +MODULE_DESCRIPTION("PCMCIA support for Toradex Colibri PXA270");
> > +MODULE_ALIAS("platform:pxa2xx-pcmcia");
> > +MODULE_LICENSE("GPL");
> > --
> > 1.7.1
