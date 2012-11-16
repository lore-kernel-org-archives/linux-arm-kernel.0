From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Nov 2012 13:51:31 +0100
Subject: [PATCH 0/7] core, cpu and gated clocks for mvebu
In-Reply-To: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
Message-ID: <50A636D3.40005@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 10:28 PM, Andrew Lunn wrote:
> This patchset combines code from Gregory Clement, Sebastian
> Hesselbarth and myself to implement core clks, cpu clock and gated
> clocks on Marvel MVEBU SoCs.
> 
> The Armada 370/XP core clock code is a refactored version of the
> already submitted and ACKed code from Gregory. It has been made to fit
> inside a framework developed by Sebastian which can handle all MVEBU
> SoCs. The Armarda 370/XP SoCs have more core clocks than the older SoCs, and
> the framework needs to handle this. Rather than specify the clock
> frequencies in DT, a Sample At Reset register is used, which describes
> each core clock frequency.
> 
> Armarda XP is an SMP processor, with each CPU having its own
> clock. Gregories code for this has been taken as is.
> 
> The Armarda 370/XP clock source has been converted to the common clock
> framework.
> 
> Dove, Kirkword, and probably Armarda 370/XP have the ability to gate
> clocks to various blocks. A clk-gate clock is created for each of the
> gateable clocks on Dove and Kirkwood. Armarda 370/XP clock gates are
> currently unimplemented. Dove and Kirkwood board-dt.c and DT
> descriptions are then modified to make use of these clk gates.
> 
> This code has been tested on:
> 
> Kirkwood based QNAP TS219
> Armarda 370 based mirabox
> Armara XP based OpenBlocks
> 
> and by Sebastian on:
> 
> Dove based Cubox.
> 

Hi Andrew,
great job!

I have only few comments on the first patch.

Besides this I have tested the whole series on my Armada 370 and
Armada XP development boards.  With these boards I had the possibility
to change the frequency configuration. I also enable to
COMMON_CLK_DEBUG to check the clock rate value, and after having done
the tests on few combination and I didn't see any regression.

For the first 4 patches you can add my
Tested-by Gregory CLEMENT <gregory.clement@free-electrons.com>.

Mike I hope you will be able to have a look on the next version. With
the few incoming changes in the next version, this series will be at
least as good as mine and the only notable difference for the first
patches of this series is just adding new SoCs with more or less the
same framework.

Thanks


> Andrew Lunn (1):
>   ARM: Kirkwood: switch to DT clock providers
> 
> Gregory CLEMENT (3):
>   clk: mvebu: add armada-370-xp CPU specific clocks
>   clk: armada-370-xp: add support for clock framework
>   clocksource: time-armada-370-xp converted to clk framework
> 
> Sebastian Hesselbarth (3):
>   clk: mvebu: add mvebu core clocks.
>   clk: mvebu: add clock gating control provider for DT
>   ARM: dove: switch to DT clock providers
> 
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   47 ++
>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 +
>  .../bindings/clock/mvebu-gated-clock.txt           |   76 +++
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/armada-370-db.dts                |    4 -
>  arch/arm/boot/dts/armada-370-xp.dtsi               |    1 +
>  arch/arm/boot/dts/armada-370.dtsi                  |    7 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |   42 ++
>  arch/arm/boot/dts/dove.dtsi                        |   20 +
>  arch/arm/boot/dts/kirkwood.dtsi                    |   22 +
>  arch/arm/mach-dove/Kconfig                         |    2 +
>  arch/arm/mach-dove/common.c                        |   64 +-
>  arch/arm/mach-kirkwood/Kconfig                     |    2 +
>  arch/arm/mach-kirkwood/board-dt.c                  |   72 ++-
>  arch/arm/mach-mvebu/Kconfig                        |    6 +
>  arch/arm/mach-mvebu/armada-370-xp.c                |    9 +-
>  arch/arm/plat-orion/include/plat/common.h          |    1 +
>  drivers/clk/Kconfig                                |    2 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/mvebu/Kconfig                          |    8 +
>  drivers/clk/mvebu/Makefile                         |    3 +
>  drivers/clk/mvebu/clk-core.c                       |  675 ++++++++++++++++++++
>  drivers/clk/mvebu/clk-core.h                       |   18 +
>  drivers/clk/mvebu/clk-cpu.c                        |  155 +++++
>  drivers/clk/mvebu/clk-cpu.h                        |   18 +
>  drivers/clk/mvebu/clk-gating-ctrl.c                |  177 +++++
>  drivers/clk/mvebu/clk.c                            |   37 ++
>  drivers/clocksource/time-armada-370-xp.c           |   11 +-
>  include/linux/clk/mvebu.h                          |   23 +
>  29 files changed, 1487 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
>  create mode 100644 drivers/clk/mvebu/Kconfig
>  create mode 100644 drivers/clk/mvebu/Makefile
>  create mode 100644 drivers/clk/mvebu/clk-core.c
>  create mode 100644 drivers/clk/mvebu/clk-core.h
>  create mode 100644 drivers/clk/mvebu/clk-cpu.c
>  create mode 100644 drivers/clk/mvebu/clk-cpu.h
>  create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.c
>  create mode 100644 drivers/clk/mvebu/clk.c
>  create mode 100644 include/linux/clk/mvebu.h
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
