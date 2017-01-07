From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Sat, 7 Jan 2017 16:49:18 +0100
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <20161125002852.18097-1-megous@megous.com>
References: <20161125002852.18097-1-megous@megous.com>
Message-ID: <0985b1ec-ba95-1505-cc59-adec4b88238f@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

Dne 25.11.2016 v 01:28 megous at megous.com napsal(a):
> From: Ondrej Jirman <megous@megous.com>
> 
> When adjusting PLL_CPUX on H3, the PLL is temporarily driven
> too high, and the system becomes unstable (oopses or hangs).
> 
> Add a notifier to avoid this situation by temporarily switching
> to a known stable 24 MHz oscillator.

I have done more thorough testing on H3 and this approach with switching
to 24MHz oscillator does not work. Motivation being that my Orange Pi
One still gets lockups even with this patch under certain circumstances.

So I have created a small test program for CPUS (additional OpenRISC CPU
on the SoC) which randomly changes PLL_CPUX settings while main CPU is
running a loop that sends messages to CPUS via msgbox.

Assumption being that while CPUS is successfully receiving messages via
msgbox, the main CPU didn't lock up, yet.

With this I am able to quickly and thoroughly test various PLL_CPUX
change and factor selection algorithms.

Results are that bypassing CPUX clock by switching to 24 MHz oscillator
does not work at all. Main CPU locks up in about 1 second into the test.
Don't ask me why.

What works is selecting NKMP factors so that M is always 1 and P is
anything other than /1 only for frequencies under 288MHz. As mandated by
the H3 datasheet. Mainline ccu_nkmp_find_best doesn't respect these
conditions. With that I can change CPUX frequencies randomly 20x a
second so far indefinitely without the main CPU ever locking up.

Please drop or revert this patch. It is not a correct approach to the
problem. I'd suggest dropping the entire clock notifier mechanism, too,
unless it can be proven to work reliably. The bypass makes some
intuitive sense, but for some reason it doesn't work in practice (on H3
at least).

Aside from this, uboot also needs to be changed to set that it uses M
and P factors correctly.

Whatever else I try, I always hit lockups sooner or later with the test
program. I tried 24MHz bypass and staged application of multipliers and
dividers as discussed before.

I'll send a proper patch for nkmp clock driver and u-boot later.

regards,
  o.

> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Tested-by: Lutz Sammer <johns98@gmx.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> index 614d47c..cf266c9 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -809,6 +809,13 @@ static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
>  	.num_resets	= ARRAY_SIZE(sun8i_h3_ccu_resets),
>  };
>  
> +static struct ccu_mux_nb sun8i_h3_cpu_nb = {
> +	.common		= &cpux_clk.common,
> +	.cm		= &cpux_clk.mux,
> +	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
> +	.bypass_index	= 1, /* index of 24 MHz oscillator */
> +};
> +
>  static void __init sun8i_h3_ccu_setup(struct device_node *node)
>  {
>  	void __iomem *reg;
> @@ -827,6 +834,9 @@ static void __init sun8i_h3_ccu_setup(struct device_node *node)
>  	writel(val | (3 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
>  
>  	sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
> +
> +	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
> +				  &sun8i_h3_cpu_nb);
>  }
>  CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
>  	       sun8i_h3_ccu_setup);
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170107/ecd3a56f/attachment-0001.sig>
