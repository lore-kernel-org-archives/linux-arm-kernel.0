From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 11:09:45 +0200
Subject: [PATCH 02/11] clk: sunxi-ng: Add interface to query or configure
 MMC timing modes.
In-Reply-To: <20170714064302.20383-3-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-3-wens@csie.org>
Message-ID: <20170717090945.qh2uekguzgv5lo36@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 14, 2017 at 02:42:53PM +0800, Chen-Yu Tsai wrote:
> Starting with the A83T SoC, Allwinner introduced a new timing mode for
> its MMC clocks. The new mode changes how the MMC controller sample and
> output clocks are delayed to match chip and board specifics. There are
> two controls for this, one on the CCU side controlling how the clocks
> behave, and one in the MMC controller controlling what inputs to take
> and how to route them.
> 
> In the old mode, the MMC clock had 2 child clocks providing the output
> and sample clocks, which could be delayed by a number of clock cycles
> measured from the MMC clock's parent.
> 
> With the new mode, the 2 delay clocks are no longer active. Instead,
> the delays and associated controls are moved into the MMC controller.
> The output of the MMC clock is also halved.
> 
> The difference in how things are wired between the modes means that the
> clock controls and the MMC controls must match. To achieve this in a
> clear, explicit way, we introduce two functions for the MMC driver to
> use: one queries the hardware for the current mode set, and the other
> allows the MMC driver to request a mode.
> 
> With newer SoCs such as the A64, the old mode is all but removed. Hence
> we support two variations, one where the mode can be toggled, and the
> other where the clock is fixed in the new mode.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/Makefile         |  1 +
>  drivers/clk/sunxi-ng/ccu_common.h     |  2 +
>  drivers/clk/sunxi-ng/ccu_mmc_timing.c | 73 +++++++++++++++++++++++++++++++++++
>  include/linux/clk/sunxi-ng.h          | 20 ++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_mmc_timing.c
>  create mode 100644 include/linux/clk/sunxi-ng.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 0c45fa50283d..45a5910379a5 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -1,5 +1,6 @@
>  # Common objects
>  lib-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
> +lib-$(CONFIG_SUNXI_CCU)		+= ccu_mmc_timing.o
>  lib-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
>  
>  # Base clock types
> diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
> index d6fdd7a789aa..88981e7fd978 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -23,6 +23,8 @@
>  #define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
>  #define CCU_FEATURE_ALL_PREDIV		BIT(4)
>  #define CCU_FEATURE_LOCK_REG		BIT(5)
> +#define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
> +#define CCU_FEATURE_MMC_ALWAYS_NEW	BIT(7)

I'm not really sure we need the ALWAYS_NEW bit here. In the case where
the clocks cannot operate in the old mode any more, we won't even
query the clocks, since we know that it's not needed at all.

Pretty much just like what we're doing for old-mode-only clocks at the
moment.

I guess the only thing we should indentify is whether the clock can
switch between the two, or not, and the MMC_TIMING_SWITCH bit is
already perfect for that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/035a6d82/attachment-0001.sig>
