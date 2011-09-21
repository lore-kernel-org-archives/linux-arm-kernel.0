From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Sep 2011 13:49:22 -0400 (EDT)
Subject: DT vs ARM static mappings
In-Reply-To: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
References: <1316519479.4611.150.camel@hornet.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1109211320090.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Sep 2011, Pawel Moll wrote:

> ARM machine description contains a "map_io" method, which is used to
> create static memory mappings (using iotable_init() function) for things
> like peripherals or SRAMs. At least that's the theory, because most of
> the platforms are doing much more stuff there, like clocking/GPIOs/UARTs
> initialization, hardware probing etc.

No, most of them don't.  Maybe a few cases do for historical reasons, 
but there are other hooks now to link probing and initialization code 
to.

The static mappings should be just that: static.  Most things should be 
dynamically mapped instead.  With the series I'm working on, everybody 
will get the benefit of a static mapping when one is available even if 
the dynamic mapping interface like ioremap() is used.  So having a bunch 
of static mappings is not bad, especially if they are easy.  But you 
should defer as much hardware probing as possible after the memory is 
initialized and the standard interfaces are available, keeping reliance 
on direct access to static mappings as small as possible.

> Now the Versatile Express platform: it consists of a motherboard with a
> set of peripherals and a processor daughterboard (core tile), both
> connected via a static memory bus, which is mapped into processor's
> physical address space. The motherboard can be shared between different
> types of the tiles (eg. A9, A5, A15 etc.). The present one is probed byt
> he motherboard firmware and exposed in "system registers".
> 
> Everything is fine so far. The interesting part starts here:
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.dui0447e/CACIHGFE.html
> 
> In brief, depending on the configuration, the system can have one of
> two, totally different, memory maps (please, do spare me the "but why
> did they do that" comments - not my idea nor decision, I just have to
> live with this ;-), depending on the core tile being used.
> 
> In result, the static mapping as defined currently in
> arch/arm/mach-vexpress/v2m.c for A9 variant:
> 
> #define V2M_PA_CS7      0x10000000
> 
> static struct map_desc v2m_io_desc[] __initdata = {
>         {
>                 .virtual        = __MMIO_P2V(V2M_PA_CS7),
>                 .pfn            = __phys_to_pfn(V2M_PA_CS7),
>                 .length         = SZ_128K,
>                 .type           = MT_DEVICE,
>         },
> };
> 
> is no longer valid for A5/A15. It would rather look like this:
> 
> #define V2M_PA_CS3      0x1c000000
> 
> static struct map_desc v2m_io_desc[] __initdata = {
>         {
>                 .virtual        = __MMIO_P2V(V2M_PA_CS3),
>                 .pfn            = __phys_to_pfn(V2M_PA_CS3),
>                 .length         = SZ_2M,
>                 .type           = MT_DEVICE,
>         },
> };
> 
> Not only the peripherals base address is changed but also "internal"
> alignment, thus offsets to peripherals. Some of them are not being
> ioremap()ed, but directly used via the static mapping and MMIO_P2V macro
> (like "readl(MMIO_P2V(V2M_SYS_PROCID0))" in v2m_populate_ct_desc(void)
> function). For example, these two:
> 
> #define V2M_SYSREGS             (V2M_PA_CS7 + 0x00000000)
> #define V2M_SYSCTL              (V2M_PA_CS7 + 0x00001000)
> 
> would have to become:
> 
> #define V2M_SYSREGS             (V2M_PA_CS3 + 0x00010000)
> #define V2M_SYSCTL              (V2M_PA_CS3 + 0x00020000)

Your best bet would probably consist of keeping the virtual address 
constant while the physical address is variable.  Adjusting the .pfn 
field in the v2m_io_desc table right before calling iotable_init() 
should be fine.  Alternatively you could have two such tables and select 
the right one at run time.  The io_p2v macro doesn't make any sense 
anymore in that context so it should be eliminated, and keeping only a 
minimum set of fixed virtual addresses for the peripherals that can't 
wait until ioremap is available should be fine.

Of course you should use the largest alignment for the same peripheral 
mapping.

[...]
> To my mind it looked like the whole mechanism was not flexible enough,
> so I wanted to explore other options...
> 
> The obvious one was to describe the required static mapping in the DTS.
> I don't like this idea, though. It can hardly be called "hardware
> description". Besides, what node would carry such data? "chosen"?
> Hardly...
> 
> Would it contain a "regs" property with the physical address and
> "virtual-reg" with the virtual one? Again, doesn't sound right to me
> (especially the virtual bit, however the virtual address could be common
> between different variants and be defined in the board support code, not
> the DTS).

That's what I'm suggesting: keep the virtual addresses constant, and 
adjust the static mapping's physical address accordingly.  But never 
should virtual addresses be part of DT as this is just an implementation 
detail.

And if static mappings are a problem, then try to live without them as 
much as possible.  Again there is no reason you should be doing too much 
hardware probing at .map_io time.


Nicolas
