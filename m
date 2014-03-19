From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Mar 2014 01:36:13 +0300
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <4836281.0IgPinItBq@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-7-git-send-email-arnd@arndb.de>
 <532A03BE.3070003@cogentembedded.com> <4836281.0IgPinItBq@wuerfel>
Message-ID: <532A1BDD.904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2014 11:21 PM, Arnd Bergmann wrote:

>>> The ohci-da8xx driver uses the DA8XX_SYSCFG0_VIRT macro to
>>> access the CFGCHIP2 register for controlling its PHY.

>>> The macro in turn relies on the da8xx_syscfg0_base global
>>> variable. Since the OHCI driver can be a loadable module,
>>> this requires the symbol to be exported from platform code.

>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Sekhar Nori <nsekhar@ti.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>> Cc: davinci-linux-open-source at linux.davincidsp.com
>>> ---
>>>    arch/arm/mach-davinci/devices-da8xx.c | 1 +
>>>    1 file changed, 1 insertion(+)

>>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>>> index 0486cdf..4da868a 100644
>>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>>> @@ -66,6 +66,7 @@
>>>    #define DA850_DMA_MMCSD1_TX EDMA_CTLR_CHAN(1, 29)
>>>
>>>    void __iomem *da8xx_syscfg0_base;
>>> +EXPORT_SYMBOL_GPL(da8xx_syscfg0_base); /* used by OHCI_HCD */

>>      I have submitted such patch years ago and it was turned down.

    I also had a pleasure of completing implementation of this driver and 
submitting it back in 2009 when I was working for MontaVista. :-)

> The question is whether there is anyone who would do this properly.

    Nobody cares, it seems. As you can imagine, I stopped to care enough after 
being switched to other projects.

> Both the OHCI and MUSB drivers use exactly one register (CFGCHIP2)

    The idea at the time was to just ioremap() this register but I was not 
very eager.
There was no USB PHY driver subsystem yet.

> to control the clock, phy

    Note that it only controls PHY clock (PLL) which could be covered by an 
USB PHY driver.

> and host/gadget mode switch.

    The main mode the USB 2.0 PHY should function now is OTG. The host/gadged 
modes are forced overrides of the ID pin. Unfortunately, the board code has to 
force host mode when host-only driver config is selected (these MUSB's 
host/gadget only modes were removed at one point but got reintroduced again).

> In the modern world, we'd probably want to have a clock driver and

    Not sure about the clock driver...

> a phy driver for these,

    Yes, that's what the MUSB maintainer wants too. The issue is the driver 
should somehow differ which USB controller it's bound too and do different 
things depending on that (at least that's how it looks now). I'm not sure it's 
possible, so probably should be rethought.

> based on a syscon driver.

    I don't know what syscon is...

> In all honesty I don't see that happening on davinci.

    I don't think people use USB 1.1 controllers these days, especially when 
there is USB 2.0 in the same SoC. For MUSB, there were recent attempt to get 
the DA8xx driver out of the broken state but it was turned down as well, IIRC, 
since it didn't offer a PHY driver.

> A somewhat better approach would be to export a set of exported
> functions to access the one register from the platform, e.g.

> u32 da8xx_cfgchip2_get(void);
> void da8xx_cfgchip2_set(u32);

> That interface would still be a bit ugly, but much better than
> what we have today, and easy to implement.

    I'm leaving this idea to Sekhar...

> 	Arnd

WBR, Sergei
