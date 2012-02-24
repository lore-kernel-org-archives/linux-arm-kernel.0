From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Feb 2012 07:51:02 +0100
Subject: [GIT PULL] ux500 patches for v3.4
In-Reply-To: <201202211700.39669.arnd@arndb.de>
References: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
 <201202211700.39669.arnd@arndb.de>
Message-ID: <CACRpkdZywv-Exu0=-fvuNFnuBGRXKZCPFXUW7movcoeUn+1=6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 6:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Most of the patches look ok, but since this about a new SoC,
> I decided to take a much closer look and found a few issues that
> I think you can still fix:

Actually it's a sibling to U8500 more than a completely new one, an
incremental step.

> * The handling of the DB9540_ROM adds a number of special cases,
> but in the end it looks like this is not used anywhere, so I'd
> recomment just removing it. If you get something that needs the
> ROM to be mapped, just make that use ioremap.

It is used to read out the ASIC ID, like this:

+static unsigned int u9540_read_asicid(phys_addr_t addr)
+{
+       phys_addr_t base = addr & ~0xfff;
+       struct map_desc desc = {
+               .virtual        = IO_ADDRESS_DB9540_ROM(base),
+               .pfn            = __phys_to_pfn(base),
+               .length         = SZ_16K,
+               .type           = MT_DEVICE,
+       };
+
+       iotable_init(&desc, 1);
+
+       /* As in devicemaps_init() */
+       local_flush_tlb_all();
+       flush_cache_all();
+
+       return readl(__io_address_db9540_rom(addr));
+}

Notice that ioremap() cannot be used here since it is used at
arch init time (as was discussed a while back with Nicolas
I think). Most platforms need to use an approach like this
to get chip ID:s at early init time.

The read-out ASIC ID is then used for the cpu_is_u9540() function
which is then used for the cpu_is_u8500_family()  to ensure that
the same codepath is used for the entire family.

So if I remove this part the support patch is moot.

> * You add a new irqs-db9540.h file, but the macros defined in there
> are not actually used. Better not add that file then, especially
> since the interrupt definitions will soon all move into device
> tree for ux500.

OK that's true, I've deleted it and will respin a v2 without
the IRQ file, then iterate the pull request.

> * I assume that we will need to add a few changes to make this
> actually work together with Lee's series.

It actually works just fine. I just merged this patchset into
next-20120224, compiled and booted, it JustWorks(TM) because the
changes are strangely enough orthogonal.

> I would suggest that
> I put your series into the next/soc branch and merge it into
> the next/soc2 branch as well, which already has his patches.
> Then you can add a patch on top that adds the necessary changes,
> if any.

Hm, not quite following but I think it will just work :-)

Yours,
Linus Walleij
