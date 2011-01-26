From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 26 Jan 2011 16:58:58 +0100
Subject: [PATCH] ARM: mxs: fix clock base address missing
In-Reply-To: <1296080796-10896-1-git-send-email-shawn.guo@freescale.com>
References: <1296080796-10896-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110126155858.GP9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 06:26:36AM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c |    2 +-
>  arch/arm/mach-mxs/clock-mx28.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index b1a362e..a0296a4 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -347,7 +347,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
>  {									\
>  	if (parent != clk->parent) {					\
>  		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
> -			 HW_CLKCTRL_CLKSEQ_TOG);			\
> +			 CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
>  		clk->parent = parent;					\
>  	}								\
>  									\

While at it you could also add some parameter checking to this function.
Implemented like this it behaves rather randomly.

Sascha

> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 56312c0..44c1754 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -483,7 +483,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
>  {									\
>  	if (parent != clk->parent) {					\
>  		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
> -			 HW_CLKCTRL_CLKSEQ_TOG);			\
> +			 CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
>  		clk->parent = parent;					\
>  	}								\
>  									\
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
