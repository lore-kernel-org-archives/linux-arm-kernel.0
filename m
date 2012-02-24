From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Feb 2012 16:39:40 +0100
Subject: [GIT PULL] ux500 patches for v3.4
In-Reply-To: <201202241523.18355.arnd@arndb.de>
References: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
 <201202211700.39669.arnd@arndb.de>
 <CACRpkdZywv-Exu0=-fvuNFnuBGRXKZCPFXUW7movcoeUn+1=6A@mail.gmail.com>
 <201202241523.18355.arnd@arndb.de>
Message-ID: <CACRpkdZfkcAD2WqOCcDfSbiiBJxEvic5QmyzpyvUfHX39cDf9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 4:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 February 2012, Linus Walleij wrote:
>> On Tue, Feb 21, 2012 at 6:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> > * The handling of the DB9540_ROM adds a number of special cases,
>> > but in the end it looks like this is not used anywhere, so I'd
>> > recomment just removing it. If you get something that needs the
>> > ROM to be mapped, just make that use ioremap.
>>
>> It is used to read out the ASIC ID, like this:
>>
>> +static unsigned int u9540_read_asicid(phys_addr_t addr)
>> +{
>> + ? ? ? phys_addr_t base = addr & ~0xfff;
>> + ? ? ? struct map_desc desc = {
>> + ? ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS_DB9540_ROM(base),
>> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(base),
>> + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_16K,
>> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? ? };
>> +
>> + ? ? ? iotable_init(&desc, 1);
>> +
>> + ? ? ? /* As in devicemaps_init() */
>> + ? ? ? local_flush_tlb_all();
>> + ? ? ? flush_cache_all();
>> +
>> + ? ? ? return readl(__io_address_db9540_rom(addr));
>> +}
>
> Do I understand this correctly that there is a new chip that
> is almost the same as the old one, but the main difference is
> location of the register that tells us which one it is? ;-)

Not quite, we already know which main variant it is at this point,
but reading this register tells us the sub-variant. They are
numbered ED (early drop), v1, v2, etc. This location also tells
the manufacturing process and that other stuff that Lee
recently added to the sysfs files in the SoC bus.

> How about hardcoding the virtual address for the id register so
> that you can actually use the same function:?
>
> static unsigned int ux500_read_asicid(phys_addr_t addr)
> {
> ? ? ? ?phys_addr_t base = addr & ~PAGE_MASK;
> ? ? ? ?unsigned long offset = addr & PAGE_MASK;
>
> ? ? ? ?struct map_desc desc = {
> ? ? ? ? ? ? ? ?.virtual ? ? ? ?= (unsigned long)UX500_ASICID_ADDR,
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(base),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_4K,
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE,
> ? ? ? ?};
>
> ? ? ? ?iotable_init(&desc, 1);
>
> ? ? ? ?/* As in devicemaps_init() */
> ? ? ? ?local_flush_tlb_all();
> ? ? ? ?flush_cache_all();
>
> ? ? ? ?return readl(UX500_ASICID_ADDR + offset);
> }
>
> Then you just need to find a convenient value for UX500_ASICID_VIRT
> that does not conflict with the other static mappings.

But the problem is that the ASIC address is not
at all constant across ASIC variants. They are on different
places in the ROM for U8500, U5500. U9540... So as described
above we already know the main type of ASIC, but we need to
read this value to get the subvariant, process etc.

So there is no such thing as UX500_ASICID_ADDR.

Unless we defines it with #ifdefs and compile a kernel for just
U8500, U5500 or U9540 and that's mainly what we want to
get away from you know...

Yours,
Linus Walleij
