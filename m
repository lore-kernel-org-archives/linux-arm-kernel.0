From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Oct 2012 18:17:26 -0500
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <507EDB37.1060102@wwwdotorg.org>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
Message-ID: <507F3C86.8040800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2012 11:22 AM, Stephen Warren wrote:
> On 10/17/2012 08:38 AM, Rob Herring wrote:
>> On 10/15/2012 02:07 PM, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> Move Tegra's debug-macro.S over to the common debug macro directory.
>>>
>>> Move Tegra's debug UART selection menu into ARM's Kconfig.debug, so that
>>> all related options are selected in the same place.
>>>
>>> Tegra's uncompress.h is left in mach-tegra/include/mach; it will be
>>> removed whenever Tegra is converted to multi-platform.
>>>
>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>> ---
>>> Rob, Arnd, Olof, I'd particularly like feedback on whether the following:
>>>
>>> #include "../../mach-tegra/iomap.h"
>>>
>>> in arch/arm/include/debug/tegra.S is acceptable. I'd really like to
>>> continue to #include a header to share the defines to Tegra physical
>>> memory layout and virtual based addresses with Tegra's io.c's struct
>>> map_desc entries, so they can't get out of sync. So, the include can
>>> either use the relative path as quoted above (which I don't think will
>>> cause any significant maintenance issue), or Tegra's iomap.h would have
>>> to be moved somewhere public so e.g. <tegra-iomap.h> could be included.
>>
>> We already have a way to get the phys and virt addresses at runtime with
>> addruart macro.
> 
> So this discussion is mainly about the implementation of addruart.
> 
>> Couldn't we wrap this with a proper function and setup
>> the mapping at runtime. This would move it out of the platforms.
> 
> So, the mapping already is set up at run-time at least during early
> boot; __create_page_tables() in arch/arm/kernel/head.S calls addruart
> and sets up an entry for it.
> 
> I suppose the implication here is that the virtual address that addruart
> returns doesn't have to match anything that the machine later sets up
> using iotable_init().
> 
> If that's true, then Tegra's debug-macro.S only needs to know the UART
> physical address, and can make up almost any arbitrary virtual address
> (perhaps even driven by the logic you mention in your next paragraph
> below) and hence need not rely on Tegra's iomap.h. That said, we'd still
> have to manually remember not to create conflicting virtual address
> setups in the two places, which would still be easier with a shared header.

The virtual address has to remain the same.

A non-platform specific header for a fixed virtual address define would
be cleaner than relative includes.

> 
> However, I then have two questions:
> 
> 1) How long do the page tables set up by __create_page_tables() last; do
> they stick around forever, or at least as long as the macros from
> debug-macro.S are used, or are they replaced sometime, on the assumption
> that the machine's .map_io() will call iotable_init() and end up setting
> up the same mapping?

It works to...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.5.4+ (rob at rob-laptop) (gcc version 4.7.2
(Ubuntu/Linaro 4.7.2-1ubuntu1) ) #280 SMP Wed Oct 17 18:00:29 CDT 2012 ()
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: Highbank, model: Calxeda Highbank
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: CMA: reserved 16 MiB at 2e800000
[    0.000000] Memory policy: ECC disabled, Data cache writealloc

...here with no iotable mapping.

> 
> 2) If the virtual address returned by addruart on Tegra is different
> than any virtual addresses set up by Tegra's .map_io(), and Tegra's
> .map_io() sets up a very broad mapping that covers all peripherals
> including the UART, and hence the UART physical registers get mapped
> into two virtual addresses, will this cause any problems? IIRC,
> duplicate mappings can cause some issues on ARM, but perhaps that only
> applies to memory-like mappings, and not completely uncached IO mappings?

The virt address has to match. It can initially be a 1MB section and
then replaced with a 4K entry, but the same DEBUG_LL macros are used
throughout the boot process as the mapping is updated.

Duplicate mappings of different memory types is the problem. Multiple
mapping of the same type are fine and common (the zero page for example).

Rob
