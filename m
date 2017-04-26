From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Apr 2017 10:36:34 +0800
Subject: [PATCH] clk: sunxi-ng: Fix dependency on sunxi_gate
In-Reply-To: <20170425171209.6229-1-clabbe.montjoie@gmail.com>
References: <20170425171209.6229-1-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v66b_R0-Ua4HsSf+7id+CPAtc+ori3jxKFS8tWHicgg38g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Subject should say CCU_GATE, not sunxi_gate, which doesn't exist.

On Wed, Apr 26, 2017 at 1:12 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> When CONFIG_SUNXI_CCU is set but no other SUNXI_CCU is selected i got
> the following build error:
> drivers/built-in.o: In function `ccu_pll_notifier_cb':
> drivers/clk/sunxi-ng/ccu_common.c:71: undefined reference to `ccu_gate_helper_disable'
> drivers/clk/sunxi-ng/ccu_common.c:73: undefined reference to `ccu_gate_helper_enable'
>
> The problem is the function ccu_pll_notifier_cb in ccu_common.c need
> some function from ccu_gate.c which is not compiled since SUNXI_CCU_GATE
> is not selected.
>
> This patch remove SUNXI_CCU_GATE and compile ccu_gate.c unconditionnaly
> since all other combination of options select SUNXI_CCU_GATE finally.

I think it's worth keeping SUNXI_CCU_GATE a separate Kconfig symbol,
and selecting it from SUNXI_CCU.

I think the new helpers aren't in the best place they should be, and
keeping the symbols would make moving them easier. Plus we have symbols
for all the other base types. Keeping it keeps the symmetry there.

Regards
ChenYu


> Fixes: 02ae2bc6febd ("clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig  | 11 -----------
>  drivers/clk/sunxi-ng/Makefile |  2 +-
>  2 files changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 8bee225..d7842f9 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -15,9 +15,6 @@ config SUNXI_CCU_DIV
>  config SUNXI_CCU_FRAC
>         bool
>
> -config SUNXI_CCU_GATE
> -       bool
> -
>  config SUNXI_CCU_MUX
>         bool
>
> @@ -32,24 +29,19 @@ config SUNXI_CCU_PHASE
>
>  config SUNXI_CCU_NK
>         bool
> -       select SUNXI_CCU_GATE
>
>  config SUNXI_CCU_NKM
>         bool
> -       select SUNXI_CCU_GATE
>
>  config SUNXI_CCU_NKMP
>         bool
> -       select SUNXI_CCU_GATE
>
>  config SUNXI_CCU_NM
>         bool
>         select SUNXI_CCU_FRAC
> -       select SUNXI_CCU_GATE
>
>  config SUNXI_CCU_MP
>         bool
> -       select SUNXI_CCU_GATE
>         select SUNXI_CCU_MUX
>
>  # SoC Drivers
> @@ -119,7 +111,6 @@ config SUN8I_A33_CCU
>  config SUN8I_A83T_CCU
>         bool "Support for the Allwinner A83T CCU"
>         select SUNXI_CCU_DIV
> -       select SUNXI_CCU_GATE
>         select SUNXI_CCU_NKMP
>         select SUNXI_CCU_NM
>         select SUNXI_CCU_MP
> @@ -154,7 +145,6 @@ config SUN9I_A80_CCU
>         bool "Support for the Allwinner A80 CCU"
>         select SUNXI_CCU_DIV
>         select SUNXI_CCU_MULT
> -       select SUNXI_CCU_GATE
>         select SUNXI_CCU_NKMP
>         select SUNXI_CCU_NM
>         select SUNXI_CCU_MP
> @@ -165,7 +155,6 @@ config SUN9I_A80_CCU
>  config SUN8I_R_CCU
>         bool "Support for Allwinner SoCs' PRCM CCUs"
>         select SUNXI_CCU_DIV
> -       select SUNXI_CCU_GATE
>         default MACH_SUN8I || (ARCH_SUNXI && ARM64)
>
>  endif
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 78028c8..52aab41 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -1,11 +1,11 @@
>  # Common objects
>  obj-$(CONFIG_SUNXI_CCU)                += ccu_common.o
>  obj-$(CONFIG_SUNXI_CCU)                += ccu_reset.o
> +obj-$(CONFIG_SUNXI_CCU)                += ccu_gate.o
>
>  # Base clock types
>  obj-$(CONFIG_SUNXI_CCU_DIV)    += ccu_div.o
>  obj-$(CONFIG_SUNXI_CCU_FRAC)   += ccu_frac.o
> -obj-$(CONFIG_SUNXI_CCU_GATE)   += ccu_gate.o
>  obj-$(CONFIG_SUNXI_CCU_MUX)    += ccu_mux.o
>  obj-$(CONFIG_SUNXI_CCU_MULT)   += ccu_mult.o
>  obj-$(CONFIG_SUNXI_CCU_PHASE)  += ccu_phase.o
> --
> 2.10.2
>
