From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Nov 2014 06:17:22 +0100
Subject: [RFC PATCH] clk: mvebu: armada-xp: Support for MSYS SoC
In-Reply-To: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <20141120051722.GC2596@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 06:01:19PM +1300, Chris Packham wrote:
> The MSYS SoCs are a range of packet processors with integrated CPUs based
> on armada-xp. One difference is that the TCLK frequency is fixed at 200MHz
> as opposed to the fixed 250MHz used on armada-xp. The clock-gating options
> are a subset of what's available on the armada-xp so this code should be
> compatible.

Hi Chris

How generic/specific is the name msys? We need to be careful here,
because there could be other packet processors with embedded Armada-XP
cores with different tclk speeds. Rather than using msys, it might be
better to use the specific packet processor product ID.

Whatever we call it, this new compatibility string also needs adding
to the device tree binding document in 

Documentation/devicetree/bindings/clock/mvebu-core-clock.txt

> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Hi,
> 
> This patch is enough to get the uart clock dividers correct so I get some
> output. As far as I've been able to tell there is no way of dynamically
> detecting the TCLK frequency.
> 
> The core clock frequency and ratio calculations are probably not correct but
> for these CPU inside a packet processor systems I'm not sure how much that
> actually matter since these systems aren't likely to do any kind of dynamic
> frequency scaling.

Do you have u-boot running? It generally prints out these frequencies.
You can at least verify if they are {in}consistent with Linux. If you
have the u-boot sources, you might also be able to use it get these
clocks right in Linux.

       Andrew

> 
> Thansk,
> Chris
> 
>  drivers/clk/mvebu/armada-xp.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
> index b309431..9f852f8 100644
> --- a/drivers/clk/mvebu/armada-xp.c
> +++ b/drivers/clk/mvebu/armada-xp.c
> @@ -52,6 +52,12 @@ static u32 __init axp_get_tclk_freq(void __iomem *sar)
>  	return 250000000;
>  }
>  
> +/* MSYS TCLK frequency is fixed to 200MHz */
> +static u32 __init msys_get_tclk_freq(void __iomem *sar)
> +{
> +	return 200000000;
> +}
> +
>  static const u32 axp_cpu_freqs[] __initconst = {
>  	1000000000,
>  	1066000000,
> @@ -158,6 +164,14 @@ static const struct coreclk_soc_desc axp_coreclks = {
>  	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
>  };
>  
> +static const struct coreclk_soc_desc msys_coreclks = {
> +	.get_tclk_freq = msys_get_tclk_freq,
> +	.get_cpu_freq = axp_get_cpu_freq,
> +	.get_clk_ratio = axp_get_clk_ratio,
> +	.ratios = axp_coreclk_ratios,
> +	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
> +};
> +
>  /*
>   * Clock Gating Control
>   */
> @@ -200,9 +214,13 @@ static void __init axp_clk_init(struct device_node *np)
>  	struct device_node *cgnp =
>  		of_find_compatible_node(NULL, NULL, "marvell,armada-xp-gating-clock");
>  
> -	mvebu_coreclk_setup(np, &axp_coreclks);
> +	if (of_device_is_compatible(np, "marvell,msys-core-clock"))
> +		mvebu_coreclk_setup(np, &msys_coreclks);
> +	else
> +		mvebu_coreclk_setup(np, &axp_coreclks);
>  
>  	if (cgnp)
>  		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
>  }
>  CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
> +CLK_OF_DECLARE(msys_clk, "marvell,msys-core-clock", axp_clk_init);
> -- 
> 2.2.0.rc0
> 
