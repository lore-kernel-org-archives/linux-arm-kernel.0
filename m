From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Aug 2010 14:30:19 +0900
Subject: [PATCH v3] ARM: Samsung SoC: clksrc-clk: wait for the stable
	SRC/DIV status.
In-Reply-To: <1280717476-32327-1-git-send-email-myungjoo.ham@samsung.com>
References: <1280717476-32327-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <003001cb3203$ce869bd0$6b93d370$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Many MUX and clock dividers have a status bit so that users can wait
> until the status is stable. When corresponding registers are accessed
> while a clock is not stable, we may suffer from unexpected errors.
> 
> Therefore, we introduce a mechanism to let the operations related with
> updating SRC/DIV registers of clksrc-clk wait for the stabilization:
> clk_set_parent, clk_set_rate.
> 
> In order to use this feature, the definition of clksrc_clk should
> include reg_src_stable or reg_div_stable. With effective rec_src_stable
> values, clk_set_parent returns with a stabilized SRC register and
> with effective rec_div_stable values, clk_set_rate returns with a
> stabilized DIV register. If .reg field is null, its (either SRC or DIV)
> register's status is not checked and returned without waiting; i.e.,
> some MUX/DIV may not need this feature.
> 
> When setting reg_*_stable, .size is used to tell the value of "stable".
> If .size = 0, the stable status is 0 and if .size = 1, the stable status
> is 1.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> --
> v2:
> 	- Wait-for-stable loop is described at an inline function.
> v3:
> 	- Stop using clksrc_reg for stable bits. Use "clkstat_reg" for
> 	  them.
> 
> ---
>  arch/arm/plat-samsung/clock-clksrc.c              |   14 +++++++++++++
>  arch/arm/plat-samsung/include/plat/clock-clksrc.h |   22
> +++++++++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/clock-clksrc.c
b/arch/arm/plat-samsung/clock-
> clksrc.c
> index 46d204a..79ae92e 100644
> --- a/arch/arm/plat-samsung/clock-clksrc.c
> +++ b/arch/arm/plat-samsung/clock-clksrc.c
> @@ -50,6 +50,15 @@ static unsigned long s3c_getrate_clksrc(struct clk
*clk)
>  	return rate;
>  }
> 
> +static inline void s3c_wait_for_stable(struct clkstat_reg *stat)
> +{
> +	WARN_ON(stat == NULL);

if (stat == NULL)
	return;

If don't need to check status, have not become define relevant status
register.

> +	if (stat->reg) {

No need?...or need to check stat->reg and stat->shift?

> +		do { } while (((__raw_readl(stat->reg) >> stat->shift) & 1)
> +				!= stat->stable);

I'm still wondering we _really_ need 'stable'...just comments is enough,
right now.

> +		do { } while (((__raw_readl(stat->reg) >> stat->shift) & 1)
> +				!= stat->stable);

> +	}
> +}
> +
>  static int s3c_setrate_clksrc(struct clk *clk, unsigned long rate)
>  {
>  	struct clksrc_clk *sclk = to_clksrc(clk);
> @@ -68,6 +77,8 @@ static int s3c_setrate_clksrc(struct clk *clk, unsigned
long rate)
>  	val |= (div - 1) << sclk->reg_div.shift;
>  	__raw_writel(val, reg);
> 
> +	s3c_wait_for_stable(&sclk->reg_div_stable);
> +
>  	return 0;
>  }
> 
> @@ -93,6 +104,9 @@ static int s3c_setparent_clksrc(struct clk *clk, struct
clk
> *parent)
>  		clksrc |= src_nr << sclk->reg_src.shift;
> 
>  		__raw_writel(clksrc, sclk->reg_src.reg);
> +
> +		s3c_wait_for_stable(&sclk->reg_src_stable);
> +
>  		return 0;
>  	}
> 
> diff --git a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
b/arch/arm/plat-
> samsung/include/plat/clock-clksrc.h
> index 50a8ca7..f1d54da 100644
> --- a/arch/arm/plat-samsung/include/plat/clock-clksrc.h
> +++ b/arch/arm/plat-samsung/include/plat/clock-clksrc.h
> @@ -40,11 +40,30 @@ struct clksrc_reg {
>  };
> 
>  /**
> + * struct clkstat_reg - register definition for clock stat bits
> + * @reg: pointer to the register in virtual memory.
> + * @shift: the shift in bits to where the bitfield is.
> + * @stable: the bit value of stable status.
> + */
> +struct clkstat_reg {
> +	void __iomem		*reg;
> +	unsigned short		shift;
> +	unsigned short		stable;

If you want to use this, just 'value' is better.
But...I think...we don't need this field now.

> +};
> +
> +/**
>   * struct clksrc_clk - class of clock for newer style samsung devices.
>   * @clk: the standard clock representation
>   * @sources: the sources for this clock
>   * @reg_src: the register definition for selecting the clock's source
>   * @reg_div: the register definition for the clock's output divisor
> + * @reg_src_stable: the register definition to probe if reg_src is
> + *    stabilized after the update of reg_src. It is "stabilized" if
> + *    reg[shift] == size. If reg == NULL, this stable reg is not looked
> + *    up. Thus, in S5PV210, size is usually 0.
> + * @reg_div_stable: the register definition to probe if reg_div is
> + *    stabilized after the update of reg_div. Same mechanism with
> + *    reg_src_stable.
>   *
>   * This clock implements the features required by the newer SoCs where
>   * the standard clock block provides an input mux and a post-mux divisor
> @@ -61,6 +80,9 @@ struct clksrc_clk {
> 
>  	struct clksrc_reg	reg_src;
>  	struct clksrc_reg	reg_div;
> +
> +	struct clkstat_reg	reg_src_stable;
> +	struct clkstat_reg	reg_div_stable;
>  };
> 
>  /**
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
