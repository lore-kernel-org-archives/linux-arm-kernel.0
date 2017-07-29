From: moore@free.fr (Chris Moore)
Date: Sat, 29 Jul 2017 09:55:52 +0200
Subject: [PATCH v2 4/4] clk: meson: gxbb-aoclk: Add CEC 32k clock
In-Reply-To: <1501235589-318-5-git-send-email-narmstrong@baylibre.com>
References: <1501235589-318-1-git-send-email-narmstrong@baylibre.com>
 <1501235589-318-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <184320f7-e131-d7b7-f917-34cf12279740@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 28/07/2017 ? 11:53, Neil Armstrong a ?crit :

[snip]

> +static long aoclk_cec_32k_round_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long *prate)
> +{
> +	const struct cec_32k_freq_table *freq = find_cec_32k_freq(rate,
> +								  *prate);
> +
> +	/* If invalid return first one */
> +	if (!freq)
> +		return freq[0].target_rate;

Wouldn't this dereference a null pointer (or am I being stupid this 
morning)?

> +
> +	return freq->target_rate;
> +}
> +
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
> +	if (freq->dualdiv)
> +		reg = CLK_CNTL0_DUALDIV_EN |
> +		      FIELD_PREP(CLK_CNTL0_N1_MASK, freq->n1 - 1) |
> +		      FIELD_PREP(CLK_CNTL0_N2_MASK, freq->n2 - 1);
> +	else
> +		reg = FIELD_PREP(CLK_CNTL0_N1_MASK, freq->n1 - 1);
> +

Suggestion:

+	reg = FIELD_PREP(CLK_CNTL0_N1_MASK, freq->n1 - 1);
+	if (freq->dualdiv)
+		reg |= CLK_CNTL0_DUALDIV_EN |
+		       FIELD_PREP(CLK_CNTL0_N2_MASK, freq->n2 - 1);

is shorter but maybe generates the same code.

> +	regmap_write(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0, reg);
> +
> +	if (freq->dualdiv)
> +		reg = FIELD_PREP(CLK_CNTL1_M1_MASK, freq->m1 - 1) |
> +		      FIELD_PREP(CLK_CNTL1_M2_MASK, freq->m2 - 1);
> +	else
> +		reg = FIELD_PREP(CLK_CNTL1_M1_MASK, freq->m1 - 1);
> +

Idem:

+	reg = FIELD_PREP(CLK_CNTL1_M1_MASK, freq->m1 - 1);
+	if (freq->dualdiv)
+		reg |= FIELD_PREP(CLK_CNTL1_M2_MASK, freq->m2 - 1);

Cheers,
Chris
