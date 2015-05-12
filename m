From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 May 2015 15:26:34 +0200
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1431422671.2398.155.camel@x220>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
 <1431422671.2398.155.camel@x220>
Message-ID: <20150512132634.GV6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, May 12, 2015 at 11:24:31AM +0200, Paul Bolle wrote:
> On Mon, 2015-05-11 at 21:23 +0200, Sascha Hauer wrote:
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> 
> > +config MTK_INFRACFG
> > +	tristate "MediaTek INFRACFG Support"
> > +	depends on ARCH_MEDIATEK
> > +	select REGMAP
> > +	help
> > +	  Say yes here to add support for the MediaTek INFRACFG controller. The
> > +	  INFRACFG controller contains various infrastructure registers not
> > +	  directly associated to any device.
> 
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> 
> > +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> 
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-infracfg.c
> 
> > +EXPORT_SYMBOL_GPL(mtk_infracfg_set_bus_protection);
> 
> > +EXPORT_SYMBOL_GPL(mtk_infracfg_clear_bus_protection);
> 
> As I understand it, if both MTK_INFRACFG and MTK_SCPSYS (see 3/5) are m
> we will get mtk-infracfg.ko and mtk-scpsys.ko (see 3/5). And loading
> mtk-scpsys.ko will trigger loading mtk-infracfg.ko, right?
> 
> But since this file has no MODULE_LICENSE() that should generate a
> warning and taint the kernel. (I haven't tested this. Please correct me
> if I'm overlooking something here.)

No, you're absolutely right here. It turned out though that the power
domain specific functions are not exported to modules and also there is
no unregistration code for power domains, so compiling this code as
modules doesn't work anyway. I'll change the tristate to bool.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
