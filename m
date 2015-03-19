From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 18 Mar 2015 18:42:59 -0700
Subject: [PATCH v6 0/6] Add common clock support for Broadcom iProc
 architecture
In-Reply-To: <1426657522-2473-1-git-send-email-rjui@broadcom.com>
References: <1426657522-2473-1-git-send-email-rjui@broadcom.com>
Message-ID: <550A29A3.5060207@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patchset looks good now.

Scott

On 15-03-17 10:45 PM, Ray Jui wrote:
> This patchset contains the initial common clock support for Broadcom's iProc
> family of SoCs. The iProc clock architecture comprises of various PLLs, e.g.,
> ARMPLL, GENPLL, LCPLL0, MIPIPLL, and etc. An onboard crystal serves as the
> basic reference clock for these PLLs. Each PLL may have several leaf clocks.
> One special group of clocks is the ASIU clocks, which are dervied directly
> from the crystal reference clock.
>
> This patchset also contains the basic clock support for the Broadcom Cygnus
> SoC, which implements the iProc clock architecture
>
> Changes from v5:
>   - Rebase to v4.0-rc4
>   - Drop of_clk_get_parent_rate helper function from the clock framework
>   - Get rid of custom "clock-frequency" support in iProc PLL code. Instead, add
>     standard clock set_rate and round_rate support and make use of DT properties
>     "assigned-clocks" and "assigned-clock-rates" to initialize PLL to the
>     desired rate when registering to the clock framework
>   - Add SW workaround for ASIC bug on MIPI PLL to always read back the same
>     register following a write transaction, to ensure value is written to the
>     correct register
>
> Changes from v4:
>   - Add of_clk_get_parent_rate helper function into the clock framework
>   - Switch to use of_clk_get_parent_rate in the iProc PLL clock driver
>
> Changes from v3:
>   - Fix incorrect use of passing in of_clk_src_onecell_get when adding ARM PLL
>     and other iProc PLLs as clock provider. These PLLs have zero cells in DT and
>     thefore of_clk_src_simple_get should be used instead
>   - Rename Cygnus MIPI PLL Channel 2 clock from BCM_CYGNUS_MIPIPLL_CH2_UNUSED
>     to BCM_CYGNUS_MIPIPLL_CH2_V3D, since a 3D graphic rendering engine has been
>     integrated into Cygnus revision B0 and has its core clock running off
>     MIPI PLL Channel 2
>   - Changed default MIPI PLL VCO frequency from 1.75 GHz to 2.1 GHz. This allows
>     us to derive 300 MHz V3D clock from channel 2 through the post divisor
>
> Changes from v2:
>   - Re-arrange Cygnus clock/pll init functions so each init function is right
>     next to its clock table
>   - Removed #defines for number of clocks in Cygnus. Have the number of clocks
>     automatically determined based on array size of the clock table
>
> Changes from v1:
>   - Separate drivers/clk/Makefile change for drivers/clk/bcm out to a standalone patch
>
> Ray Jui (6):
>    clk: iproc: define Broadcom iProc clock binding
>    clk: iproc: add initial common clock support
>    clk: Change bcm clocks build dependency
>    clk: cygnus: add clock support for Broadcom Cygnus
>    ARM: dts: enable clock support for Broadcom Cygnus
>    clk: cygnus: remove Cygnus dummy clock binding
>
>   .../devicetree/bindings/clock/bcm-cygnus-clock.txt |   34 --
>   .../bindings/clock/brcm,iproc-clocks.txt           |  171 +++++++
>   arch/arm/boot/dts/bcm-cygnus-clock.dtsi            |  112 ++++-
>   arch/arm/boot/dts/bcm-cygnus.dtsi                  |    2 +-
>   drivers/clk/Makefile                               |    2 +-
>   drivers/clk/bcm/Kconfig                            |    9 +
>   drivers/clk/bcm/Makefile                           |    2 +
>   drivers/clk/bcm/clk-cygnus.c                       |  284 ++++++++++++
>   drivers/clk/bcm/clk-iproc-armpll.c                 |  282 +++++++++++
>   drivers/clk/bcm/clk-iproc-asiu.c                   |  275 +++++++++++
>   drivers/clk/bcm/clk-iproc-clk.c                    |  244 ++++++++++
>   drivers/clk/bcm/clk-iproc-pll.c                    |  490 ++++++++++++++++++++
>   drivers/clk/bcm/clk-iproc.h                        |  164 +++++++
>   include/dt-bindings/clock/bcm-cygnus.h             |   65 +++
>   14 files changed, 2075 insertions(+), 61 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
>   create mode 100644 Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
>   create mode 100644 drivers/clk/bcm/clk-cygnus.c
>   create mode 100644 drivers/clk/bcm/clk-iproc-armpll.c
>   create mode 100644 drivers/clk/bcm/clk-iproc-asiu.c
>   create mode 100644 drivers/clk/bcm/clk-iproc-clk.c
>   create mode 100644 drivers/clk/bcm/clk-iproc-pll.c
>   create mode 100644 drivers/clk/bcm/clk-iproc.h
>   create mode 100644 include/dt-bindings/clock/bcm-cygnus.h
>
