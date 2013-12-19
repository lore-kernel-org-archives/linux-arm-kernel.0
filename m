From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Thu, 19 Dec 2013 16:06:17 -0500
Subject: [RFC] pwm: Add Freescale FTM PWM driver support
References: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <87eh58zh2u.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On  2 Dec 2013, Li.Xiubo at freescale.com wrote:

> The FTM PWM device can be found on Vybrid VF610 Tower and
> Layerscape LS-1 SoCs.

[snip]

> In Vybird VF610 Tower, all the IP blocks expect LE data. In the LS-1, some of
> the IP blocks expect LE data, while others expect BE data. And the CPU always
> operates in LE mode in these two platforms.

[snip]

> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc, void __iomem *reg)
> +{
> +	u32 val;
> +
> +	val = __raw_readl(reg);
> +
> +	if (fpc->endianess == FTM_BIG)
> +		return be32_to_cpu(val);
> +	else
> +		return le32_to_cpu(val);
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 val,
> +		void __iomem *reg)
> +{
> +	if (fpc->endianess == FTM_BIG)
> +		val = cpu_to_be32(val);
> +	else
> +		val = cpu_to_le32(val);
> +
> +	__raw_writel(val, reg);
> +}

Remove above and alter as below,

static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
				enum pwm_polarity polarity)
{
	u32 val;
	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);

	val = readl(fpc, fpc->base + FTM_POL);
	if (polarity == PWM_POLARITY_INVERSED)
-		val |= BIT(pwm->hwpwm);
+		val |= BIT(fpc->chn_bit);
	else
-		val &= ~BIT(pwm->hwpwm);
+		val &= ~BIT(fpc->chn_bit);
	writel(fpc, val, fpc->base + FTM_POL);

	return 0;
}
 
static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
{
	int ret;
	u32 val;

	if (fpc->counter_clk_enable++)
		return 0;

	ret = clk_prepare_enable(fpc->counter_clk);
	if (ret) {
		fpc->counter_clk_enable--;
		return ret;
	}

	val = readl(fpc, fpc->base + FTM_SC);
+	val |= val >> 24; /* get value on big-endian. */
	val &= ~((FTM_SC_CLK_MASK << FTM_SC_CLK_SHIFT) |
			(FTM_SC_PS_MASK << FTM_SC_PS_SHIFT));

	/* select counter clock source */
	switch (fpc->counter_clk_select) {
	case VF610_CLK_FTM0:
		val |= FTM_SC_CLK_SYS;
		break;
	case VF610_CLK_FTM0_FIX_SEL:
		val |= FTM_SC_CLK_FIX;
		break;
	case VF610_CLK_FTM0_EXT_SEL:
		val |= FTM_SC_CLK_EXT;
		break;
	default:
		fpc->counter_clk_enable--;
		return -EINVAL;
	}

	val |= fpc->clk_ps;
+	val |= val << 24; /* modify to high byte for big-endian. */
	writel(fpc, val, fpc->base + FTM_SC);

	return 0;
}

That is instead of modifying the low level accessor, you can alter the
driver masks based on the OF selected endian.  Many of the registers are
already accessed as run-time fields because each channel is in a
different bit position.  There are only two registers with fields that
cross a byte boundary; COUNT and MOD.  These two must be swapped.  The
others are either a byte or are accessed base on a channel number.

For example in fsl_pwm_set_polarity(), we would read the memory, swap
the value, calculate a bit to set, clear or set the bit and then write
back the swapped value all on the 'big_endian' condition.  This way, you
just read a bit shift which is conditional on the endian at probe time
and don't double swap.

In the fsl_counter_clock_enable(), the example is using 'write ignored
bits' and duplicating the value in both big/little bytes.  An
alternative is to parameterize all the mask/values in 'const struct' and
have a different pointer for big/little and store this in-place (or via
a pointer) in fsl_pwm_chip.

Fwiw,
Bill Pringlemeir.
