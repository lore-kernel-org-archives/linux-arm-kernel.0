From: dja@axtens.net (Daniel Axtens)
Date: Fri,  4 Aug 2017 20:20:30 +1000
Subject: [PATCH 0/3] Split VGA default selection from VGA arbiter
Message-ID: <20170804102033.27731-1-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is approach 3 of my patch series to sort out Xorg
autoconfiguration for the Hibmc card beind a Hisilicon bridge on
arm64.

Approach 1 was a simple quirk for the card+bridge to mark it as
default. This higlighted the fact that the default card was picked by
the arbiter, which assumed legacy resources. The lack of legacy
resources leads to quirks in ppc and concerns in arm land, so a more
generic approach was desired.

Approach 2 allowed platforms to opt in to a class enable hook that
added a card as default if there was no default. This:

 - was possibly racy as ACPI PCI init and vgaarb are both subsys
   initcalls.

 - didn't check to see if a card had a driver.

 - meant that platforms for which the vga arbiter didn't make sense
   still needed it.

This is approach 3. It pulls the default handling out of the arbiter,
into its own file and behind its own Kconfig option. It adds the extra
detection as a late initcall and an enable hook that only operates
after the initcall, so it's not racy. It checks for drivers. It means
people can turn off the vga arbiter. It works sensibly for modules
too.

Patch 1 cleans up the powerpc fixup, as with approach 2.
Patch 2 is the big split.
Patch 3 moves ppc over, as with approach 2.
There is no need for an arm-specific patch this time as the Kconfig option
is on by default.

Regards,
Daniel

Daniel Axtens (3):
  powerpc: simplify and fix VGA default device behaviour
  Split VGA default device handler out of VGA arbiter
  powerpc: replace vga_fixup() with generic code

 arch/ia64/pci/fixup.c            |   2 +-
 arch/powerpc/kernel/pci-common.c |  13 ----
 arch/x86/pci/fixup.c             |   2 +-
 arch/x86/video/fbdev.c           |   2 +-
 drivers/gpu/vga/Kconfig          |  12 +++
 drivers/gpu/vga/Makefile         |   1 +
 drivers/gpu/vga/vga_default.c    | 159 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/vga/vga_switcheroo.c |   2 +-
 drivers/gpu/vga/vgaarb.c         |  41 +---------
 drivers/pci/pci-sysfs.c          |   2 +-
 include/linux/vga_default.h      |  44 +++++++++++
 include/linux/vgaarb.h           |  14 ----
 12 files changed, 224 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/vga/vga_default.c
 create mode 100644 include/linux/vga_default.h

-- 
2.11.0
