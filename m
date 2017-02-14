From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Feb 2017 10:58:19 +0100
Subject: [PATCH 4/5] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <20170214033526.16977-5-wens@csie.org>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-5-wens@csie.org>
Message-ID: <20170214095819.utsftcvti5zdmlmi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 11:35:25AM +0800, Chen-Yu Tsai wrote:
> +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */

Is that even working?

I'm not quite sure we want to do that. We might model it as a NP clock
with a variable prediv?

> +/* Use a separate clock for the pre-divider on the AHB1 PLL-PERIPH input */
> +static SUNXI_CCU_M(pll_periph_ahb1_clk, "pll-periph-ahb1", "pll-periph",
> +		   0x054, 6, 2, 0);
> +
> +static const char * const ahb1_parents[] = { "osc16M-d512", "osc24M",
> +					     "pll-periph-ahb1",
> +					     "pll-periph-ahb1" };
> +static struct ccu_div ahb1_clk = {
> +	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(12, 2),
> +	.common		= {
> +		.reg		= 0x054,
> +		.hw.init	= CLK_HW_INIT_PARENTS("ahb1",
> +						      ahb1_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};

What's different from a pre divider only for a given index here?

> +/*
> + * MMC2 supports what's called the "new timing mode". The CCU and the MMC
> + * controller must be in sync about which mode is used. The new mode moves
> + * the clock delay controls (and possibly the delay lines) into the MMC
> + * block. Also, the output of the clock is divided by 2. The output and
> + * sample phase clocks are unused under this mode.
> + *
> + * This new mode seems to be preferred. Hence we force this clock to the
> + * new mode. And we don't add the phase clocks.
> + */

I'm sorry, but I said this several times, this isn't working. We
should model it properly, and not hack this around in the clock
driver.

As you say in your comment, the MMC driver needs to be aware about
which mode is used, in order to also set a bit in one of its registers
accordingly, and modify its sampling behaviour.

The new timing is preferred, but our previous clock implementations
didn't hardcode it, so we can't even rely on that behaviour to always
write it in our driver.

This is not something specific to the A83T, but is found in all the
SoCs since the A23, so we need to come up with a good solution to
address that.

I'm not sure what a good solution would be though. One would be to
just have a private function of our own to switch in the new mode (if
relevant, because only the MMC2 controllers have it), but that would
lead to troubles with !sunxi-ng. Not something we can't deal with, but
some extra precautions should be taken (make sure to protect the call
through an ifdef / IS_DEFINED, check that the sunxi-ng driver has been
probed, etc.)

Or we could introduce a new clk_ops function pointer, but I'm not sure
if Mike and Stephen are going to be happy with that.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/8bfdcb83/attachment-0001.sig>
