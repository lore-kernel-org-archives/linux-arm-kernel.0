From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Aug 2013 02:01:36 +0900
Subject: [PATCH v2 0/8] Common Clock Framework support for Samsung S3C64xx
In-Reply-To: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <51FFDA70.7080900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/13 08:49, Tomasz Figa wrote:
> This series is an attempt to move clock support on Samsung S3C64xx SoCs
> to Common Clock Framework.
>
> First, support for PLL types present on S3C64xx SoCs is added to Samsung
> Common Clock Framework driver. Then the main clock driver for mentioned
> SoCs is introduced. Further patches contain fixes for drivers to make them
> compliant with CCF semantics, migration of platform code to use the new
> clock driver and removal of old clock management code.
>
> Depends on:
>   - [PATCH v4 00/20] Samsung PWM support cleanup
>     http://thread.gmane.org/gmane.linux.kernel.samsung-soc/20856
>
> On S3C6410-based Tiny6410 board (Mini6410-compatible):
>
> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
>
> For v1:
>
> Acked-by: Mike Turquette<mturquette@linaro.org>
>
> Changes since v1:
>   - added patch for read-only muxes,
>   - exported configurable muxes and dividers,
>   - defined mout_syncmux as read-only mux,
>   - in DT-enabled case fixed-clock binding is used to define external clocks.
>
> Tomasz Figa (8):
>    clk: mux: Add support for read-only muxes.
>    clk: samsung: pll: Add support for PLL6552 and PLL6553
>    clk: samsung: Add clock driver for S3C64xx SoCs
>    ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
>    ARM: s3c64xx: dma: Use clk_prepare_enable/clk_disable_unprepare
>    usb: host: ohci-s3c2410 Use clk_prepare_enable/clk_disable_unprepare
>    ARM: s3c64xx: Migrate clock handling to Common Clock Framework
>    ARM: s3c64xx: Remove old clock management code
>
>   .../bindings/clock/samsung,s3c64xx-clock.txt       |   77 ++
>   arch/arm/Kconfig                                   |    2 +-
>   arch/arm/mach-s3c64xx/Makefile                     |    2 +-
>   arch/arm/mach-s3c64xx/clock.c                      | 1007 --------------------
>   arch/arm/mach-s3c64xx/common.c                     |   21 +-
>   arch/arm/mach-s3c64xx/common.h                     |   12 +-
>   arch/arm/mach-s3c64xx/dma.c                        |    4 +-
>   arch/arm/mach-s3c64xx/include/mach/regs-clock.h    |  132 +--
>   arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
>   arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
>   arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
>   arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
>   arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
>   arch/arm/mach-s3c64xx/mach-smartq.c                |   11 +-
>   arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
>   arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
>   arch/arm/mach-s3c64xx/pm.c                         |   21 -
>   arch/arm/mach-s3c64xx/s3c6400.c                    |    6 -
>   arch/arm/mach-s3c64xx/s3c6410.c                    |    7 -
>   arch/arm/plat-samsung/include/plat/cpu.h           |    4 +
>   drivers/clk/clk-mux.c                              |   10 +-
>   drivers/clk/samsung/Makefile                       |    1 +
>   drivers/clk/samsung/clk-pll.c                      |  160 ++++
>   drivers/clk/samsung/clk-pll.h                      |    4 +
>   drivers/clk/samsung/clk-s3c64xx.c                  |  465 +++++++++
>   drivers/usb/host/ohci-s3c2410.c                    |    8 +-
>   include/dt-bindings/clock/samsung,s3c64xx-clock.h  |  178 ++++
>   include/linux/clk-provider.h                       |    2 +
>   28 files changed, 943 insertions(+), 1205 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c64xx-clock.txt
>   delete mode 100644 arch/arm/mach-s3c64xx/clock.c
>   create mode 100644 drivers/clk/samsung/clk-s3c64xx.c
>   create mode 100644 include/dt-bindings/clock/samsung,s3c64xx-clock.h
>
Basically, this series looks good to me, but I'm not sure how this 
should be handled because of dependency with PWM cleanup and clk stuff 
in clk tree now...

- Kukjin
