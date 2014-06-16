From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:12 +0200
Subject: [PATCH v4 00/19] Renesas CMT, MTU2 and TMU timers DT support
Message-ID: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds DT bindings to the Renesas CMT, MTU2 and TMU timers.
Patches 02/19 to 13/19, 16/19 and 17/19 have already been posted in the
previous version of this series. Patches 14/19, 15/19, 18/19 and 19/19 are
new.

The first 11 patches should go through the timers tree while the last 8
patches should go through the Renesas SoC tree. Patches 12/19 to 15/19 have
no build time or run time dependency on the drivers changes. Patches 16/19 to
19/19 may have a run time dependency on the drivers changes depending on the
kernel configuration. Patches 16/19 and 17/19, for instance, require the
driver changes only when architected timer support isn't enabled in the
kernel.

Changes since v3:

- Fixed TMU interrupt numbers
- Fixed NULL platform device ID dereference in TMU driver
- Removed interrupt-parent property from documentation
- Add missing of_match_ptr() and __maybe_unused() annotations

Changes since v2:

- Rebased on top of Simon's latest devel branch

Changes since v1:

- Dropped the channel subnodes from the CMT DT bindings and just use a
  channels mask, as we don't need to specify per-channel properties.

(I'm slightly uncertain about this change though, as I can't easily predict
whether per-channel properties would be needed later for new hardware. It
won't be difficult to reintroduce channel subnodes then, so I'd rather not
clutter the DT bindings with channel subnodes now. Please feel free to
disagree.)

Cc: devicetree at vger.kernel.org

Laurent Pinchart (19):
  clocksource: sh_tmu: Fix channel IRQ retrieval in legacy case
  clocksource: sh_cmt: Drop support for legacy platform data
  clocksource: sh_cmt: Replace global spinlock with a per-device
    spinlock
  clocksource: sh_tmu: Drop support for legacy platform data
  clocksource: sh_tmu: Replace global spinlock with a per-device
    spinlock
  clocksource: sh_mtu2: Drop support for legacy platform data
  clocksource: sh_mtu2: Replace global spinlock with a per-device
    spinlock
  clocksource: shmobile: Remove unused sh_timer_config members
  clocksource: sh_cmt: Add DT support
  clocksource: sh_tmu: Add DT support
  clocksource: sh_mtu2: Add DT support
  ARM: shmobile: r8a7790: Add CMT devices to DT
  ARM: shmobile: r8a7791: Add CMT devices to DT
  ARM: shmobile: r8a7779: Add TMU devices to DT
  ARM: shmobile: r7s72100: Add MTU2 device to DT
  ARM: shmobile: lager-reference: Enable CMT0 in device tree
  ARM: shmobile: koelsch-reference: Enable CMT0 in device tree
  ARM: shmobile: marzen-reference: Enable TMU0 in device tree
  ARM: shmobile: genmai-reference: Enable MTU2 in device tree

 .../devicetree/bindings/timer/renesas,cmt.txt      |  47 +++++
 .../devicetree/bindings/timer/renesas,mtu2.txt     |  39 ++++
 .../devicetree/bindings/timer/renesas,tmu.txt      |  39 ++++
 arch/arm/boot/dts/r7s72100-genmai.dts              |   4 +
 arch/arm/boot/dts/r7s72100.dtsi                    |  10 +
 arch/arm/boot/dts/r8a7779-marzen.dts               |   4 +
 arch/arm/boot/dts/r8a7779.dtsi                     |  42 ++++
 arch/arm/boot/dts/r8a7790-lager.dts                |   4 +
 arch/arm/boot/dts/r8a7790.dtsi                     |  32 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   4 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  32 +++
 arch/arm/mach-shmobile/board-genmai-reference.c    |  16 --
 arch/arm/mach-shmobile/board-genmai.c              |  14 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c   |   2 -
 arch/arm/mach-shmobile/board-lager-reference.c     |   2 -
 arch/arm/mach-shmobile/board-marzen-reference.c    |  10 -
 arch/arm/mach-shmobile/include/mach/r7s72100.h     |   1 -
 arch/arm/mach-shmobile/include/mach/r8a7779.h      |   1 -
 arch/arm/mach-shmobile/include/mach/r8a7790.h      |   1 -
 arch/arm/mach-shmobile/include/mach/r8a7791.h      |   1 -
 arch/arm/mach-shmobile/setup-r7s72100.c            |  21 --
 arch/arm/mach-shmobile/setup-r8a7779.c             |  17 +-
 arch/arm/mach-shmobile/setup-r8a7790.c             |   7 +-
 arch/arm/mach-shmobile/setup-r8a7791.c             |   7 +-
 drivers/clocksource/sh_cmt.c                       | 233 ++++++++-------------
 drivers/clocksource/sh_mtu2.c                      | 146 ++++---------
 drivers/clocksource/sh_tmu.c                       | 129 +++++-------
 include/linux/sh_timer.h                           |   5 -
 28 files changed, 462 insertions(+), 408 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt

-- 
Regards,

Laurent Pinchart
