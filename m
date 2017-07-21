From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 09:18:10 +0200
Subject: [PATCH v2 01/10] clk: sunxi-ng: Add interface to query or
 configure MMC timing modes.
In-Reply-To: <20170720034452.15920-2-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-2-wens@csie.org>
Message-ID: <20170721071810.7nlwdzqno56cdax3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 20, 2017 at 11:44:43AM +0800, Chen-Yu Tsai wrote:
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
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/Makefile         |  1 +
>  drivers/clk/sunxi-ng/ccu_common.h     |  5 +++
>  drivers/clk/sunxi-ng/ccu_mmc_timing.c | 73 +++++++++++++++++++++++++++++++++++
>  include/linux/clk/sunxi-ng.h          | 35 +++++++++++++++++
>  4 files changed, 114 insertions(+)
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
> index d6fdd7a789aa..1e2761c53f06 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -23,6 +23,11 @@
>  #define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
>  #define CCU_FEATURE_ALL_PREDIV		BIT(4)
>  #define CCU_FEATURE_LOCK_REG		BIT(5)
> +#define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
> +#define CCU_FEATURE_MMC_ALWAYS_NEW	BIT(7)

Didn't we agree on removing that flag?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170721/74ea5ca1/attachment.sig>
