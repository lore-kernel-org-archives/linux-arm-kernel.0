From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 13:07:01 +0900
Subject: [RESEND PATCH] ARM: SAMSUNG: Add s3c_setparent_clksrc in
 s3c_set_clksrc
In-Reply-To: <1323829221-14171-1-git-send-email-jhbird.choi@samsung.com>
References: <1323829221-14171-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <061a01ccbf95$fe1e6960$fa5b3c20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jhbird.choi at samsung.com wrote:
> 
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Currently we have to run clk_set_parent to change clock source.
> But if there are sources & parent defined, it means we will select a
> parent
> in multiple clock sources. So sources & parent are already defined,
> set the parent clock int s3c_set_clksrc.
> Then we can reduce many clk_set_parent function in driver or setup_clock
> function.
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  arch/arm/plat-samsung/clock-clksrc.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-
> samsung/clock-clksrc.c
> index ae8b850..61dfe0d 100644
> --- a/arch/arm/plat-samsung/clock-clksrc.c
> +++ b/arch/arm/plat-samsung/clock-clksrc.c
> @@ -140,6 +140,14 @@ void __init_or_cpufreq s3c_set_clksrc(struct
> clksrc_clk *clk, bool announce)
>  		return;
>  	}
> 
> +	if (clk->sources && clk->clk.parent) {
> +		if (s3c_setparent_clksrc(&clk->clk, clk->clk.parent)) {
> +			printk(KERN_ERR "%s: bad source is %s\n",
> +					clk->clk.name, clk->clk.parent->name);
> +			return;
> +		}
> +	}
> +
>  	clksrc = __raw_readl(clk->reg_src.reg);
>  	clksrc &= mask;
>  	clksrc >>= clk->reg_src.shift;
> --
> 1.7.1

Hmm, I think, this  is not good. If there is a mux which includes clock sources, as you know, its parent clock can be selected
according to the value of reg_src and it should be changed by calling clk_set_parent() even though this can help in some kind of
view. And the clksrc_clk depends on SoC not board so the clk.parent cannot be fixed at the clock.c file.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
