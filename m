From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  5 Jun 2013 08:40:04 +0200
Subject: [PATCH 0/5] Mechanism for platform-specific parsing of ATAGs
Message-ID: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Nicolas,

Following your comments on the patch that was adding the parsing of a
Marvell-specific ATAG in the generic atags_to_fdt.c, here is a new
proposal that allows this parsing to be entirely contained into code
specific to the Marvell platform.

The idea, implement in 'PATCH 2/5' is that the atags_to_fdt code
copies the ATAGs contents into the /chosen/atags DT property. This
adds 6 lines of code in atags_to_fdt.c that are completely generic,
and avoid cluttering this part of the code with platform-specific
ATAGs parsing.

Once this is in place, PATCH 5/5 modifies the Armada 370/XP specific
platform code to use this /chosen/atags DT property to find the
Marvell-specific ATAG, and assign the MAC addresses properly. In order
to assign the MAC addresses, an OF helper function
of_set_mac_address() is introduced in PATCH 3/5, and the mach-mxs code
is refactored to also use it (in PATCH 4/5).

What do you think about this approach? I believe it is much more
contained in the platform-specific code, and hopefully should address
your concerns.

Thanks!

Thomas

PS: Jason, I noticed you already merged 'ARM: mvebu: set aliases for
ethernet controllers', but I kept it here to expose the full solution.

Thomas Petazzoni (4):
  arm: preserve ATAGS in /chosen/atags in the Device Tree
  of: net: introduce a of_set_mac_address() helper function
  arm: mxs: use the newly introduced of_set_mac_address() helper
  arm: mvebu: parse ATAGS to find the network interfaces MAC addresses

Willy Tarreau (1):
  ARM: mvebu: set aliases for ethernet controllers

 arch/arm/boot/compressed/atags_to_fdt.c  |  6 ++++
 arch/arm/boot/dts/armada-370-xp.dtsi     |  9 ++++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  3 +-
 arch/arm/boot/dts/armada-xp.dtsi         |  6 +++-
 arch/arm/mach-mvebu/armada-370-xp.c      | 52 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/armada-370-xp.h      | 13 ++++++++
 arch/arm/mach-mxs/mach-mxs.c             | 22 ++------------
 drivers/of/of_net.c                      | 36 ++++++++++++++++++++++
 include/linux/of_net.h                   |  6 ++++
 9 files changed, 130 insertions(+), 23 deletions(-)

-- 
1.8.1.2
