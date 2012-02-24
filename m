From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2012 15:23:18 +0000
Subject: [GIT PULL] ux500 patches for v3.4
In-Reply-To: <CACRpkdZywv-Exu0=-fvuNFnuBGRXKZCPFXUW7movcoeUn+1=6A@mail.gmail.com>
References: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
 <201202211700.39669.arnd@arndb.de>
 <CACRpkdZywv-Exu0=-fvuNFnuBGRXKZCPFXUW7movcoeUn+1=6A@mail.gmail.com>
Message-ID: <201202241523.18355.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 February 2012, Linus Walleij wrote:
> On Tue, Feb 21, 2012 at 6:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > * The handling of the DB9540_ROM adds a number of special cases,
> > but in the end it looks like this is not used anywhere, so I'd
> > recomment just removing it. If you get something that needs the
> > ROM to be mapped, just make that use ioremap.
> 
> It is used to read out the ASIC ID, like this:
> 
> +static unsigned int u9540_read_asicid(phys_addr_t addr)
> +{
> +       phys_addr_t base = addr & ~0xfff;
> +       struct map_desc desc = {
> +               .virtual        = IO_ADDRESS_DB9540_ROM(base),
> +               .pfn            = __phys_to_pfn(base),
> +               .length         = SZ_16K,
> +               .type           = MT_DEVICE,
> +       };
> +
> +       iotable_init(&desc, 1);
> +
> +       /* As in devicemaps_init() */
> +       local_flush_tlb_all();
> +       flush_cache_all();
> +
> +       return readl(__io_address_db9540_rom(addr));
> +}

Do I understand this correctly that there is a new chip that
is almost the same as the old one, but the main difference is
location of the register that tells us which one it is? ;-)

> Notice that ioremap() cannot be used here since it is used at
> arch init time (as was discussed a while back with Nicolas
> I think). Most platforms need to use an approach like this
> to get chip ID:s at early init time.
> 
> The read-out ASIC ID is then used for the cpu_is_u9540() function
> which is then used for the cpu_is_u8500_family()  to ensure that
> the same codepath is used for the entire family.
> 
> So if I remove this part the support patch is moot.

Ok, I see.

How about hardcoding the virtual address for the id register so
that you can actually use the same function:?

static unsigned int ux500_read_asicid(phys_addr_t addr)
{
        phys_addr_t base = addr & ~PAGE_MASK;
	unsigned long offset = addr & PAGE_MASK;

        struct map_desc desc = {
                .virtual        = (unsigned long)UX500_ASICID_ADDR,
                .pfn            = __phys_to_pfn(base),
                .length         = SZ_4K,
                .type           = MT_DEVICE,
        };

        iotable_init(&desc, 1);

        /* As in devicemaps_init() */
        local_flush_tlb_all();
        flush_cache_all();

        return readl(UX500_ASICID_ADDR + offset);
}       

Then you just need to find a convenient value for UX500_ASICID_VIRT
that does not conflict with the other static mappings.

> > * I assume that we will need to add a few changes to make this
> > actually work together with Lee's series.
> 
> It actually works just fine. I just merged this patchset into
> next-20120224, compiled and booted, it JustWorks(TM) because the
> changes are strangely enough orthogonal.

Ok, good.

	Arnd
