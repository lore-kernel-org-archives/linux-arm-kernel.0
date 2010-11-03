From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 3 Nov 2010 16:30:03 +0100
Subject: [PATCH 02/17] ARM: pxa: Access SMEMC via virtual addresses
In-Reply-To: <AANLkTimdrc1XjnTbq8nW+0yov00YyhpJnMG9j57f4uZk@mail.gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
	<1288741914-21328-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTimdrc1XjnTbq8nW+0yov00YyhpJnMG9j57f4uZk@mail.gmail.com>
Message-ID: <201011031630.03658.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 November 2010 15:37:14 Eric Miao wrote:
> On Wed, Nov 3, 2010 at 7:51 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > This is important because on PXA3xx, the physical mapping of SMEMC
> > registers differs from the one on PXA2xx. In order to get PCMCIA working
> > on both PXA2xx and PXA320, the PCMCIA driver was adjusted accordingly as
> > well.
> > 
> > Also, various places in the kernel had to be patched to use
> > __raw_read/__raw_write.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> > ---
> >  arch/arm/mach-pxa/cm-x2xx.c                  |   13 +++--
> >  arch/arm/mach-pxa/cpufreq-pxa2xx.c           |   10 ++--
> >  arch/arm/mach-pxa/csb726.c                   |    7 ++-
> >  arch/arm/mach-pxa/generic.c                  |    1 +
> >  arch/arm/mach-pxa/h5000.c                    |    9 ++--
> >  arch/arm/mach-pxa/include/mach/pxa-smemc.h   |   74
> > ++++++++++++++++++++++++++ arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
> > |   55 ------------------- arch/arm/mach-pxa/lpd270.c                  
> > |    3 +-
> >  arch/arm/mach-pxa/lubbock.c                  |    3 +-
> >  arch/arm/mach-pxa/mainstone.c                |    5 +-
> >  arch/arm/mach-pxa/pxa25x.c                   |    5 +-
> >  arch/arm/mach-pxa/pxa27x.c                   |   10 ++--
> >  arch/arm/mach-pxa/pxa3xx.c                   |    5 +-
> >  arch/arm/mach-pxa/sleep.S                    |    2 +-
> >  arch/arm/mach-pxa/smemc.c                    |   51 ++++++------------
> >  arch/arm/mach-pxa/spitz.c                    |    5 +-
> >  arch/arm/mach-pxa/stargate2.c                |    3 +-
> >  arch/arm/mach-pxa/tosa.c                     |    7 ++-
> >  arch/arm/mach-pxa/trizeps4.c                 |    3 +-
> >  arch/arm/mach-pxa/xcep.c                     |    5 +-
> >  arch/arm/mach-pxa/zeus.c                     |    5 +-
> >  drivers/pcmcia/pxa2xx_base.c                 |   65
> > +++++++++++++++------- 22 files changed, 196 insertions(+), 150
> > deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/include/mach/pxa-smemc.h
> > 

SNIP

> > diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> > index 0909df2..2f21144 100644
> > --- a/arch/arm/mach-pxa/zeus.c
> > +++ b/arch/arm/mach-pxa/zeus.c
> > @@ -47,6 +47,7 @@
> >  #include <mach/audio.h>
> >  #include <mach/arcom-pcmcia.h>
> >  #include <mach/zeus.h>
> > +#include <mach/pxa-smemc.h>
> > 
> >  #include "generic.h"
> > 
> > @@ -828,8 +829,8 @@ static void __init zeus_init(void)
> >        pr_info("Zeus CPLD V%dI%d\n", (system_rev & 0xf0) >> 4,
> > (system_rev & 0x0f));
> > 
> >        /* Fix timings for dm9000s (CS1/CS2)*/
> > -       MSC0 = (MSC0 & 0xffff) | (dm9000_msc << 16);
> > -       MSC1 = (MSC1 & 0xffff0000) | dm9000_msc;
> > +       __raw_writel((MSC0 & 0xffff) | (dm9000_msc << 16), MSC0);
> > +       __raw_writel((MSC1 & 0xffff0000) | dm9000_msc, MSC1);
> 
> This isn't correct.

I don't see the difference (well, besides that this should be adjusted by 
bootloader).

> 
> >        pm_power_off = zeus_power_off;
> >        zeus_setup_apm();
> > diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
> > index ae07b4d..65a8b6f 100644
> > --- a/drivers/pcmcia/pxa2xx_base.c
> > +++ b/drivers/pcmcia/pxa2xx_base.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/platform_device.h>
> > 
> >  #include <mach/hardware.h>
> > +#include <mach/pxa-smemc.h>
> >  #include <asm/io.h>
> >  #include <asm/irq.h>
> >  #include <asm/system.h>
> > @@ -116,37 +117,49 @@ static inline u_int pxa2xx_pcmcia_cmd_time(u_int
> > mem_clk_10khz,
> > 
> >  static int pxa2xx_pcmcia_set_mcmem( int sock, int speed, int clock )
> >  {
> > -       MCMEM(sock) = ((pxa2xx_mcxx_setup(speed, clock)
> > +       uint32_t val;
> > +
> > +       val = ((pxa2xx_mcxx_setup(speed, clock)
> >                & MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
> >                | ((pxa2xx_mcxx_asst(speed, clock)
> >                & MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
> >                | ((pxa2xx_mcxx_hold(speed, clock)
> >                & MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
> > 
> > +       __raw_writel(val, MCMEM(sock));
> > +
> >        return 0;
> >  }
> > 
> >  static int pxa2xx_pcmcia_set_mcio( int sock, int speed, int clock )
> >  {
> > -       MCIO(sock) = ((pxa2xx_mcxx_setup(speed, clock)
> > +       uint32_t val;
> > +
> > +       val = ((pxa2xx_mcxx_setup(speed, clock)
> >                & MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
> >                | ((pxa2xx_mcxx_asst(speed, clock)
> >                & MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
> >                | ((pxa2xx_mcxx_hold(speed, clock)
> >                & MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
> > 
> > +       __raw_writel(val, MCIO(sock));
> > +
> >        return 0;
> >  }
> > 
> >  static int pxa2xx_pcmcia_set_mcatt( int sock, int speed, int clock )
> >  {
> > -       MCATT(sock) = ((pxa2xx_mcxx_setup(speed, clock)
> > +       uint32_t val;
> > +
> > +       val = ((pxa2xx_mcxx_setup(speed, clock)
> >                & MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
> >                | ((pxa2xx_mcxx_asst(speed, clock)
> >                & MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
> >                | ((pxa2xx_mcxx_hold(speed, clock)
> >                & MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
> > 
> > +       __raw_writel(val, MCATT(sock));
> > +
> >        return 0;
> >  }
> > 
> > @@ -205,19 +218,18 @@ pxa2xx_pcmcia_frequency_change(struct
> > soc_pcmcia_socket *skt, static void pxa2xx_configure_sockets(struct
> > device *dev)
> >  {
> >        struct pcmcia_low_level *ops = dev->platform_data;
> > -
> >        /*
> >         * We have at least one socket, so set MECR:CIT
> >         * (Card Is There)
> >         */
> > -       MECR |= MECR_CIT;
> > +       uint32_t mecr = MECR_CIT;
> > 
> >        /* Set MECR:NOS (Number Of Sockets) */
> >        if ((ops->first + ops->nr) > 1 ||
> >            machine_is_viper() || machine_is_arcom_zeus())
> > -               MECR |= MECR_NOS;
> > -       else
> > -               MECR &= ~MECR_NOS;
> > +               mecr |= MECR_NOS;
> > +
> > +       __raw_writel(mecr, MECR);
> 
> This looks to be a bit inconsistent with the original code?
> 
> >  }
> > 
> >  static const char *skt_names[] = {
> > @@ -272,14 +284,24 @@ static int pxa2xx_drv_pcmcia_probe(struct
> > platform_device *dev) struct soc_pcmcia_socket *skt;
> > 
> >        ops = (struct pcmcia_low_level *)dev->dev.platform_data;
> > -       if (!ops)
> > -               return -ENODEV;
> > +       if (!ops) {
> > +               ret = -ENODEV;
> > +               goto err0;
> > +       }
> > +
> > +       if (cpu_is_pxa320() && ops->nr > 1) {
> > +               dev_err(&dev->dev, "pxa320 supports only one pcmcia
> > slot"); +               ret = -EINVAL;
> > +               goto err0;
> > +       }
> 
> This change doesn't look to be part of this patch?
> 
> >        pxa2xx_drv_pcmcia_ops(ops);
> > 
> >        sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
> > -       if (!sinfo)
> > -               return -ENOMEM;
> > +       if (!sinfo) {
> > +               ret = -ENOMEM;
> > +               goto err0;
> > +       }
> > 
> >        sinfo->nskt = ops->nr;
> > 
> > @@ -295,18 +317,19 @@ static int pxa2xx_drv_pcmcia_probe(struct
> > platform_device *dev)
> > 
> >                ret = pxa2xx_drv_pcmcia_add_one(skt);
> >                if (ret)
> > -                       break;
> > +                       goto err1;
> >        }
> > 
> > -       if (ret) {
> > -               while (--i >= 0)
> > -                       soc_pcmcia_remove_one(&sinfo->skt[i]);
> > -               kfree(sinfo);
> > -       } else {
> > -               pxa2xx_configure_sockets(&dev->dev);
> > -               dev_set_drvdata(&dev->dev, sinfo);
> > -       }
> > +       pxa2xx_configure_sockets(&dev->dev);
> > +       dev_set_drvdata(&dev->dev, sinfo);
> > 
> > +       return 0;
> > +
> > +err1:
> > +       while (--i >= 0)
> > +               soc_pcmcia_remove_one(&sinfo->skt[i]);
> > +       kfree(sinfo);
> > +err0:
> >        return ret;
> >  }
> > 
> > --
> > 1.7.2.3

Splited into two patches. Thanks

Cheers
