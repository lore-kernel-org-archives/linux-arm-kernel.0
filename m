From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Oct 2011 18:05:50 -0700
Subject: [GIT PULL] initial omap DT support for v3.2 merge window (Re:
	[PATCH 26/30] ARM: omap: add board autoselection)
In-Reply-To: <2340307.S2RzXdHlIz@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<201110040944.13205.arnd@arndb.de>
	<20111004155752.GT6324@atomide.com> <2340307.S2RzXdHlIz@wuerfel>
Message-ID: <20111005010550.GX6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [111004 11:55]:
> On Tuesday 04 October 2011 08:57:52 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [111004 00:10]:
> > > On Monday 03 October 2011, Tony Lindgren wrote:
> > >
> > > > Yes please leave out the list so we don't need to constantly update it.
> > > > Let's just always build in MACH_OMAP_GENERIC.
> > > 
> > > That's what I had initially, but now that board file has become
> > > omap2-specific and no longer works on omap3-only or omap4-only
> > > configurations.
> > 
> > Will send a pull request for basic DT bootstrap support from Benoit
> > that fixes that. So maybe let's sort that out first, then always
> > select it?
> 
> Yes, sounds good. That is certainly the better solution in the long run.

Here you are. We had to rebase it earlier today because of the
SOB update in fixes branch for the musb related fix that's needed
here to avoid a merge conflict.

This series pretty much depends and conflicts with all the ealier
branches, so I created a new dt-base branch to deal with the merge
conflicts. If you prefer some other base, please let me know.

If you prefer to build some other merge base yourself, see the
attached patch that's needed to avoid two build warnings after
merging the various base branches together.

The dt-base I did is a merge of cleanup-part3, voltage, dmtimer
and l3 into fixes. You may not yet have l3 and fixes pulled in,
I sent pull requests for those yesterday. The others you have
already pulled I believe.

Despite using the merge base this will cause a minor merge conflict
in board-generic.c with Nicolas Pitre's earlier patch titled
"ARM: mach-omap2: convert boot_params to atag_offset". The 
atag_offset can be just left out, as the default will work.

Regards,

Tony


The following changes since commit c541c15fb5ab48c47bc9b90121538fd30d152f23:
  Tony Lindgren (1):
        Merge branches 'cleanup-part3', 'voltage', 'dmtimer' and 'l3' into dt-base

are available in the git repository at:

  git://github.com/tmlind/linux.git dt

Benoit Cousson (18):
      ARM: OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
      ARM: OMAP2+: pm: Use hwmod name instead of dev pointer
      ARM: OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
      ARM: OMAP: omap_device: Create a default omap_device_pm_latency
      ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
      of: Add helpers to get one string in multiple strings property
      ARM: OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
      ARM: OMAP: omap_device: Add a method to build an omap_device from a DT node
      arm/dts: Add initial device tree support for OMAP4 SoC
      arm/dts: Add support for OMAP4 PandaBoard
      arm/dts: Add support for OMAP4 SDP board
      arm/dts: Add initial device tree support for OMAP3 SoC
      arm/dts: Add support for OMAP3 Beagle board
      ARM: OMAP2+: board-generic: Add DT support to generic board
      ARM: OMAP2+: board-generic: Add i2c static init
      ARM: OMAP2+: l3-noc: Add support for device-tree
      arm/dts: OMAP4: Add a main ocp entry bound to l3-noc driver
      arm/dts: OMAP3+: Add mpu, dsp and iva nodes

Nishanth Menon (1):
      ARM: OMAP: omap_device: Add omap_device_get_by_hwmod_name

Tony Lindgren (1):
      Merge branch 'for_3.2/3_omap_devicetree' of git://gitorious.org/omap-pm/linux into dt

 Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 +
 Documentation/devicetree/bindings/arm/omap/iva.txt |   19 ++
 .../devicetree/bindings/arm/omap/l3-noc.txt        |   19 ++
 Documentation/devicetree/bindings/arm/omap/mpu.txt |   27 ++
 .../devicetree/bindings/arm/omap/omap.txt          |   43 +++
 arch/arm/boot/dts/omap3-beagle.dts                 |   29 ++
 arch/arm/boot/dts/omap3.dtsi                       |   63 ++++
 arch/arm/boot/dts/omap4-panda.dts                  |   29 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |   29 ++
 arch/arm/boot/dts/omap4.dtsi                       |  103 +++++++
 arch/arm/mach-omap2/Kconfig                        |    8 +-
 arch/arm/mach-omap2/board-generic.c                |  156 ++++++++---
 arch/arm/mach-omap2/board-omap3beagle.c            |    4 +-
 arch/arm/mach-omap2/devices.c                      |   51 +---
 arch/arm/mach-omap2/display.c                      |   11 +-
 arch/arm/mach-omap2/dma.c                          |   11 +-
 arch/arm/mach-omap2/gpio.c                         |   12 +-
 arch/arm/mach-omap2/hsmmc.c                        |   18 +-
 arch/arm/mach-omap2/hwspinlock.c                   |   12 +-
 arch/arm/mach-omap2/mcbsp.c                        |   11 +-
 arch/arm/mach-omap2/omap_l3_noc.c                  |   25 ++-
 arch/arm/mach-omap2/pm.c                           |   72 ++---
 arch/arm/mach-omap2/serial.c                       |   25 +--
 arch/arm/mach-omap2/sr_device.c                    |   11 +-
 arch/arm/mach-omap2/usb-musb.c                     |   11 +-
 arch/arm/plat-omap/i2c.c                           |   10 +-
 arch/arm/plat-omap/include/plat/omap_device.h      |    1 +
 arch/arm/plat-omap/omap_device.c                   |  313 +++++++++++++++++---
 drivers/of/base.c                                  |   84 ++++++
 include/linux/of.h                                 |   18 ++
 30 files changed, 929 insertions(+), 310 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.txt
 create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
 create mode 100644 arch/arm/boot/dts/omap3.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-panda.dts
 create mode 100644 arch/arm/boot/dts/omap4-sdp.dts
 create mode 100644 arch/arm/boot/dts/omap4.dtsi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: merge.patch
Type: text/x-diff
Size: 2136 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111004/30d6c319/attachment-0001.bin>
