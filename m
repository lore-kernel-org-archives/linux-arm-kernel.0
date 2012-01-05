From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jan 2012 21:53:13 +0800
Subject: [PATCH 2/2] arm/imx6q: add cko1 clock
In-Reply-To: <1325733074-10749-2-git-send-email-richard.zhao@linaro.org>
References: <1325733074-10749-1-git-send-email-richard.zhao@linaro.org>
 <1325733074-10749-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120105135311.GF1729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 11:11:14AM +0800, Richard Zhao wrote:
> imx6q-sabrelite board use it as audio codec clock.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/mach-imx/clock-imx6q.c |   74 ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 73 insertions(+), 1 deletions(-)
> 
It mostly looks good.  A couple of comments below though:

* Again, use "ARM: imx6q: ..." for patch subject in this case.

* To reflect the CKO hardware hierarchy, we should probably have 3 clks
  there, cko_clk, cko1_clk and cko2_clk, and have cko_clk be the parent
  of the later two, as cko1_cko2_sel bit was designed for this.

[...]

> @@ -1680,7 +1734,7 @@ static int _clk_set_parent(struct clk *clk, struct clk *parent)
>  			break;
>  		i++;
>  	}
> -	if (!m->parents[i])
> +	if (!m->parents[i] || m->parents[i] == &dummy_clk)

Is this change necessarily included in this patch?

Regards,
Shawn

>  		return -EINVAL;
>  
>  	val = readl_relaxed(m->reg);
