From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Apr 2012 11:16:26 +0100
Subject: [PATCH 0/8] ARM PCI cleanups
Message-ID: <20120426101626.GE24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set cleans up some of the ARM PCI support code, mostly
targetting the way the swizzling works.

We used to interpret a NULL swizzle method as meaning "no swizzling".
However, the common case is to use the standard PCI swizzle function.
Lets instead make the default swizzle method (i.e. NULL) mean the PCI
swizzle function, and those cases which really do want no swizzling
have to provide their own function.

Arguably, the 'no swizzle' case is wrong, because the swizzle is there
to deal with PCI cards which themselves have PCI-to-PCI bridges on, and
these won't work without this support.

We also provide sys->private_data for platforms to use.  Some PCIe
support code ignored this and used all kinds of horrid tricks to get
at their private data.  This patch set switches them to use this private
data pointer instead, as they should have done in the first place.

Finally, we provide a standard bus scanning method, with the PCI
configuration ops via our sysdata instead of having every platform
provide a function where the only difference is the 'ops' pointer
provided to pci_scan_root_bus().

While I realize that some platforms touched by this set are going to
be removed, that removal is not in my tree, and avoiding this will
cause those platforms to break.  So they're included in these updates
at the moment.

 arch/arm/common/it8152.c                       |    7 +----
 arch/arm/common/via82c505.c                    |   11 +------
 arch/arm/include/asm/hardware/it8152.h         |    2 +-
 arch/arm/include/asm/mach/pci.h                |   17 ++++-------
 arch/arm/kernel/bios32.c                       |   37 ++++++++++++++++-------
 arch/arm/mach-cns3xxx/pcie.c                   |   12 +------
 arch/arm/mach-dove/pcie.c                      |   24 ++++-----------
 arch/arm/mach-footbridge/cats-pci.c            |    9 ++++-
 arch/arm/mach-footbridge/dc21285.c             |    7 +----
 arch/arm/mach-footbridge/ebsa285-pci.c         |    3 +-
 arch/arm/mach-footbridge/netwinder-pci.c       |    3 +-
 arch/arm/mach-footbridge/personal-pci.c        |    2 +-
 arch/arm/mach-integrator/pci.c                 |   19 ++---------
 arch/arm/mach-integrator/pci_v3.c              |    8 +----
 arch/arm/mach-iop13xx/iq81340mc.c              |    1 -
 arch/arm/mach-iop13xx/iq81340sc.c              |    1 -
 arch/arm/mach-iop32x/em7210.c                  |    3 +-
 arch/arm/mach-iop32x/glantank.c                |    3 +-
 arch/arm/mach-iop32x/iq31244.c                 |    6 +--
 arch/arm/mach-iop32x/iq80321.c                 |    3 +-
 arch/arm/mach-iop32x/n2100.c                   |    3 +-
 arch/arm/mach-iop33x/iq80331.c                 |    3 +-
 arch/arm/mach-iop33x/iq80332.c                 |    3 +-
 arch/arm/mach-ixp2000/enp2611.c                |    9 +-----
 arch/arm/mach-ixp2000/include/mach/platform.h  |    2 +-
 arch/arm/mach-ixp2000/ixdp2400.c               |    2 +-
 arch/arm/mach-ixp2000/ixdp2800.c               |    2 +-
 arch/arm/mach-ixp2000/ixdp2x01.c               |    2 +-
 arch/arm/mach-ixp2000/pci.c                    |    8 +----
 arch/arm/mach-ixp23xx/include/mach/platform.h  |    2 +-
 arch/arm/mach-ixp23xx/ixdp2351.c               |    2 +-
 arch/arm/mach-ixp23xx/pci.c                    |    6 ----
 arch/arm/mach-ixp23xx/roadrunner.c             |    2 +-
 arch/arm/mach-ixp4xx/avila-pci.c               |    3 +-
 arch/arm/mach-ixp4xx/common-pci.c              |    6 ----
 arch/arm/mach-ixp4xx/coyote-pci.c              |    3 +-
 arch/arm/mach-ixp4xx/dsmg600-pci.c             |    3 +-
 arch/arm/mach-ixp4xx/fsg-pci.c                 |    3 +-
 arch/arm/mach-ixp4xx/gateway7001-pci.c         |    3 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c              |    3 +-
 arch/arm/mach-ixp4xx/gtwx5715-pci.c            |    3 +-
 arch/arm/mach-ixp4xx/include/mach/platform.h   |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-pci.c             |    3 +-
 arch/arm/mach-ixp4xx/ixdpg425-pci.c            |    3 +-
 arch/arm/mach-ixp4xx/miccpt-pci.c              |    3 +-
 arch/arm/mach-ixp4xx/nas100d-pci.c             |    3 +-
 arch/arm/mach-ixp4xx/nslu2-pci.c               |    3 +-
 arch/arm/mach-ixp4xx/vulcan-pci.c              |    3 +-
 arch/arm/mach-ixp4xx/wg302v2-pci.c             |    3 +-
 arch/arm/mach-kirkwood/pcie.c                  |   16 ++++------
 arch/arm/mach-ks8695/pci.c                     |    9 +-----
 arch/arm/mach-mv78xx0/pcie.c                   |   24 ++++-----------
 arch/arm/mach-orion5x/db88f5281-setup.c        |    1 -
 arch/arm/mach-orion5x/dns323-setup.c           |    1 -
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |    1 -
 arch/arm/mach-orion5x/mss2-setup.c             |    1 -
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    1 -
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    1 -
 arch/arm/mach-orion5x/rd88f5182-setup.c        |    1 -
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    1 -
 arch/arm/mach-orion5x/terastation_pro2-setup.c |    1 -
 arch/arm/mach-orion5x/ts209-setup.c            |    1 -
 arch/arm/mach-orion5x/ts409-setup.c            |    1 -
 arch/arm/mach-orion5x/wnr854t-setup.c          |    1 -
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    1 -
 arch/arm/mach-pxa/cm-x2xx-pci.c                |    3 +-
 arch/arm/mach-sa1100/pci-nanoengine.c          |    8 +----
 arch/arm/mach-shark/pci.c                      |    3 +-
 arch/arm/mach-tegra/pcie.c                     |    1 -
 arch/arm/mach-versatile/pci.c                  |   13 +-------
 arch/arm/plat-iop/pci.c                        |    8 +----
 71 files changed, 112 insertions(+), 260 deletions(-)
