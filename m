From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 12 Dec 2011 12:23:53 +0200
Subject: [PATCH] ARM: OMAP: mcbsp: Fix possible memory corruption
In-Reply-To: <1323679106-4191-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1323678976-4119-1-git-send-email-jarkko.nikula@bitmer.com>
 <1323679106-4191-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <4EE5D639.8080608@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/11 10:38, Jarkko Nikula wrote:
> Commits 09d28d ("ARM: OMAP: mcbsp: Start generalize omap2_mcbsp_set_clks_src")
> and 7bc0c4 ("ARM: OMAP: mcbsp: Start generalize signal muxing functions")
> incorrectly set two struct omap_mcbsp_platform_data fields after
> omap_device_build_ss and kfree calls.
> 
> Fix this by moving these pdata assignments before those calls.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Reported-by: neilb at suse.de

Perhaps, should be:
Reported-by: NeilBrown <neilb@suse.de>
and
Cc: <stable@vger.kernel.org>	[3.1]
as for below.

> ---
> For 3.2, 3.1 is ok.
> ---
>  arch/arm/mach-omap2/mcbsp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 292eee3..28fcb27 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -145,6 +145,9 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
>  		pdata->reg_size = 4;
>  		pdata->has_ccr = true;
>  	}
> +	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
> +	if (id == 1)
> +		pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
>  
>  	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
>  		if (id == 2)
> @@ -174,9 +177,6 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
>  					name, oh->name);
>  		return PTR_ERR(pdev);
>  	}
> -	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
> -	if (id == 1)
> -		pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
>  	omap_mcbsp_count++;
>  	return 0;
>  }

-- 
Regards,
Igor.
