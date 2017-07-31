From: moore@free.fr (Chris Moore)
Date: Mon, 31 Jul 2017 18:25:19 +0200
Subject: [PATCH v3 4/4] clk: meson: gxbb-aoclk: Add CEC 32k clock
In-Reply-To: <1501504957-19476-5-git-send-email-narmstrong@baylibre.com>
References: <1501504957-19476-1-git-send-email-narmstrong@baylibre.com>
 <1501504957-19476-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <37b45bd4-e3bf-1a1f-7b8c-fb1919042072@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 31/07/2017 ? 14:42, Neil Armstrong a ?crit :
> The CEC 32K AO Clock is a dual divider with dual counter to provide a more
> precise 32768Hz clock for the CEC subsystem from the external xtal.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/clk/meson/Makefile         |   2 +-
>   drivers/clk/meson/gxbb-aoclk-32k.c | 194 +++++++++++++++++++++++++++++++++++++
>   drivers/clk/meson/gxbb-aoclk.c     |  21 +++-
>   drivers/clk/meson/gxbb-aoclk.h     |  16 +++
>   4 files changed, 231 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
>
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index de65427..b139d41 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -4,4 +4,4 @@
>   
>   obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-divider.o
>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
> -obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o
> +obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o gxbb-aoclk-32k.o
> diff --git a/drivers/clk/meson/gxbb-aoclk-32k.c b/drivers/clk/meson/gxbb-aoclk-32k.c

[snip]

> +static int aoclk_cec_32k_set_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long parent_rate)
> +{
> +	const struct cec_32k_freq_table *freq = find_cec_32k_freq(rate,
> +								  parent_rate);
> +	struct aoclk_cec_32k *cec_32k = to_aoclk_cec_32k(hw);
> +	u32 reg = 0;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	/* Disable clock */
> +	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
> +			   CLK_CNTL0_IN_GATE_EN | CLK_CNTL0_OUT_GATE_EN, 0);
> +
> +	reg = FIELD_PREP(CLK_CNTL0_N1_MASK, freq->n1 - 1);
> +	if (freq->dualdiv)
> +		reg |= CLK_CNTL0_DUALDIV_EN |
> +		       FIELD_PREP(CLK_CNTL0_N2_MASK, freq->n2 - 1);
> +
> +	regmap_write(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0, reg);
> +
> +	reg = FIELD_PREP(CLK_CNTL1_M1_MASK, freq->m1 - 1);
> +	if (freq->dualdiv)
> +		reg = FIELD_PREP(CLK_CNTL1_M2_MASK, freq->m2 - 1);

s/=/|=/

Cheers,
Chris
