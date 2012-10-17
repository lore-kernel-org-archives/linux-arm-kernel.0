From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Oct 2012 15:12:17 -0600
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <507EDB37.1060102@wwwdotorg.org>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
Message-ID: <507F1F31.2060503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2012 10:22 AM, Stephen Warren wrote:
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
> 
> However, I then have two questions:
> 
> 1) How long do the page tables set up by __create_page_tables() last; do
> they stick around forever, or at least as long as the macros from
> debug-macro.S are used, or are they replaced sometime, on the assumption
> that the machine's .map_io() will call iotable_init() and end up setting
> up the same mapping?

So answering my own question here after testing this:

If I use a different (to iomap.h) virtual address in debug-macro.S, then
the very very early output from earlyprintk does work:

> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.7.0-rc1-next-20121016-...
> [    0.000000] CPU: ARMv7 Processor [411fc090] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: nVidia Tegra20 (Flattened Device Tree), model: NVIDIA Tegra2 Harmony evaluation board
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writealloc

However, the kernel either hangs or output simply stops working at that
point. If I modify Tegra's iotable_init() call to add an entry to map
the UART to the virtual address debug-macro.S assumes, then everything
works again.

That implies we really do need to keep the two pieces of code completely
in sync, so a shared header is the right way to go. It also implies that
having duplicate mappings of the same physical address doesn't cause any
immediate obvious catastrophic problems.

Ways we might avoid files in arch/arm/include/debug having to use
relative include paths to pick up that header are:

a) Move mach-${mach}/include/mach/iomap.h to iomap-${mach}.h in some
standard include path.

b) Rework debug-macro.S so that it isn't an include file, but rather a
regular top-level file. In other words, rather than compiling
arch/arm/kernel/debug.S, and having that #include DEBUG_LL_INCLUDE,
instead compile DEBUG_LL_SOURCE (i.e. arch/arm/mach-${mach}/debug.S by
default), and have that #include any common parts (e.g. implementation
of printhex8). This has benefits of:

b1) arch/arm/mach-${mach}/debug.S is in the mach directory that owns it,
rather than having them all dumped into a common location.

b2) Can use #include "iomap.h", a non-relative include, to pick up the
shared header

b3) Perhaps we can simplify the current debug.S e.g. have a common
debug-semihosting.S that contains the semihosting stuff, and only
include that from mach-*/debug.S if that machine uses semihosting, or
similar?

(b) seems like a lot of work. I don't see any advantage of (a) over just
using the relative include.
