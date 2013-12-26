From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 15:12:50 +0100
Subject: [PATCH RFCv1 0/6] ARM: mvebu: coherency support improvements
Message-ID: <1388067176-18177-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Gregory, Andrew, Sebastian,

Here is a set of patches that make some changes to the mach-mvebu
coherency code, and the way the mvebu-mbus driver determines whether
hardware I/O coherency is enabled or not.

These changes are proposed in preparation to the introduction of the
support for more recent SOCs in mach-mvebu, which have a slightly
different coherency fabric (hence the need for different compatible
strings) and different constraints to be able to enable the I/O
coherency (not only the coherency fabric must be available, but the
kernel must be running in CONFIG_SMP).

Moreover, the mvebu-mbus driver was directly poking into the DT to
find whether a coherency fabric node was available or not, to
determine if I/O coherency is enabled or not. However, with the new
constraint that CONFIG_SMP must be enabled on some SOCs to get I/O
coherency, the solution of having mvebu-mbus directly poke into the DT
is not longer appropriate. This patch set therefore changes the
mvebu_mbus_dt_init() function call to take an additional boolean
argument telling whether the system is running in I/O coherent mode or
not.

I've for now marked those patches as RFC, to indicate that they are
clearly open for discussion. For example, I'm still wondering if I
should not introduce separate compatible strings
marvell,armada-370-coherency-fabric and
marvell,armada-xp-coherency-fabric for Armada 370 and Armada XP
respectively instead of using marvell,armada-370-coherency-fabric for
both. Our experience has shown that we often initially believe that a
given hardware unit is similar between SOCs, and then later discover
that there are in fact some slight differences, which should have
called for different compatible strings from the beginning.

Best regards,

Thomas

Thomas Petazzoni (6):
  ARM: mvebu: prepare coherency code to support more SOCs
  ARM: mvebu: add a coherency_available() call
  bus: mvebu: pass the coherency availability information at init time
  ARM: mvebu: use of_find_matching_node_and_match() in coherency.c
  ARM: mvebu: update Armada 370/XP DT to use new coherency compatible
    string
  ARM: mvebu: update coherency fabric DT binding documentation

 .../devicetree/bindings/arm/coherency-fabric.txt   | 19 +++--
 arch/arm/boot/dts/armada-370-xp.dtsi               |  2 +-
 arch/arm/mach-kirkwood/board-dt.c                  |  2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  2 +-
 arch/arm/mach-mvebu/coherency.c                    | 80 ++++++++++++++++------
 arch/arm/mach-mvebu/coherency.h                    |  1 +
 drivers/bus/mvebu-mbus.c                           | 11 +--
 include/linux/mbus.h                               |  2 +-
 8 files changed, 79 insertions(+), 40 deletions(-)

-- 
1.8.3.2
