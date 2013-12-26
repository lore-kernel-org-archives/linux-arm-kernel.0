From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Thu, 26 Dec 2013 09:11:36 +0000
Subject: [RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <87eh58zh2u.fsf@nbsps.com>
References: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>
 <87eh58zh2u.fsf@nbsps.com>
Message-ID: <fd88a38d1bf247149c43d8b418b0553d@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc, void __iomem *reg)
> > +{
> > +	u32 val;
> > +
> > +	val = __raw_readl(reg);
> > +
> > +	if (fpc->endianess == FTM_BIG)
> > +		return be32_to_cpu(val);
> > +	else
> > +		return le32_to_cpu(val);
> > +}
> > +
> > +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 val,
> > +		void __iomem *reg)
> > +{
> > +	if (fpc->endianess == FTM_BIG)
> > +		val = cpu_to_be32(val);
> > +	else
> > +		val = cpu_to_le32(val);
> > +
> > +	__raw_writel(val, reg);
> > +}
> 
> Remove above and alter as below,
> 
> static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> 				enum pwm_polarity polarity)
> {
> 	u32 val;
> 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> 
> 	val = readl(fpc, fpc->base + FTM_POL);
> 	if (polarity == PWM_POLARITY_INVERSED)
> -		val |= BIT(pwm->hwpwm);
> +		val |= BIT(fpc->chn_bit);
> 	else
> -		val &= ~BIT(pwm->hwpwm);
> +		val &= ~BIT(fpc->chn_bit);
> 	writel(fpc, val, fpc->base + FTM_POL);
> 
> 	return 0;
> }
> 
> static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
> {
> 	int ret;
> 	u32 val;
> 
> 	if (fpc->counter_clk_enable++)
> 		return 0;
> 
> 	ret = clk_prepare_enable(fpc->counter_clk);
> 	if (ret) {
> 		fpc->counter_clk_enable--;
> 		return ret;
> 	}
> 
> 	val = readl(fpc, fpc->base + FTM_SC);
> +	val |= val >> 24; /* get value on big-endian. */
> 	val &= ~((FTM_SC_CLK_MASK << FTM_SC_CLK_SHIFT) |
> 			(FTM_SC_PS_MASK << FTM_SC_PS_SHIFT));
> 
> 	/* select counter clock source */
> 	switch (fpc->counter_clk_select) {
> 	case VF610_CLK_FTM0:
> 		val |= FTM_SC_CLK_SYS;
> 		break;
> 	case VF610_CLK_FTM0_FIX_SEL:
> 		val |= FTM_SC_CLK_FIX;
> 		break;
> 	case VF610_CLK_FTM0_EXT_SEL:
> 		val |= FTM_SC_CLK_EXT;
> 		break;
> 	default:
> 		fpc->counter_clk_enable--;
> 		return -EINVAL;
> 	}
> 
> 	val |= fpc->clk_ps;
> +	val |= val << 24; /* modify to high byte for big-endian. */
> 	writel(fpc, val, fpc->base + FTM_SC);
> 
> 	return 0;
> }
> 
> That is instead of modifying the low level accessor, you can alter the
> driver masks based on the OF selected endian.  Many of the registers are
> already accessed as run-time fields because each channel is in a
> different bit position.  There are only two registers with fields that
> cross a byte boundary; COUNT and MOD.  These two must be swapped.  The
> others are either a byte or are accessed base on a channel number.
> 
> For example in fsl_pwm_set_polarity(), we would read the memory, swap
> the value, calculate a bit to set, clear or set the bit and then write
> back the swapped value all on the 'big_endian' condition.  This way, you
> just read a bit shift which is conditional on the endian at probe time
> and don't double swap.
> 
> In the fsl_counter_clock_enable(), the example is using 'write ignored
> bits' and duplicating the value in both big/little bytes.  An
> alternative is to parameterize all the mask/values in 'const struct' and
> have a different pointer for big/little and store this in-place (or via
> a pointer) in fsl_pwm_chip.
> 

Yes, this is one optional method.

The PWM is only one feature of the FlexTimer Module, and in the future there
will implements all of them, and then there will be many other bits that cross
a byte position. And now the fsl_pwm_readl()/fsl_pwm_writel() are just copied
from readl()/writel(), and then added the endianess arbitration.

And there are many other IP blocks like FTM need to do same work for LS-1 series
and Vybird machines. IMO, this is more readable and easier to extern to full
functions for these device driver code, and also easier to debug.

Thanks,
Best Regards,
Xiubo
