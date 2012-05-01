From: mturquette@ti.com (Mike Turquette)
Date: Tue, 1 May 2012 15:48:32 -0700
Subject: [PATCH] clk: Fix error handling paths of all basic clock
 register() routines
In-Reply-To: <c65c7006185c193706b401b874b59e3769f593b0.1334029502.git.viresh.kumar@st.com>
References: <c65c7006185c193706b401b874b59e3769f593b0.1334029502.git.viresh.kumar@st.com>
Message-ID: <20120501224832.GB17311@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120410-09:24, Viresh Kumar wrote:
> This fixes following in error handling paths of register() routines of all basic
> clock types:
> - Free memory for clock type, allocated with kmalloc or kzalloc if
>   clk_register() fails.
> - No, need to free memory for clock type, if allocation fails for it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/clk/clk-divider.c      |    2 +-
>  drivers/clk/clk-fixed-factor.c |    2 +-
>  drivers/clk/clk-fixed-rate.c   |   25 ++++++++++++++++++++-----
>  drivers/clk/clk-gate.c         |    2 +-
>  drivers/clk/clk-mux.c          |    8 +++++++-
>  5 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index d5ac6a7..68158ce 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -192,8 +192,8 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>  	if (clk)
>  		return clk;
>  
> -out:
>  	kfree(div->parent[0]);
> +out:
>  	kfree(div);
>  
>  	return NULL;

Hi Viresh,

My apologies for taking so long to get back to you on this.  This patch
completely fell through the cracks.

Anyways my clk-next branch refactored this code and does The Right Thing
now, so I won't be taking this patch.

Thanks,
Mike
