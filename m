From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Mar 2016 15:01:49 -0700
Subject: [PATCH v5 34/46] clk: pwm: switch to the atomic API
In-Reply-To: <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160330220149.GU18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30, Boris Brezillon wrote:
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index ebcd738..49ec5b1 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
>  static int clk_pwm_prepare(struct clk_hw *hw)
>  {
>  	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
> +	struct pwm_state pstate;
>  
> -	return pwm_enable(clk_pwm->pwm);
> +	pwm_get_state(clk_pwm->pwm, &pstate);
> +	if (pstate.enabled)
> +		return 0;
> +
> +	pstate.enabled = true;
> +
> +	return pwm_apply_state(clk_pwm->pwm, &pstate);

This doesn't seem atomic anymore if we're checking the state and
then not calling apply_state if it's already enabled. But I
assume this doesn't matter because we "own" the pwm here?
Otherwise I would think this would be unconditional apply state
and duplicates would be ignored in the pwm framework.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
