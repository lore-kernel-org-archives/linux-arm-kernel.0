From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 06 Aug 2013 12:47:51 -0700
Subject: [PATCH v2 0/8] Common Clock Framework support for Samsung S3C64xx
In-Reply-To: <7952777.WiMApbNK0e@flatron>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <51FFEB63.6060901@samsung.com> <20130805190216.5348.8595@quantum>
 <7952777.WiMApbNK0e@flatron>
Message-ID: <20130806194751.5348.55680@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2013-08-05 16:42:16)
> On Monday 05 of August 2013 12:02:16 Mike Turquette wrote:
> > Quoting Kukjin Kim (2013-08-05 11:13:55)
> > 
> > > On 08/06/13 03:06, Mike Turquette wrote:
> > > > Quoting Kukjin Kim (2013-08-05 10:01:36)
> > > > 
> > > >> On 07/23/13 08:49, Tomasz Figa wrote:
> > > >>> This series is an attempt to move clock support on Samsung S3C64xx
> > > >>> SoCs
> > > >>> to Common Clock Framework.
> > > >>> 
> > > >>> First, support for PLL types present on S3C64xx SoCs is added to
> > > >>> Samsung Common Clock Framework driver. Then the main clock driver
> > > >>> for mentioned SoCs is introduced. Further patches contain fixes
> > > >>> for drivers to make them compliant with CCF semantics, migration
> > > >>> of platform code to use the new clock driver and removal of old
> > > >>> clock management code.
> > > >>> 
> > > >>> Depends on:
> > > >>>    - [PATCH v4 00/20] Samsung PWM support cleanup
> > > >>>    
> > > >>>      http://thread.gmane.org/gmane.linux.kernel.samsung-soc/20856
> > > >>> 
> > > >>> On S3C6410-based Tiny6410 board (Mini6410-compatible):
> > > >>> 
> > > >>> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
> > > >>> 
> > > >>> For v1:
> > > >>> 
> > > >>> Acked-by: Mike Turquette<mturquette@linaro.org>
> > > >>> 
> > > >>> Changes since v1:
> > > >>>    - added patch for read-only muxes,
> > > >>>    - exported configurable muxes and dividers,
> > > >>>    - defined mout_syncmux as read-only mux,
> > > >>>    - in DT-enabled case fixed-clock binding is used to define
> > > >>>    external clocks.> >>> 
> > > >>> Tomasz Figa (8):
> > > >>>     clk: mux: Add support for read-only muxes.
> > > >>>     clk: samsung: pll: Add support for PLL6552 and PLL6553
> > > >>>     clk: samsung: Add clock driver for S3C64xx SoCs
> > > >>>     ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
> > > >>>     ARM: s3c64xx: dma: Use
> > > >>>     clk_prepare_enable/clk_disable_unprepare
> > > >>>     usb: host: ohci-s3c2410 Use
> > > >>>     clk_prepare_enable/clk_disable_unprepare
> > > >>>     ARM: s3c64xx: Migrate clock handling to Common Clock Framework
> > > >>>     ARM: s3c64xx: Remove old clock management code
> > > >>>    
> > > >>>    .../bindings/clock/samsung,s3c64xx-clock.txt       |   77 ++
> > > >>>    arch/arm/Kconfig                                   |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/Makefile                     |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/clock.c                      | 1007
> > > >>>    -------------------- arch/arm/mach-s3c64xx/common.c           
> > > >>>             |   21 +-
> > > >>>    arch/arm/mach-s3c64xx/common.h                     |   12 +-
> > > >>>    arch/arm/mach-s3c64xx/dma.c                        |    4 +-
> > > >>>    arch/arm/mach-s3c64xx/include/mach/regs-clock.h    |  132 +--
> > > >>>    arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-smartq.c                |   11 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
> > > >>>    arch/arm/mach-s3c64xx/pm.c                         |   21 -
> > > >>>    arch/arm/mach-s3c64xx/s3c6400.c                    |    6 -
> > > >>>    arch/arm/mach-s3c64xx/s3c6410.c                    |    7 -
> > > >>>    arch/arm/plat-samsung/include/plat/cpu.h           |    4 +
> > > >>>    drivers/clk/clk-mux.c                              |   10 +-
> > > >>>    drivers/clk/samsung/Makefile                       |    1 +
> > > >>>    drivers/clk/samsung/clk-pll.c                      |  160 ++++
> > > >>>    drivers/clk/samsung/clk-pll.h                      |    4 +
> > > >>>    drivers/clk/samsung/clk-s3c64xx.c                  |  465
> > > >>>    +++++++++
> > > >>>    drivers/usb/host/ohci-s3c2410.c                    |    8 +-
> > > >>>    include/dt-bindings/clock/samsung,s3c64xx-clock.h  |  178 ++++
> > > >>>    include/linux/clk-provider.h                       |    2 +
> > > >>>    28 files changed, 943 insertions(+), 1205 deletions(-)
> > > >>>    create mode 100644
> > > >>>    Documentation/devicetree/bindings/clock/samsung,s3c64xx-clock.
> > > >>>    txt delete mode 100644 arch/arm/mach-s3c64xx/clock.c
> > > >>>    create mode 100644 drivers/clk/samsung/clk-s3c64xx.c
> > > >>>    create mode 100644
> > > >>>    include/dt-bindings/clock/samsung,s3c64xx-clock.h
> > > >> 
> > > >> Basically, this series looks good to me, but I'm not sure how this
> > > >> should be handled because of dependency with PWM cleanup and clk
> > > >> stuff
> > > >> in clk tree now...
> > > > 
> > > > Patches 1-3 can go into the clk tree. 4-6 should go through their
> > > > respective trees.
> > > > 
> > > > If you want I can take 7&  8 through the clk tree.
> > > > 
> > > > Alternatively I can provide patches 1-3 in a separate stable topic
> > > > branch for you to pull in as a dependency. We'll both merge that
> > > > stable
> > > > topic branch into our trees and you can make a note of it for the
> > > > arm-soc folks.
> > > 
> > > Thanks for your quick response. Would be helpful to samsung tree if
> > > you
> > > could provide a separate stable topic branch what you suggested for
> > > clk
> > > stuff in this series.
> > 
> > git://git.linaro.org/people/mturquette/linux.git clk-next-s3c64xx
> > 
> > Topic branch contains patches 1-3 of this series on top of v3.11-rc2. I
> > have already merged the same into the clk-next branch.
> 
> What about the dependency on PWM cleanup series? Patches 7-8 must be 
> merged after them, otherwise there will be a regression, because the old 
> PWM clocksource driver will be broken and so s3c64xx won't boot until 
> moved to new one, which is done by mentioned series.

Is this a question for me? I did not take patches 7 or 8 into clk-next.
Sounds like those patches should go through Samsung tree into arm-soc,
and perhaps be a late-applied branch to get the ordering right.

Regards,
Mike

> 
> Best regards,
> Tomasz
