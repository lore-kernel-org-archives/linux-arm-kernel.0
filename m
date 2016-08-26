From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 00:25:23 +0200
Subject: [PATCH 2/2] pwm: sunxi: Yield some time to the pwm-block to
 become ready
In-Reply-To: <1472147411-30424-3-git-send-email-oliver@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-3-git-send-email-oliver@schinagl.nl>
Message-ID: <20160826222523.GH3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 07:50:11PM +0200, Olliver Schinagl wrote:
> From: Olliver Schinagl <o.schinagl@ultimaker.com>
> 
> The pwm-block of some of the sunxi chips feature a 'ready' flag to
> indicate the software that it is ready for new commands.
> 
> Right now, when we call pwm_config and set the period, we write the
> values to the registers, and turn off the clock to the IP. Because of
> this, the hardware does not have time to configure the hardware and set
> the 'ready' flag.
> 
> By running the clock just before making new changes and before checking
> if the hardware is ready, the hardware has time to reconfigure itself
> and set the clear the flag appropriately.
> 
> Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 5e97c8a..dd198c3 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -105,6 +105,22 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u64 clk_rate, div = 0;
>  	unsigned int prescaler = 0;
>  	int err;
> +	int ret = 0;
> +
> +	/* Let the PWM hardware run before making any changes. We do this to
> +	 * allow the hardware to have some time to clear the 'ready' flag.
> +	 */

This is not the proper comment style.

> +	err = clk_prepare_enable(sun4i_pwm->clk);
> +	if (err) {
> +		dev_err(chip->dev, "failed to enable PWM clock\n");
> +		return err;
> +	}

New line please.

> +	spin_lock(&sun4i_pwm->ctrl_lock);
> +	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);

What are you doing here? You clear a bit, and then put the same one
back in?

> +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +	spin_unlock(&sun4i_pwm->ctrl_lock);
>  
>  	clk_rate = clk_get_rate(sun4i_pwm->clk);
>  
> @@ -137,7 +153,9 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  		if (div - 1 > PWM_PRD_MASK) {
>  			dev_err(chip->dev, "period exceeds the maximum value\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			spin_lock(&sun4i_pwm->ctrl_lock);

Uh? That's really suspicious. And even if right, please don't do that,
this is just really bad for the comprehension of the workflow.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/f7e46b13/attachment-0001.sig>
