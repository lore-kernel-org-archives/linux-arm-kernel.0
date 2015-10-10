From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 9 Oct 2015 17:21:06 -0700
Subject: [PATCH 05/10] clk: iproc: Add PLL base write function
In-Reply-To: <1443826665-17570-6-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-6-git-send-email-jonmason@broadcom.com>
Message-ID: <20151010002106.GZ26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02, Jon Mason wrote:
> diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
> index e029ab3..a4602aa 100644
> --- a/drivers/clk/bcm/clk-iproc-pll.c
> +++ b/drivers/clk/bcm/clk-iproc-pll.c
> @@ -137,6 +137,18 @@ static int pll_wait_for_lock(struct iproc_pll *pll)
>  	return -EIO;
>  }
>  
> +static void iproc_pll_write(struct iproc_pll *pll, void __iomem *base,
> +			    u32 offset, u32 val)
> +{
> +	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
> +
> +	writel(val, base + offset);
> +
> +	if (unlikely(ctrl->flags & IPROC_CLK_NEEDS_READ_BACK &&
> +		     base == pll->pll_base))
> +		val = readl(base + offset);

Is there any point to assign val here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
