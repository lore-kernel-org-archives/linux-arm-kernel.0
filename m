From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 18 Apr 2014 16:48:00 +0200
Subject: [PATCH v2 00/14] Renesas CMT, MTU2 and TMU timers DT support
Message-ID: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds DT bindings to the Renesas CMT, MTU2 and TMU timers. The
CMT patches have been previously posted as part of the "[PATCH 00/27] Renesas
CMT (Compare Match Timer) DT bindings" series. The MTU2 patches have been
previously posted as part of the "[PATCH 00/22] SH MTU2 DT support" series.
The TMU patches are new.

The set builds on top of the "[PATCH v3 00/52] Renesas CMT and TMU cleanups"
series and the cleanup patches of the "[PATCH 00/22] SH MTU2 DT support"
series. I will thus rebase and resend it when the dependencies will be merged.
I would however like to get the patches reviewed and acked already.

Compared to v1 I've dropped the channel subnodes from the CMT DT bindings and
just use a channels mask, as I don't need to specify per-channel properties.
I'm slightly uncertain about this change though, as I can't easily predict
whether per-channel properties would be needed later for new hardware. It
won't be difficult to reintroduce channel subnodes then, so I'd rather not
clutter the DT bindings with channel subnodes now. Please feel free to
disagree.

The first 10 patches should go through the timers tree while the last 4
patches should go through the Renesas SoC tree. Patches 11/14 and 12/14 have
no build time or run time dependency on the drivers changes, so I plan to ask
Simon to pick them up when the DT bindings will be approved. Patches 13/14 and
14/14 have a run time dependency on the drivers changes, but only when
architected timer support isn't enabled in the kernel. It should thus be
relatively safe to merge them independently of the drivers changes. Simon,
Magnus, what's your opinion ?

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>

Laurent Pinchart (14):
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
  ARM: shmobile: lager-reference: Enable CMT0 in device tree
  ARM: shmobile: koelsch-reference: Enable CMT0 in device tree

 .../devicetree/bindings/timer/renesas,cmt.txt      |  49 +++++
 .../devicetree/bindings/timer/renesas,mtu2.txt     |  40 ++++
 .../devicetree/bindings/timer/renesas,tmu.txt      |  40 ++++
 arch/arm/boot/dts/r8a7790-lager.dts                |   4 +
 arch/arm/boot/dts/r8a7790.dtsi                     |  34 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   4 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  34 +++
 arch/arm/mach-shmobile/board-koelsch-reference.c   |   1 -
 arch/arm/mach-shmobile/board-lager-reference.c     |   1 -
 arch/arm/mach-shmobile/setup-r8a7790.c             |   2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c             |   2 +-
 drivers/clocksource/sh_cmt.c                       | 233 ++++++++-------------
 drivers/clocksource/sh_mtu2.c                      | 146 ++++---------
 drivers/clocksource/sh_tmu.c                       | 123 +++++------
 include/linux/sh_timer.h                           |   5 -
 15 files changed, 388 insertions(+), 330 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt

-- 
Regards,

Laurent Pinchart
