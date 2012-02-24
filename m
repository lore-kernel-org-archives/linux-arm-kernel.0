From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 16:25:12 +0000
Subject: [GIT PULL] ux500 patches for v3.4
In-Reply-To: <CACRpkdZfkcAD2WqOCcDfSbiiBJxEvic5QmyzpyvUfHX39cDf9Q@mail.gmail.com>
References: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
 <201202241523.18355.arnd@arndb.de>
 <CACRpkdZfkcAD2WqOCcDfSbiiBJxEvic5QmyzpyvUfHX39cDf9Q@mail.gmail.com>
Message-ID: <201202241625.13080.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 February 2012, Linus Walleij wrote:
> > How about hardcoding the virtual address for the id register so
> > that you can actually use the same function:?
> >
> > static unsigned int ux500_read_asicid(phys_addr_t addr)
> > {
> >        phys_addr_t base = addr & ~PAGE_MASK;
> >        unsigned long offset = addr & PAGE_MASK;
> >
> >        struct map_desc desc = {
> >                .virtual        = (unsigned long)UX500_ASICID_ADDR,
> >                .pfn            = __phys_to_pfn(base),
> >                .length         = SZ_4K,
> >                .type           = MT_DEVICE,
> >        };
> >
> >        iotable_init(&desc, 1);
> >
> >        /* As in devicemaps_init() */
> >        local_flush_tlb_all();
> >        flush_cache_all();
> >
> >        return readl(UX500_ASICID_ADDR + offset);
> > }
> >
> > Then you just need to find a convenient value for UX500_ASICID_VIRT
> > that does not conflict with the other static mappings.
> 
> But the problem is that the ASIC address is not
> at all constant across ASIC variants. They are on different
> places in the ROM for U8500, U5500. U9540... So as described
> above we already know the main type of ASIC, but we need to
> read this value to get the subvariant, process etc.
> 
> So there is no such thing as UX500_ASICID_ADDR.
> 
> Unless we defines it with #ifdefs and compile a kernel for just
> U8500, U5500 or U9540 and that's mainly what we want to
> get away from you know...

My point was that you use the same virtual address here independent
of which physical address is used. The physical address already gets
passed into the function as its argument, we only need to map it
to a convenient place in order to read it!

	Arnd
