From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jul 2017 15:51:30 -0700
Subject: [PATCH v2 4/5] clk: qcom: gcc-msm8996: Mark
 gcc_mmss_noc_cfg_ahb_clk as a critical clock
In-Reply-To: <1500526099-9935-5-git-send-email-rnayak@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
 <1500526099-9935-5-git-send-email-rnayak@codeaurora.org>
Message-ID: <20170727225130.GQ2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Rajendra Nayak wrote:
> we have gcc_mmss_noc_cfg_ahb_clk marked with a CLK_IGNORE_UNUSED. While
> this can prevent it from being disabled while its unused, it does not
> prevent it from being disabled when a child derived from the clock calls
> an explicit enable/disable.

Do you mean the config_noc_clk_src is being disabled? Who is
getting this clk? The bus driver? In the downstream sources I
don't even see this clk exposed, so maybe we should just remove
support for it instead.

> Mark this with a CLK_IS_CRITICAL and remove the CLK_IGNORE_UNUSED flag
> so its never disabled.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8996.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
> index 8abc200..8872985 100644
> --- a/drivers/clk/qcom/gcc-msm8996.c
> +++ b/drivers/clk/qcom/gcc-msm8996.c
> @@ -1333,7 +1333,7 @@ enum {
>  			.name = "gcc_mmss_noc_cfg_ahb_clk",
>  			.parent_names = (const char *[]){ "config_noc_clk_src" },
>  			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
