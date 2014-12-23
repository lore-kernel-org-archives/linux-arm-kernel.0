From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 24 Dec 2014 10:13:27 +1300
Subject: [RFC/PATCHv2 0/5] Add support for Marvell's RD-DXBC2
Message-ID: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's my updated series for Marvell's reference board. I had hoped to
send this before 3.19-rc1 but I missed by a few days.

The new 1/5 patch was sent to the devicetree ML. So far not much
feedback. 2/5 depends on it so I've included it in the series. It would
be possible to remove the dependency by using the CFLAGS_boardv7.o
trick and if/when the dtc change is accepted it could be cleaned up
along with the others.

I haven't had any (recent) feedback on patches 3-5, understandable this
time of year. These are unchanged since v1[1].

The more information I get out of Marvell the more I'm starting to see
this thing as a parallel development to the Armada-XP as opposed to a
direct descendent. In particular because the integrated packet processor
shares some clock sources with the CPU block there is a new "DFX" (no
idea what that stands for) block that replaces a lot of the SaR and
clocking registers from the Armada.

I'll probably have to create new clock drivers instead of using
armada-xp-cpu-clock. No problem for the driver itself but the device
tree becomes problematic. I can't use armada-xp-.dtsi because it already
uses the "cpuclk:" label which I can't re-define with a new node. There
are a couple of options. One is to split the common peripherals out into
individual .dtsi files (see arch/powerpc/boot/dts/fsl) which may not be
a bad thing since some of these are common to kirkwood/orion also.
Another approach might be to move the labeling to the final .dts files
which would allow us to pick which potential clocksource/driver gets
the label "cpuclk:"

Thanks,
Chris
--
[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309765.html

Chris Packham (5):
  dtc: Use quotes to include header files
  ARM: mvebu: use dt_fixup to provide fallback for enable-method
  clk: mvebu: armada-xp: Support for 98DX4251
  ARM: mvebu: Initial support for rd-dxbc2
  ARM: mvebu: Custom smp_ops for 98DX4251

 .../devicetree/bindings/clock/mvebu-core-clock.txt |   4 +
 arch/arm/boot/dts/rd-dxbc2.dts                     | 118 +++++++++++++++++++++
 arch/arm/mach-mvebu/Makefile                       |   1 +
 arch/arm/mach-mvebu/board-v7.c                     |  42 +++++++-
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |   3 +
 arch/arm/mach-mvebu/platsmp.c                      |  28 +++++
 arch/arm/mach-mvebu/pmsu-98dx4251.c                |  68 ++++++++++++
 drivers/clk/mvebu/armada-xp.c                      |  35 ++++++
 scripts/dtc/libfdt/libfdt.h                        |   4 +-
 10 files changed, 302 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/rd-dxbc2.dts
 create mode 100644 arch/arm/mach-mvebu/pmsu-98dx4251.c

-- 
2.2.0.rc0
