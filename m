From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Jun 2014 18:00:52 +0900
Subject: [PATCH v3 00/19] Renesas CMT, MTU2 and TMU timers DT support
In-Reply-To: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140616090052.GH11582@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 14, 2014 at 06:23:22PM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch set adds DT bindings to the Renesas CMT, MTU2 and TMU timers.
> Patches 02/19 to 13/19, 16/19 and 17/19 have already been posted in the
> previous version of this series. Patches 14/19, 15/19, 18/19 and 19/19 are
> new.
> 
> Compared to v2 I've rebased the patches on top of Simon's latest devel branch.
> 
> Compared to v1 I've dropped the channel subnodes from the CMT DT bindings and
> just use a channels mask, as I don't need to specify per-channel properties.
> I'm slightly uncertain about this change though, as I can't easily predict
> whether per-channel properties would be needed later for new hardware. It
> won't be difficult to reintroduce channel subnodes then, so I'd rather not
> clutter the DT bindings with channel subnodes now. Please feel free to
> disagree.
> 
> The first 11 patches should go through the timers tree while the last 8
> patches should go through the Renesas SoC tree. Patches 12/19 to 15/19 have
> no build time or run time dependency on the drivers changes. Patches 16/19 to
> 19/19 may have a run time dependency on the drivers changes depending on the
> kernel configuration. Patches 16/19 and 17/19, for instance, require the
> driver changes only when architected timer support isn't enabled in the
> kernel.
> 
> Laurent Pinchart (19):
> o clocksource: sh_tmu: Fix channel IRQ retrieval in legacy case
> o clocksource: sh_cmt: Drop support for legacy platform data
> o clocksource: sh_cmt: Replace global spinlock with a per-device
>     spinlock
> o clocksource: sh_tmu: Drop support for legacy platform data
> o clocksource: sh_tmu: Replace global spinlock with a per-device
>     spinlock
>   clocksource: sh_mtu2: Drop support for legacy platform data
>   clocksource: sh_mtu2: Replace global spinlock with a per-device
>     spinlock
> o clocksource: shmobile: Remove unused sh_timer_config members
> o clocksource: sh_cmt: Add DT support
>   clocksource: sh_tmu: Add DT support
>   clocksource: sh_mtu2: Add DT support
> o ARM: shmobile: r8a7790: Add CMT devices to DT
> o ARM: shmobile: r8a7791: Add CMT devices to DT
>   ARM: shmobile: r8a7779: Add TMU devices to DT
>   ARM: shmobile: r7s72100: Add MTU2 device to DT
> o ARM: shmobile: lager-reference: Enable CMT0 in device tree
> o ARM: shmobile: koelsch-reference: Enable CMT0 in device tree
>   ARM: shmobile: marzen-reference: Enable TMU0 in device tree
>   ARM: shmobile: genmai-reference: Enable MTU2 in device tree

For the patches marked with a 'o':

Tested-by: Simon Horman <horms+renesas@verge.net.au>

>  .../devicetree/bindings/timer/renesas,cmt.txt      |  49 +++++
>  .../devicetree/bindings/timer/renesas,mtu2.txt     |  40 ++++
>  .../devicetree/bindings/timer/renesas,tmu.txt      |  40 ++++
>  arch/arm/boot/dts/r7s72100-genmai.dts              |   4 +
>  arch/arm/boot/dts/r7s72100.dtsi                    |  10 +
>  arch/arm/boot/dts/r8a7779-marzen.dts               |   4 +
>  arch/arm/boot/dts/r8a7779.dtsi                     |  42 ++++
>  arch/arm/boot/dts/r8a7790-lager.dts                |   4 +
>  arch/arm/boot/dts/r8a7790.dtsi                     |  34 +++
>  arch/arm/boot/dts/r8a7791-koelsch.dts              |   4 +
>  arch/arm/boot/dts/r8a7791.dtsi                     |  34 +++
>  arch/arm/mach-shmobile/board-genmai-reference.c    |  16 --
>  arch/arm/mach-shmobile/board-genmai.c              |  14 +-
>  arch/arm/mach-shmobile/board-koelsch-reference.c   |   2 -
>  arch/arm/mach-shmobile/board-lager-reference.c     |   2 -
>  arch/arm/mach-shmobile/board-marzen-reference.c    |  10 -
>  arch/arm/mach-shmobile/include/mach/r7s72100.h     |   1 -
>  arch/arm/mach-shmobile/include/mach/r8a7779.h      |   1 -
>  arch/arm/mach-shmobile/include/mach/r8a7790.h      |   1 -
>  arch/arm/mach-shmobile/include/mach/r8a7791.h      |   1 -
>  arch/arm/mach-shmobile/setup-r7s72100.c            |  21 --
>  arch/arm/mach-shmobile/setup-r8a7779.c             |  17 +-
>  arch/arm/mach-shmobile/setup-r8a7790.c             |   7 +-
>  arch/arm/mach-shmobile/setup-r8a7791.c             |   7 +-
>  drivers/clocksource/sh_cmt.c                       | 233 ++++++++-------------
>  drivers/clocksource/sh_mtu2.c                      | 146 ++++---------
>  drivers/clocksource/sh_tmu.c                       | 125 +++++------
>  include/linux/sh_timer.h                           |   5 -
>  28 files changed, 467 insertions(+), 407 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
