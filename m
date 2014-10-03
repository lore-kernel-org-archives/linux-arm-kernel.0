From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 03 Oct 2014 11:07:58 -0700
Subject: [PATCH v2 04/15] clk: divider: Make generic for usage elsewhere
In-Reply-To: <1409957256-23729-5-git-send-email-sboyd@codeaurora.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
 <1409957256-23729-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <542EE5FE.9080806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/14 15:47, Stephen Boyd wrote:
> +
> +int divider_get_val(unsigned long rate, unsigned long parent_rate,
> +		    const struct clk_div_table *table, u8 width,
> +		    unsigned long flags)
> +{
>  	unsigned int div, value;
> -	unsigned long flags = 0;
> -	u32 val;
>  
>  	div = DIV_ROUND_UP(parent_rate, rate);
>  
> -	if (!_is_valid_div(divider, div))
> +	if (!_is_valid_div(table, div, flags))
>  		return -EINVAL;
>  
> -	value = _get_val(divider, div);
> +	value = _get_val(table, div, flags);
> +
> +	min_t(unsigned int, value, div_mask(width));
> +
> +	return 0;

This should be return value, not return 0.

> +}
> +EXPORT_SYMBOL_GPL(divider_get_val);
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
