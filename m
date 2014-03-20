From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Mar 2014 20:20:47 +0400
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <9096065.aGCg8yZblW@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <4836281.0IgPinItBq@wuerfel> <532A1BDD.904@cogentembedded.com>
 <9096065.aGCg8yZblW@wuerfel>
Message-ID: <532B155F.9020605@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-03-2014 10:42, Arnd Bergmann wrote:

>>> Both the OHCI and MUSB drivers use exactly one register (CFGCHIP2)

>>      The idea at the time was to just ioremap() this register but I was not
>> very eager.

    ... also it was suggested to pass the CFGCHIP2 address as a resource. I 
certainly wasn't eager to do that since if done for both MUSB and OHCI, it 
would cause sort of a resource conflict (platform device resources are 
automatically registered in the resource tree, although without marking them 
exclusive), even if we don't call request_mem_region() on them (we can't do 
that since in this case the resource would be registered as exclusive, and the 
second call would fail).

> Yes, that would work, too. However, that would cause problems later
> if we ever try to make the davinci platform "multiplatform", unless we also
> pass the physical address in a platform resource and make this a larger
> driver.

    In my opinion, we don't have to pass CFGCHIP2 as a resource and could just 
ioremap() the raw physical address.

> I think we can reasonably have an exported set of functions
> declared in the platform data header file for these drivers, but passing
> the physical address through a header file

    That's how it's passed today (however, thru <mach/da8xx.h>).

> wouldn't be much of an improvement
> over passing the virtual address.

    Not sure I understood about passing virtual address.

>> There was no USB PHY driver subsystem yet.

>>> to control the clock, phy

>>      Note that it only controls PHY clock (PLL) which could be covered by an
>> USB PHY driver.

> Good point.

>>> and host/gadget mode switch.

>>      The main mode the USB 2.0 PHY should function now is OTG. The host/gadged
>> modes are forced overrides of the ID pin. Unfortunately, the board code has to
>> force host mode when host-only driver config is selected (these MUSB's
>> host/gadget only modes were removed at one point but got reintroduced again).

> I think they are also required for 'randconfig' builds to some degree, because
> you can build a kernel without host mode for instance.

    Yes.

>>> In the modern world, we'd probably want to have a clock driver and

>>      Not sure about the clock driver...

>>> a phy driver for these,

>>      Yes, that's what the MUSB maintainer wants too. The issue is the driver
>> should somehow differ which USB controller it's bound too and do different
>> things depending on that (at least that's how it looks now). I'm not sure it's
>> possible, so probably should be rethought.

> Yes, a phy driver seems the right approach if we can find someone to do it.

    Perhaps a person that tried to unbreak the DA8xx MUSB driver could be 
interested (and competent) enough to do it...

> Ideally that should let us use generic versions of the ohci and musb drivers
> even, if that's the only davinci specific part of these drivers.

    No, not really. MUSB ceratinly has DaVinci specific register set mapped in 
its register space. OHCI has up to 2 clocks to enable since USB 1.1 PHY can be 
clocked from USB 2.0 PHY clock.

>>> based on a syscon driver.

>>      I don't know what syscon is...

> The syscon (system controller) framework helps share a set of registers
> across multiple drivers. If all accesses to the CFGCHIP2 register are
> in a single PHY driver, we wouldn't need it.

    Where can I find it in the kernel tree?

>>> In all honesty I don't see that happening on davinci.

>>      I don't think people use USB 1.1 controllers these days, especially when
>> there is USB 2.0 in the same SoC. For MUSB, there were recent attempt to get
>> the DA8xx driver out of the broken state but it was turned down as well, IIRC,
>> since it didn't offer a PHY driver.

> For USB 2.0 compliance you actually need to provide something to handle the
> low speed modes. A lot of people use a hub to do that nowadays rather than
> an OHCI or UHCI, but I don't know if that works with OTG.

    MUSB handles all speeds. I think the reason TI also included USB 1.1 
controller lies in the somewhat dubious reputation of both MUSB hardware and 
the Linux driver.

> 	Arnd

WBR, Sergei
