From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:46:58 +0200
Subject: [PATCH v3 00/10] ARM: mvebu: Hardware coherency support for Armada
 375 and 38x
Message-ID: <1397483228-25625-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Gregory, Andrew, Sebastian,

This set of patches add hardware coherency support for the new Armada
375 and Armada 38x SoCs.

Changes since v2:

 * Rebased on top of v3.15-rc1. From my side, the patches are ready to
   apply, so unless comments are made, I will not resend another
   version.

Changes since v1:

 * Rebased on top of current linux-next, and therefore updated to take
   into account the changes in mach-mvebu, such as Kirkwood/Dove
   integration. A new version will be sent as soon as 3.15-rc1 is
   released.

 * Removed a debugging message from coherency_type() which was being
   displayed every time this function was called, to say "Initializing
   coherency fabric", which was incorrect.

 * Delay the initialization of the XOR-based coherency workaround for
   Armada 375 into the postcore_initcall(), before the bus notifier
   gets registered. This solves two problems: 1/ the
   of_update_property() cannot be done as early as it could be done in
   earlier kernels, and 2/ it avoids having to initialize the MBus
   driver before the coherency fabric.

 * Added a warning message when the XOR-based coherency workaround for
   Armada 375 is enabled, so that the user at least has a trace in the
   kernel logs explaining why a XOR engine is not available.

The patches can also be grabbed from:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/3.15-mvebu/coherency

The patch set can be divided in three sections:

 * Patches 1, 2, 3 and 4 prepare the introduction of the support for
   new SoC in the existing coherency code.

   The main change is that the mvebu-mbus driver no longer pokes into
   the Device Tree to find whether hardware I/O coherency is available
   or not: this information is passed as argument to the mvebu-mbus
   initialization function. This avoids changing the mvebu-mbus driver
   to add the compatible strings of all possible coherency fabrics,
   and also avoids encoding specific conditions in the mvebu-mbus
   driver: on Armada 375 and 38x, the hardware I/O coherency can only
   be enabled in SMP mode.

   These preparation patches had already been sent in the past
   (http://permalink.gmane.org/gmane.linux.ports.arm.kernel/290780). This
   round has taken into account the comments I had received on this
   early version.

 * Patches 5, 6, 7 and 8 add the coherency support itself. Patch 4
   enables the SCU, patch 5 adds I/O coherency support for 375, patch
   6 adds a major workaround to make coherency support actually work
   on early 375 SOCs and patch 7 adds I/O coherency support for 38x.

 * Patches 9 and 10 add the necessary Device Tree informations to
   enable the coherency.

Best regards,

Thomas

Thomas Petazzoni (10):
  ARM: mvebu: prepare coherency code to support more SOCs
  ARM: mvebu: add a coherency_available() call
  bus: mvebu: pass the coherency availability information at init time
  ARM: mvebu: ARM: mvebu: use of_find_matching_node_and_match() in
    coherency.c
  ARM: mvebu: enable the ARM SCU on Armada 375 and Armada 38x
  ARM: mvebu: add Armada 375 support to the coherency code
  ARM: mvebu: implement Armada 375 coherency workaround
  ARM: mvebu: add Armada 38x support to the coherency code
  ARM: mvebu: enable the coherency fabric on Armada 375
  ARM: mvebu: enable the coherency fabric on Armada 38x

 .../devicetree/bindings/arm/coherency-fabric.txt   |  32 ++-
 arch/arm/boot/dts/armada-375.dtsi                  |  10 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  10 +
 arch/arm/mach-kirkwood/board-dt.c                  |   2 +-
 arch/arm/mach-mvebu/Kconfig                        |   2 +
 arch/arm/mach-mvebu/board-v7.c                     |  21 +-
 arch/arm/mach-mvebu/coherency.c                    | 262 +++++++++++++++++++--
 arch/arm/mach-mvebu/coherency.h                    |   1 +
 arch/arm/mach-mvebu/dove.c                         |   2 +-
 arch/arm/mach-mvebu/kirkwood.c                     |   2 +-
 drivers/bus/mvebu-mbus.c                           |  11 +-
 include/linux/mbus.h                               |   2 +-
 12 files changed, 315 insertions(+), 42 deletions(-)

-- 
1.8.3.2
