From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 21:21:50 +0100
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <532A03BE.3070003@cogentembedded.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-7-git-send-email-arnd@arndb.de>
 <532A03BE.3070003@cogentembedded.com>
Message-ID: <4836281.0IgPinItBq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014 23:53:18 Sergei Shtylyov wrote:
> On 03/19/2014 10:29 PM, Arnd Bergmann wrote:
> 
> > The ohci-da8xx driver uses the DA8XX_SYSCFG0_VIRT macro to
> > access the CFGCHIP2 register for controlling its PHY.
> 
> > The macro in turn relies on the da8xx_syscfg0_base global
> > variable. Since the OHCI driver can be a loadable module,
> > this requires the symbol to be exported from platform code.
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: davinci-linux-open-source at linux.davincidsp.com
> > ---
> >   arch/arm/mach-davinci/devices-da8xx.c | 1 +
> >   1 file changed, 1 insertion(+)
> 
> > diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> > index 0486cdf..4da868a 100644
> > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> > @@ -66,6 +66,7 @@
> >   #define DA850_DMA_MMCSD1_TX EDMA_CTLR_CHAN(1, 29)
> >
> >   void __iomem *da8xx_syscfg0_base;
> > +EXPORT_SYMBOL_GPL(da8xx_syscfg0_base); /* used by OHCI_HCD */
> 
>     I have submitted such patch years ago and it was turned down. 
> 

The question is whether there is anyone who would do this properly.

Both the OHCI and MUSB drivers use exactly one register (CFGCHIP2)
to control the clock, phy and host/gadget mode switch.

In the modern world, we'd probably want to have a clock driver and
a phy driver for these, based on a syscon driver.

In all honesty I don't see that happening on davinci.

A somewhat better approach would be to export a set of exported
functions to access the one register from the platform, e.g.

u32 da8xx_cfgchip2_get(void);
void da8xx_cfgchip2_set(u32);

That interface would still be a bit ugly, but much better than
what we have today, and easy to implement.

	Arnd
