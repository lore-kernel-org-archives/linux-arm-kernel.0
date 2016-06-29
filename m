From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:21 +0200
Subject: [PATCH v3 00/14] clk: sunxi: introduce "modern" clock support
Message-ID: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the third attempt at introducing clock support for the
Allwinner SoCs following the current model used by pretty much all the
other SoCs.

Such a conversion has been suggested on a regular basis by Mike and
Stephen, and here is a first implementation.

This new approach has a good number of advantages, some due to the new
binding itself, some due to the lessons learned with the current code
we have.

Beside from having a binding similar to the other SoCs, which helps
developer hopping from one SoC to the other, it also reduces the
amount of binding review that needs to be done, something that Rob
already complained about a few times.
Now that we are following the DT-as-an-ABI rule, the new binding will
also make our life way easier, since we reduce the exposed surface
greatly. The former binding, while making quite easy to mix and match
clocks when bringing up new SoCs, was also exposing way too much
implementation details that would hold us back when wanting to
refactor, consolidate, or fix some shortcomings in the current
implementation. In the new approach, the only thing that we're
exposing is the clock index, meaning that we can change the
implementation as much as we want.

This rewrite is also the occasion to layer things up quite differently
in our clock core.

The current code had a bunch of shortcomings. Most of the code was
relying on our clk-factor code, which was factoring away a few things
like the clock registration, ie boilerplate, but didn't factor the
logic to compute a clock rate, while the huge majority are computed
from some variation of a formula, which could actually be shared.

Which meant that every time we had to add new code to help clk-factors
compute the actual factors used, even though a clock with the same
formual was probably already supported. This eventually lead to a huge
number of clocks driver patches, and to review, which is also
something Stephen complained about.

The new approach takes a different approach by adding a bunch of clock
drivers based on the formula they use to compute their rate and / or
the features they have (mux, gate, etc.). The SoC will only have to
provide the data for the driver to know how many options it has,
without adding any extra code.

To reduce the amount of code duplication between those drivers, a
bunch of helpers have also been introduced to deal with the common
features (pre-dividers, gate, muxes, etc.). This will also be very
easy to extend to support new features missing for now (mostly the
fractional stuff as of today).

Since this is a complete rewrite, it probably has a bunch of bugs
and/or limitations not yet found. My plan would be to start using that
approach on the A64, A83T and H3 which are in their early support
stage to be the test-bed for this new framework, before switching the
older and more featureful SoCs to it eventually.

Because of the DT ABI, the older drivers will remain in-tree
obviously, otherwise things would break pretty badly.

The current code has been tested on the H3 and an Orange Pi PC,
including making sure that MMC still works, so the general approach
seems ok.

Let me know what you think,
Maxime

Changes from v2:
  * Switched to Kconfig, and selected the rational lib Kconfig option
  * Added a better define and comment for the Audio PLL register, and
    why we need to poke it.
  * Removed the PLL locks and gate feature flags
  * Fixed the missing gate define in the CCU divider macro
  * Switched to clk_hw_register
  * Removed our implementation of the fixed factor clocks and used the
    CCF one.
  * Initialise clk_hw_onecell_data statically
  * Only expose in the dt-bindings header the clocks that should be
    use by the devices, and not the internal ones.
  * Fixed a typo in the DT documentation

Changes from v1:
  * Common parts:
      - Moved the register mapping out of the common probe function and
        into the SoC specific part to be able to do some quirks
      - Changed the LOCK feature to PLL_LOCK
      - Fixed a bug in the iteration over the clock array
      - Changed the clock register offset to an u16
      - Added fractional support
      - Added comments to define the formulas of the various clock classes
      - Fixed an off-by-one issue in the GENMASK calls
      - Added macros for all the simple clocks
      - Added the DT documentation

  * H3 part
      - Only build when MACH_SUN8I is set
      - Use a static PLL2-1x divider
      - Used common parents definitions when possible
      - Fixed the mux width of a bunch of clocks
      - Fixed the parent of USB OTG bus clocks

  * Dividers
      - Dropped the various classes of dividers and merged them into a
        single one

  * Fixed factor
      - Added support for CLK_SET_RATE_PARENT in fixed factor clocks
      - Changed the operands order in the rate computation

  * Mux:
      - Moved the header introduction from the patch adding the common
        parts to the patch adding the mux

  * N-M:
      - Fixed the maximum passed to the rational function

  * N-K-M:
      - Declared the find_best function static
      - Fixed the set_rate function that was always writing the factors
        at the same offset
      - Used a structure for all the find_best arguments

  * N-K-M-P:
      - Fixed the parent rate computation in the rational_best call
      - Used a structure for all the find_best arguments

  * Phase:
      - Renamed some variables as suggested    

Maxime Ripard (14):
  dt-bindings: sunxi: Add CCU binding documentation
  clk: sunxi-ng: Add common infrastructure
  clk: sunxi-ng: Add fractional lib
  clk: sunxi-ng: Add gate clock support
  clk: sunxi-ng: Add mux clock support
  clk: sunxi-ng: Add phase clock support
  clk: sunxi-ng: Add divider
  clk: sunxi-ng: Add M-P factor clock support
  clk: sunxi-ng: Add N-K-factor clock support
  clk: sunxi-ng: Add N-M-factor clock support
  clk: sunxi-ng: Add N-K-M Factor clock
  clk: sunxi-ng: Add N-K-M-P factor clock
  clk: sunxi-ng: Add H3 clocks
  ARM: dt: sun8i: switch the H3 to the new CCU driver

 .../devicetree/bindings/clock/sunxi-ccu.txt        |  24 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 312 ++------
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |  65 ++
 drivers/clk/sunxi-ng/Makefile                      |  20 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                | 826 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |  62 ++
 drivers/clk/sunxi-ng/ccu_common.c                  |  90 +++
 drivers/clk/sunxi-ng/ccu_common.h                  |  85 +++
 drivers/clk/sunxi-ng/ccu_div.c                     | 136 ++++
 drivers/clk/sunxi-ng/ccu_div.h                     | 133 ++++
 drivers/clk/sunxi-ng/ccu_frac.c                    | 110 +++
 drivers/clk/sunxi-ng/ccu_frac.h                    |  53 ++
 drivers/clk/sunxi-ng/ccu_gate.c                    |  82 ++
 drivers/clk/sunxi-ng/ccu_gate.h                    |  52 ++
 drivers/clk/sunxi-ng/ccu_mp.c                      | 158 ++++
 drivers/clk/sunxi-ng/ccu_mp.h                      |  77 ++
 drivers/clk/sunxi-ng/ccu_mult.h                    |  15 +
 drivers/clk/sunxi-ng/ccu_mux.c                     | 187 +++++
 drivers/clk/sunxi-ng/ccu_mux.h                     |  91 +++
 drivers/clk/sunxi-ng/ccu_nk.c                      | 147 ++++
 drivers/clk/sunxi-ng/ccu_nk.h                      |  71 ++
 drivers/clk/sunxi-ng/ccu_nkm.c                     | 153 ++++
 drivers/clk/sunxi-ng/ccu_nkm.h                     |  68 ++
 drivers/clk/sunxi-ng/ccu_nkmp.c                    | 167 +++++
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |  71 ++
 drivers/clk/sunxi-ng/ccu_nm.c                      | 114 +++
 drivers/clk/sunxi-ng/ccu_nm.h                      |  91 +++
 drivers/clk/sunxi-ng/ccu_phase.c                   | 126 ++++
 drivers/clk/sunxi-ng/ccu_phase.h                   |  50 ++
 drivers/clk/sunxi-ng/ccu_reset.c                   |  55 ++
 drivers/clk/sunxi-ng/ccu_reset.h                   |  40 +
 include/dt-bindings/clock/sun8i-h3-ccu.h           | 145 ++++
 include/dt-bindings/reset/sun8i-h3-ccu.h           | 103 +++
 35 files changed, 3729 insertions(+), 252 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi-ccu.txt
 create mode 100644 drivers/clk/sunxi-ng/Kconfig
 create mode 100644 drivers/clk/sunxi-ng/Makefile
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_common.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_common.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_div.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_div.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_frac.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_frac.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_gate.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_gate.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_mp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_mp.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_mult.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_mux.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_mux.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_nk.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nk.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkm.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_phase.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_phase.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_reset.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_reset.h
 create mode 100644 include/dt-bindings/clock/sun8i-h3-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-h3-ccu.h

-- 
2.9.0
