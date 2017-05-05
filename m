From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 5 May 2017 08:46:45 +0200
Subject: [linux-sunxi] [PATCH v2 0/8] clk: sunxi-ng: Add support for A83T
 CCU
In-Reply-To: <20170503031658.29299-1-wens@csie.org>
References: <20170503031658.29299-1-wens@csie.org>
Message-ID: <20170505064645.GA31657@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:16:50AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> (Resent with devicetree mailing list CC-ed.)
> This is v2 of my A83T CCU series. This is for 4.13.
> 
> Changes since v1:
> 
>   - Dropped two patches that were merged
> 
>   - Added clk core flag to disable caching of clock phases
> 
>   - Added support for multiple variable pre-dividers
> 
>   - Merged "pll-periph-ahb1" pre-divider clock into "ahb1" clock
>     with multiple variable pre-dividers
> 
>   - Introduced new class of phase clocks that return -ENOTSUPP
>     when the clock is in new timing mode
> 
>   - Force mmc2 clock to new timing mode
> 
>   - Added back mmc2 output and sample clocks
> 
>   - Fixed bit ops for forcing audio PLL configuration
> 
>   - Added requirement for "losc" clock in device tree binding
> 
>   - Stripped leading 0 in device node name
> 
>   - Updated subject prefixes for various patches
> 
> Patch 1 adds a compatible string for the A83T CCU to the sunxi-ccu
> bindings.
> 
> Patch 2 adds a CLK_GET_PHASE_NOCACHE flag to the clk core, asking it
> not to cache clock phase values. This is similar to CLK_GET_RATE_NOCACHE.
> Patch 5 has a compile time dependency on this patch, for the flag value.
> 
> Patch 3 adds a new class of phase clocks that check the new timing mode
> bit, and returns an error if it is set, which indicates the phase delays
> no longer apply. This is a clean way to signal which timing mode the mmc
> clock is in, without using any custom functions or callbacks. We don't
> support runtime switching of modes.
> 
> Patch 4 adds support for multiple variable pre-dividers to the sunxi-ng
> mux class.
> 
> Patch 5 adds the driver for the A83T CCU.
> 
> Patch 6 adds the CCU device nodes, and fixes up any existing clock
> phandles in the dtsi, without using the macros.
> 
> Patch 7 sets the clock accuracy for the main oscillator.
> 
> Patch 8 is for the next -rc2, switch the clock indices from raw numbers
> to macros we introduced with the driver. This will be updated if more
> peripherals are introduced in the same cycle.
> 
> Let me know what you think.
> 
> Cover letter excerpt from v1:
> 
> This is yet another series that adds support for the A83T CCU.
> The A83T CCU has a mix of new styled (like the A80) clocks at
> old (like A3x) offsets. Some differences include:
> 
>   - D1/D2 style PLL clocks
>   - divisible audio module clocks
>   - new timing mode for mmc2 module clock
> 
> 
> Regards
> ChenYu
> 
> Chen-Yu Tsai (8):
>   dt-bindings: clock: sunxi-ccu: Add compatible string for A83T CCU
>   clk: Provide option to query hardware for clk phase
>   clk: sunxi-ng: Add class of phase clocks supporting MMC new timing
>     modes
>   clk: sunxi-ng: Support multiple variable pre-dividers
>   clk: sunxi-ng: Add driver for A83T CCU
>   ARM: sun8i: a83t: Add CCU device nodes
>   ARM: sun8i: a83t: Set clock accuracy for 24MHz oscillator
>   ARM: sun8i: a83t: Switch to CCU device tree binding macros
> 
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   2 +
>  arch/arm/boot/dts/sun8i-a83t.dtsi                  |  19 +-
>  drivers/clk/clk.c                                  |   6 +-
>  drivers/clk/sunxi-ng/Kconfig                       |  10 +
>  drivers/clk/sunxi-ng/Makefile                      |   1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |  10 +-
>  drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |  10 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |  10 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  10 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              | 911 +++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.h              |  64 ++
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |  10 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |  10 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |  10 +-
>  drivers/clk/sunxi-ng/ccu_mux.c                     |  15 +-
>  drivers/clk/sunxi-ng/ccu_mux.h                     |  13 +-
>  drivers/clk/sunxi-ng/ccu_phase.c                   |  47 ++
>  drivers/clk/sunxi-ng/ccu_phase.h                   |  16 +
>  include/dt-bindings/clock/sun8i-a83t-ccu.h         | 140 ++++
>  include/dt-bindings/reset/sun8i-a83t-ccu.h         |  98 +++
>  include/linux/clk-provider.h                       |   1 +
>  21 files changed, 1363 insertions(+), 50 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
>  create mode 100644 include/dt-bindings/clock/sun8i-a83t-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun8i-a83t-ccu.h
> 

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
