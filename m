From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Mon, 18 Dec 2017 17:46:29 +0800
Subject: [PATCH V7 00/12] add clock driver for Spreadtrum platforms
In-Reply-To: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
Message-ID: <CAAfSe-uh60=k+vkBsQdfLBOZJT_pCfsgt-KRLRvs-bwGVLQqpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since holidays are comming for many people, and then the next merge
window will come soon after holidays?
If you have any comments, please let me know, I hope this patchset can
be merged into the following merge window.

Wish you all a Merry Christmas and Happy New Year!

Thanks,
Chunyan

On 7 December 2017 at 20:57, Chunyan Zhang <chunyan.zhang@spreadtrum.com> wrote:
> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>
> This series adds Spreadtrum clock support together with its binding
> documentation and devicetree data.
>
> Any comments would be greatly appreciated.
>
> Thanks,
> Chunyan
>
> Changes from V6: (https://lkml.org/lkml/2017/11/27/217)
> * Changed to use "//" format for the file header
> * Addressed Stephen's comments:
>   - Put the common macros in clk-provider.h instead of clk_common.h, also removed
>     the same macros from sunxi-ng/ccu_common.h and zte/clk.h;
>   - Removed CLK_FIXED_RATE(), and moved the fixed rate clocks from driver to DT;
>   - Use devm_of_clk_add_hw_provider() instead;
>   - Removed sprd_regmap_{read|write}(), use regmap API directly;
>   - Removed all full stop on error messages.
> * Use IS_ERR_OR_NULL() instead of IS_ERR() for checking regmap pointers;
>
> Changes from V5: (https://lkml.org/lkml/2017/11/20/21)
> * Rebased the whole patch-set to 4.15-rc1;
> * Fixed kbuild-test warnings;
> * Switched to use devm_clk_hw_register() instead of clk_hw_register();
> * Removed useless debug information from sc9860-clk.c.
>
> Changes from V4: (https://lkml.org/lkml/2017/11/10/30)
> * Added acked-by of Rob Herring;
> * Removed spin lock from Spreadtrum's gate, mux, div drivers, since we have
>   switched to use regmap.
>
> Changes from V3: (https://lkml.org/lkml/2017/11/2/61)
> * Addressed comments from Julien Thierry:
>   - Clean the if branch of sprd_mux_helper_get_parent()
>   - Have the Gate clock macros and ops for both mode (i.e. sc_gate and gate) separate;
>   - Have the Mux clock macros with/without table separate, and same changes
>     for the composite clock.
> * Switched the function name from _endisable to _toggle;
> * Fixed Kbuild test error:
>   - Added exporting sprd_clk_regmap_init() which would be used in other module(s);
> * Change the function sprd_clk_set_regmap() to the static one, and removed the
>   declear from the include file;
> * Addressed comments from Rob:
>   - Separate the dt-binding include file from the driver patch;
>   - Documented more for the property "clocks"
> * Changed the syscon device names;
> * Changed the name of 'sprd_mux_internal' to 'sprd_mux_ssel'
>
>
> Changes from V2: (http://lkml.iu.edu/hypermail/linux/kernel/1707.1/01504.html)
> * Switch to use regmap to access registers;
> * Splited all clocks into 16 separated nodes, for each belongs to a single address area;
> * Rearranged the order of clock declaration in sc9860-clk.c, sorted them upon the address area;
> * Added syscon device tree nodes which will be quoted by the node of clocks which are in
>   the same address area with the syscon device;
> * Revised the binding documentation according to the dt modification.
>
> Changes from V1: (https://lkml.org/lkml/2017/6/17/356)
> * Address Stephen's comments:
>   - Switch to use platform device driver instead of the DT probing mechanism.
>   - Move the common clock macro out from vendor directory, but need to remove those
>     overlap code from other vendors (such as sunxi-ng) once this get merged.
>   - Add support to be built as a module.
>   - Add 'sprd_' prefix for all spin locks used in these drivers.
>   - Mark input parameter of sprd_x with const.
>   - Remove unreasonable dependencies to CONFIG_64BIT.
>   - Add readl() after writing the same register.
>   - Remove CLK_IS_BASIC which is no longer used.
>   - Remove unnecessery CLK_IGNORE_UNUSED when defining a clock.
>   - Change to expose all clock index.
>   - Use clk_ instead of ccu.
>   - Add Kconfig for sprd clocks.
>   - Move the fixed clocks out from the soc node.
>   - Switch to use 64-bit math in pll driver instead of 32-bit math.
> * Revise binding documentation according to dt modification.
> * Rename sc9860.c to sc9860-clk.c
>
>
> Chunyan Zhang (12):
>   drivers: move clock common macros out from vendor directories
>   clk: sprd: Add common infrastructure
>   clk: sprd: add gate clock support
>   clk: sprd: add mux clock support
>   clk: sprd: add divider clock support
>   clk: sprd: add composite clock support
>   clk: sprd: add adjustable pll support
>   dt-bindings: Add Spreadtrum clock binding documentation
>   clk: sprd: Add dt-bindings include file for SC9860
>   clk: sprd: add clocks support for SC9860
>   arm64: dts: add syscon for whale2 platform
>   arm64: dts: add clocks for SC9860
>
>  Documentation/devicetree/bindings/clock/sprd.txt |   63 +
>  arch/arm64/boot/dts/sprd/sc9860.dtsi             |  115 ++
>  arch/arm64/boot/dts/sprd/whale2.dtsi             |   62 +-
>  drivers/clk/Kconfig                              |    1 +
>  drivers/clk/Makefile                             |    1 +
>  drivers/clk/sprd/Kconfig                         |   14 +
>  drivers/clk/sprd/Makefile                        |   11 +
>  drivers/clk/sprd/common.c                        |   96 ++
>  drivers/clk/sprd/common.h                        |   38 +
>  drivers/clk/sprd/composite.c                     |   60 +
>  drivers/clk/sprd/composite.h                     |   51 +
>  drivers/clk/sprd/div.c                           |   90 +
>  drivers/clk/sprd/div.h                           |   75 +
>  drivers/clk/sprd/gate.c                          |  111 ++
>  drivers/clk/sprd/gate.h                          |   59 +
>  drivers/clk/sprd/mux.c                           |   76 +
>  drivers/clk/sprd/mux.h                           |   74 +
>  drivers/clk/sprd/pll.c                           |  266 +++
>  drivers/clk/sprd/pll.h                           |  108 ++
>  drivers/clk/sprd/sc9860-clk.c                    | 1974 ++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_common.h                |   29 -
>  drivers/clk/zte/clk.h                            |   18 -
>  include/dt-bindings/clock/sprd,sc9860-clk.h      |  404 +++++
>  include/linux/clk-provider.h                     |   38 +
>  24 files changed, 3785 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd.txt
>  create mode 100644 drivers/clk/sprd/Kconfig
>  create mode 100644 drivers/clk/sprd/Makefile
>  create mode 100644 drivers/clk/sprd/common.c
>  create mode 100644 drivers/clk/sprd/common.h
>  create mode 100644 drivers/clk/sprd/composite.c
>  create mode 100644 drivers/clk/sprd/composite.h
>  create mode 100644 drivers/clk/sprd/div.c
>  create mode 100644 drivers/clk/sprd/div.h
>  create mode 100644 drivers/clk/sprd/gate.c
>  create mode 100644 drivers/clk/sprd/gate.h
>  create mode 100644 drivers/clk/sprd/mux.c
>  create mode 100644 drivers/clk/sprd/mux.h
>  create mode 100644 drivers/clk/sprd/pll.c
>  create mode 100644 drivers/clk/sprd/pll.h
>  create mode 100644 drivers/clk/sprd/sc9860-clk.c
>  create mode 100644 include/dt-bindings/clock/sprd,sc9860-clk.h
>
> --
> 2.7.4
>
