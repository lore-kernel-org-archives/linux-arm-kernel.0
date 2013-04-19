From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Apr 2013 13:21:35 -0400
Subject: [GIT PULL V3 1/4] mvebu driver changes for v3.10
In-Reply-To: <51716CD9.4030901@free-electrons.com>
References: <20130415182824.GN28693@titan.lakedaemon.net>
 <20130416150416.GB28693@titan.lakedaemon.net>
 <20130418053002.GB12816@quad.lixom.net>
 <CAOesGMjD-VAZW-zL-jm65xSJkFLpzbYOdvN6-5pV1OW_vJDCWg@mail.gmail.com>
 <517155FE.30406@free-electrons.com>
 <51716CD9.4030901@free-electrons.com>
Message-ID: <20130419172135.GJ27197@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I have dropped:

  9ecbe03 pci: infrastructure to add drivers in drivers/pci/host

Since Gregory said they didn't need it.

thx,

Jason.

The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/drivers-3.10-2

for you to fetch changes up to a5eddfb24302b9cfb37ce5f0911f090681507fcb:

  clk: mvebu: add more PCIe clocks for Armada XP (2013-04-19 17:15:42 +0000)

----------------------------------------------------------------
mvebu drivers for v3.10 round 2

 - mvebu
    - device bus driver (Acked by gregkh to go through arm-soc)
    - PCIe prep work Acked by appropriate maintainers (of,pci,clk) for arm-soc

----------------------------------------------------------------
Andrew Murray (3):
      of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and PowerPC
      of/pci: Provide support for parsing PCI DT ranges property
      of/pci: mips: convert to common of_pci_range_parser

Ezequiel Garcia (1):
      drivers: memory: Introduce Marvell EBU Device Bus driver

Neil Greatorex (1):
      bus: mvebu-mbus: Restore checking for coherency fabric hardware

Thierry Reding (2):
      of/pci: Add of_pci_get_devfn() function
      of/pci: Add of_pci_parse_bus_range() function

Thomas Petazzoni (4):
      bus: introduce an Marvell EBU MBus driver
      bus: mvebu: fix mistake in PCIe window target attribute for Kirkwood
      clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
      clk: mvebu: add more PCIe clocks for Armada XP

 .../bindings/memory-controllers/mvebu-devbus.txt   | 156 ++++
 arch/microblaze/include/asm/pci-bridge.h           |   5 +-
 arch/microblaze/pci/pci-common.c                   | 192 -----
 arch/mips/pci/pci.c                                |  50 +-
 arch/powerpc/include/asm/pci-bridge.h              |   5 +-
 arch/powerpc/kernel/pci-common.c                   | 192 -----
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/mvebu-mbus.c                           | 870 +++++++++++++++++++++
 drivers/clk/mvebu/clk-gating-ctrl.c                |  18 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mvebu-devbus.c                      | 340 ++++++++
 drivers/of/address.c                               |  67 ++
 drivers/of/of_pci.c                                | 228 +++++-
 include/linux/mbus.h                               |  24 +-
 include/linux/of_address.h                         |  46 ++
 include/linux/of_pci.h                             |   6 +
 18 files changed, 1780 insertions(+), 438 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
 create mode 100644 drivers/bus/mvebu-mbus.c
 create mode 100644 drivers/memory/mvebu-devbus.c




On Fri, Apr 19, 2013 at 06:12:09PM +0200, Gregory CLEMENT wrote:
> On 04/19/2013 04:34 PM, Gregory CLEMENT wrote:
> > On 04/19/2013 04:09 PM, Olof Johansson wrote:
> >> On Wed, Apr 17, 2013 at 10:30 PM, Olof Johansson <olof@lixom.net> wrote:
> >>> On Tue, Apr 16, 2013 at 11:04:16AM -0400, Jason Cooper wrote:
> >>>>
> >>>> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
> >>>>
> >>>>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
> >>>>
> >>>> are available in the git repository at:
> >>>>
> >>>>   git://git.infradead.org/users/jcooper/linux.git tags/drivers-3.10-2
> >>>>
> >>>> for you to fetch changes up to ac7b07ec369324063e52c37b3fb0ad1a1814d879:
> >>>>
> >>>>   clk: mvebu: add more PCIe clocks for Armada XP (2013-04-16 14:47:01 +0000)
> >>>
> >>> Pulled, thanks.
> >>
> >> Dropped due to build errors on powerpc64. 3.11 material now.
> >>
> > 
> > Wait! That means dropping _all_ the change done in mvebu for 3.10 just
> > for one patch in the of/pci part?
> > 
> > Jason, did you take the accurate patch? Because according to Grant
> > Likely, the build didn't fail on ppc, see:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg238517.html
> 
> I investigated it a little more and my first assumption was wrong,
> the faulty commit was not the one I think. I didn't work directly
> on the PCIe part, and Thomas who did it is currently in the plane.
> 
> So instead of throwing everything, could you just remove the
> offending commit, AFAIK we don't need it yet, (the patch
> depending of this one are located in the mvebu-late/pcie branch):
> 
> 9ecbe03 pci: infrastructure to add drivers in drivers/pci/host
> 
> Thanks!
> 
> > 
> > 
> >>
> >> -Olof
> >>
> > 
> > 
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
