From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 29 Aug 2011 15:07:47 +0200
Subject: [PATCH 3/3] arm: mxs: disable clock-gates when setting saif-clocks
In-Reply-To: <1313946314-3891-1-git-send-email-b29396@freescale.com>
References: <1313946314-3891-1-git-send-email-b29396@freescale.com>
Message-ID: <20110829130747.GL24524@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 01:05:14AM +0800, Dong Aisheng wrote:
> From: Dong Aisheng-B29396 <B29396@freescale.com>

Please take care of the correct author when sending out patches from other
people. Doesn't harm here since it was an RFC.

> New divides should only be written when gates are off.
> 
> Reported-by: Dong Aisheng <b29396@freescale.com>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> ---
> BTW, i did a minus change based on wolfram's patch or the saif will
> not work.
> 
> Change
> +       __raw_writel(clkgate, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs##_SET); \
> to
> +       __raw_writel(reg & ~clkgate,
> 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs##_SET); \

Huh? Luckily you are not really using _SET below otherwise you would have set
all other bits except the one we captured. Will have a look at this.

> It seemed HW_CLKCTRL_##rs##_SET did not work well.
> (i did not find HW_CLKCTRL_SAIFx_SET in spec).
> ---
>  arch/arm/mach-mxs/clock-mx28.c        |    7 +++++--
>  arch/arm/mach-mxs/regs-clkctrl-mx28.h |    2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 2a2db65..d1d119a 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -438,7 +438,7 @@ _CLK_SET_RATE1(xbus_clk, XBUS)
>  static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  {									\
>  	u16 div;							\
> -	u32 reg;							\
> +	u32 reg, clkgate;						\
>  	u64 lrate;							\
>  	unsigned long parent_rate;					\
>  	int i;								\
> @@ -455,7 +455,8 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  		return -EINVAL;						\
>  									\
>  	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> -	reg &= ~BM_CLKCTRL_##rs##_DIV;					\
> +	clkgate = reg & BM_CLKCTRL_##rs##_CLKGATE;			\
> +	reg &= ~(BM_CLKCTRL_##rs##_DIV | BM_CLKCTRL_##rs##_CLKGATE);	\
>  	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
>  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  									\
> @@ -468,6 +469,8 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  		return -ETIMEDOUT;					\
>  	}								\
>  									\
> +	__raw_writel(reg & ~clkgate,					\
> +			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  	return 0;							\
>  }

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110829/145743e4/attachment.sig>
