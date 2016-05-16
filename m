From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 16 May 2016 15:47:39 +0200
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160516154739.d87e0a9891a7fb5fed051a89@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  8 May 2016 22:01:50 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Add the list of clocks and resets found in the H3 CCU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile        |   2 +
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 757 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
>  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
>  4 files changed, 1024 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
>  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index c794f57b6fb1..67ff6a92f124 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -13,3 +13,5 @@ obj-y += ccu_nkmp.o
>  obj-y += ccu_nm.o
>  obj-y += ccu_p.o
>  obj-y += ccu_phase.o
> +
> +obj-y += ccu-sun8i-h3.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> new file mode 100644
> index 000000000000..5ce699e95c32
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -0,0 +1,757 @@
	[snip]
> +static struct ccu_nm pll_audio_base_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +
> +	.m		= SUNXI_CLK_FACTOR(0, 5),
> +	.n		= SUNXI_CLK_FACTOR(8, 7),
> +
> +	.common		= {
> +		.reg		= 0x008,
> +		.features	= CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
> +		.hw.init	= SUNXI_HW_INIT("pll-audio-base",
> +						"osc24M",
> +						&ccu_nm_ops,
> +						0),
> +	},
> +};
> +
> +static SUNXI_CCU_M(pll_audio_clk, "pll-audio", "pll-audio-base",
> +		   0x008, 16, 4, 0);
> +
> +static SUNXI_CCU_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
> +			      "pll-audio-base", 2, 1, 0);
> +static SUNXI_CCU_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
> +			      "pll-audio-base", 1, 1, 0);
> +static SUNXI_CCU_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
> +			      "pll-audio-base", 1, 2, 0);
> +
	[snip]

The pll-audio-{2,4,8}x clocks lack the CLK_SET_RATE_PARENT.

Also, in my implementation of the sound on HDMI, I set pll-audio as the
parent of the i2s2 clock. Then, as the pll-audio clock is defined here,
setting its rate is always wrong (only 'M' is changed, and with a bad
value - BTW, DIV_ROUND_UP would be welcome in ccu_m_find_best()).

As the pre-divider 'M' is set to 4 by default, there is no need to
change it. Then, audio works fine for me with:

static SUNXI_CCU_FIXED_FACTOR(pll_audio, "pll-audio",
			      "pll-audio-base", 4, 1,
				CLK_SET_RATE_PARENT);

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
