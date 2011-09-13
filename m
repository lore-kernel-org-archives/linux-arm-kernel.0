From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Sep 2011 09:44:24 +0200
Subject: [PATCH] Add platform driver support to the CS890x driver
In-Reply-To: <20110907125047.GU28816@pengutronix.de>
References: <1315390967-6683-1-git-send-email-jaccon.bastiaansen@gmail.com>
	<20110907125047.GU28816@pengutronix.de>
Message-ID: <20110913074424.GY31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 02:50:47PM +0200, Uwe Kleine-K?nig wrote:
> Hello Jaccon,
> 
> On Wed, Sep 07, 2011 at 12:22:47PM +0200, Jaccon Bastiaansen wrote:
> > The CS89x0 ethernet controller is used on a number of evaluation
> > boards, such as the MX31ADS. The current driver has memory address and
> > IRQ settings for each board on which this controller is used. Driver
> > updates are therefore required to support other boards that also use
> > the CS89x0. To avoid these driver updates, a better mechanism
> > (platform driver support) is added to communicate the board dependent
> > settings to the driver.
> > 
> > Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> > ---
> >  drivers/net/Kconfig  |   18 +++++++++--
> >  drivers/net/Space.c  |    2 +-
> >  drivers/net/cs89x0.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 96 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index 93359fa..17be84f 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -1497,8 +1497,7 @@ config FORCEDETH
> >  
> >  config CS89x0
> >  	tristate "CS89x0 support"
> > -	depends on NET_ETHERNET && (ISA || EISA || MACH_IXDP2351 \
> > -		|| ARCH_IXDP2X01 || MACH_MX31ADS || MACH_QQ2440)
> > +	depends on NET_ETHERNET
> >  	---help---
> >  	  Support for CS89x0 chipset based Ethernet cards. If you have a
> >  	  network (Ethernet) card of this type, say Y and read the
> > @@ -1509,10 +1508,23 @@ config CS89x0
> >  	  To compile this driver as a module, choose M here. The module
> >  	  will be called cs89x0.
> >  
> > +config CS89x0_PLATFORM
> > +	bool "CS89x0 platform driver support"
> > +	depends on CS89x0
> > +	default n
> default n is implicit so you don't need (and should not) add it here.
> 
> > +	help
> > +	  Say Y to compile the cs890x0 driver as a platform driver. This
> > +	  makes this driver suitable for use on certain evaluation boards
> > +	  such as the IMX21ADS.
> > +
> > +	  If you are unsure, say N.
> > +
> >  config CS89x0_NONISA_IRQ
> >  	def_bool y
> >  	depends on CS89x0 != n
> > -	depends on MACH_IXDP2351 || ARCH_IXDP2X01 || MACH_MX31ADS || MACH_QQ2440
> > +	depends on MACH_IXDP2351 || ARCH_IXDP2X01 || MACH_MX31ADS || \
> > +		   MACH_QQ2440 || CS89x0_PLATFORM
> > +
> >  
> >  config TC35815
> >  	tristate "TOSHIBA TC35815 Ethernet support"
> > diff --git a/drivers/net/Space.c b/drivers/net/Space.c
> > index 068c356..3c53ab1 100644
> > --- a/drivers/net/Space.c
> > +++ b/drivers/net/Space.c
> > @@ -189,7 +189,7 @@ static struct devprobe2 isa_probes[] __initdata = {
> >  #ifdef CONFIG_SEEQ8005
> >  	{seeq8005_probe, 0},
> >  #endif
> > -#ifdef CONFIG_CS89x0
> > +#if defined(CONFIG_CS89x0) && !defined(CONFIG_CS89x0_PLATFORM)
> >   	{cs89x0_probe, 0},
> >  #endif
> >  #ifdef CONFIG_AT1700
> > diff --git a/drivers/net/cs89x0.c b/drivers/net/cs89x0.c
> > index 537a4b2..604c828 100644
> > --- a/drivers/net/cs89x0.c
> > +++ b/drivers/net/cs89x0.c
> > @@ -98,6 +98,8 @@
> >    Domenico Andreoli : cavokz at gmail.com
> >                      : QQ2440 platform support
> >  
> > +  Jaccon Bastiaansen: jaccon.bastiaansen at gmail.com
> > +		    : added platform driver support
> >  */
> >  
> >  /* Always include 'config.h' first in case the user wants to turn on
> > @@ -154,7 +156,9 @@
> >  #if ALLOW_DMA
> >  #include <asm/dma.h>
> >  #endif
> > -
> > +#ifdef CONFIG_CS89x0_PLATFORM
> > +#include <linux/platform_device.h>
> > +#endif
> IMHO better include that unconditionally.
> 
> >  #include "cs89x0.h"
> >  
> >  static char version[] __initdata =
> > @@ -189,6 +193,9 @@ static unsigned int netcard_portlist[] __used __initdata = {
> >  	PBC_BASE_ADDRESS + PBC_CS8900A_IOBASE + 0x300, 0
> >  };
> >  static unsigned cs8900_irq_map[] = {EXPIO_INT_ENET_INT, 0, 0, 0};
> > +#elif defined(CONFIG_CS89x0_PLATFORM)
> > +static unsigned int netcard_portlist[] __used __initdata = {0, 0};
> > +static unsigned int cs8900_irq_map[] = {0, 0, 0, 0};
> >  #else
> >  static unsigned int netcard_portlist[] __used __initdata =
> >     { 0x300, 0x320, 0x340, 0x360, 0x200, 0x220, 0x240, 0x260, 0x280, 0x2a0, 0x2c0, 0x2e0, 0};
> > @@ -1746,7 +1753,7 @@ static int set_mac_address(struct net_device *dev, void *p)
> >  	return 0;
> >  }
> >  
> > -#ifdef MODULE
> > +#if defined(MODULE) && !defined(CONFIG_CS89x0_PLATFORM)
> >  
> >  static struct net_device *dev_cs89x0;
> >  
> > @@ -1900,7 +1907,77 @@ cleanup_module(void)
> >  	release_region(dev_cs89x0->base_addr, NETCARD_IO_EXTENT);
> >  	free_netdev(dev_cs89x0);
> >  }
> > -#endif /* MODULE */
> > +#endif /* MODULE && !CONFIG_CS89x0_PLATFORM */
> > +
> > +#ifdef CONFIG_CS89x0_PLATFORM
> > +static int cs89x0_platform_probe(struct platform_device *pdev)
> > +{
> > +	struct net_device *dev = alloc_etherdev(sizeof(struct net_local));
> > +	struct resource *mem_res;
> > +	struct resource *irq_res;
> > +	int err;
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (mem_res == NULL || irq_res == NULL) {
> > +		printk(KERN_WARNING
> > +		       DRV_NAME
> > +		       ": memory and/or interrupt resource missing.\n");
> I'd prefer you do:
> 
> 	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> at the top of the driver and then just use:
> 
> 	pr_warning("memory and/or interrupt resource missing\m");

Why not use dev_warn??

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
