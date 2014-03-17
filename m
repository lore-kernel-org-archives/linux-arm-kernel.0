From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 00:13:02 +0000
Subject: [PATCH 00/44] outer cache changes
Message-ID: <20140317001302.GY21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is where I'm currently at with the total mess which
is L2 cache support.  That's putting it mildly.  This isn't intended
for anyone to pick up - this is still mostly in development.

I need help with the Aurora/Tauros3/Broadcom stuff, as that remains
addicted to the old buggy code that we used to have (eg, if you build
a v6+v7 kernel, all PL310 errata get disabled.  If CONFIG_CACHE_PL310
is enabled and you actually have a L2C-220, the necessary waits will
be omitted.  If you enable erratum 588369 and set the .set_debug
method to NULL or have a PL310 later than R3P0, you're opening a
race condition. etc.)

One of the potentially explosive issues is the utter crap and fscked
state of DT implementation here, much of which /can't/ now be fixed
without breaking existing DT based booting with existing files,
because we have a mixture of DT properties combined with platform
specific code setting various L2C configuration parameters (sometimes
writing directly to the registers.)

For example, I've made a start at trying to prevent any further additions
of platform code writing to the L2C-310's power control register by
adding a couple of properties - but we can't delete the direct register
write in iMX6 code without breaking existing DT descriptions.

The same goes for the mess which is the auxillary control register,
or now the prefetch control register.  Or the erratum 752271 which
iMX6 implements in their own SoC specific code.

Here's the *big* explosive question: how have we ended up in this mess?
A bigger question: why was none of this caught at review time?  An even
bigger question (which I believe is at the root of much of the pain that
people feel with DT): why aren't device properties being thought out
better - by that I mean, why isn't the question "are the properties you
are proposing for device X sufficient to describe all it's configurable
parameters, and if not, what are you omitting?" being asked when new
device bindings are being proposed.

You can see the extent of the L2C crap from the diffstat below - every
arch/arm/mach-* file touched here is a symptom of failing to adequately
describe the properties that platforms need to specify.  It's a failing
of DT process.  It's a failing of review of SoC code.

Anyway, here's the diffstat so far.  Not Cc'ing anyone this time around
(the Cc list is huge), so it's all on LAKML.

 Documentation/devicetree/bindings/arm/l2cc.txt |    2 +
 arch/arm/Kconfig                               |   51 -
 arch/arm/boot/dts/imx6qdl.dtsi                 |    2 +
 arch/arm/boot/dts/imx6sl.dtsi                  |    2 +
 arch/arm/include/asm/hardware/cache-l2x0.h     |   63 +-
 arch/arm/include/asm/outercache.h              |   67 +-
 arch/arm/mach-cns3xxx/core.c                   |    8 +-
 arch/arm/mach-highbank/highbank.c              |   12 +-
 arch/arm/mach-imx/system.c                     |    8 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c      |    2 +-
 arch/arm/mach-omap2/omap4-common.c             |   58 +-
 arch/arm/mach-prima2/l2x0.c                    |    5 +-
 arch/arm/mach-prima2/pm.c                      |    1 -
 arch/arm/mach-realview/realview_pbx.c          |    4 +-
 arch/arm/mach-spear/platsmp.c                  |   19 +-
 arch/arm/mach-spear/spear13xx.c                |    6 +-
 arch/arm/mach-sti/board-dt.c                   |    8 +-
 arch/arm/mach-tegra/sleep.h                    |    8 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   23 +-
 arch/arm/mach-vexpress/ct-ca9x4.c              |    4 +-
 arch/arm/mm/Kconfig                            |   51 +
 arch/arm/mm/Makefile                           |    1 +
 arch/arm/mm/cache-feroceon-l2.c                |    1 -
 arch/arm/mm/cache-l2x0.c                       | 1354 +++++++++++++++++-------
 arch/arm/mm/l2c-common.c                       |   20 +
 arch/arm/plat-samsung/s5p-sleep.S              |    8 +-
 26 files changed, 1221 insertions(+), 567 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
