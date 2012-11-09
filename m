From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Nov 2012 09:11:04 +0100
Subject: [PATCH v2 08/10] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
In-Reply-To: <1352361197-27442-9-git-send-email-avinashphilip@ti.com>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
 <1352361197-27442-9-git-send-email-avinashphilip@ti.com>
Message-ID: <20121109081104.GB26007@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 01:23:15PM +0530, Philip, Avinash wrote:
> Some platforms (like AM33XX) requires clock gating from control module
> explicitly for TBCLK. Enabling of this clock required for the
> functioning of the time base sub module in EHRPWM module. So adding
> optional TBCLK handling if DT node populated with tbclkgating. This
> helps the driver can coexist for Davinci platforms.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Cc:	Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> ---
> Changes since v1:
> 	- Moved TBCLK enable from probe to .pwm_enable & disable from
> 	  remove to .pwm_disable
> 
> :100644 100644 07911e6... 927a8ed... M	drivers/pwm/pwm-tiehrpwm.c
>  drivers/pwm/pwm-tiehrpwm.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 07911e6..927a8ed 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -126,6 +126,7 @@ struct ehrpwm_pwm_chip {
>  	void __iomem	*mmio_base;
>  	unsigned long period_cycles[NUM_PWM_CHANNEL];
>  	enum pwm_polarity polarity[NUM_PWM_CHANNEL];
> +	struct	clk	*tbclk;
>  };
>  
>  static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
> @@ -346,6 +347,13 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	/* Channels polarity can be configured from action qualifier module */
>  	configure_polarity(pc, pwm->hwpwm);
>  
> +	/*
> +	 * Platforms require explicit clock enabling of TBCLK has
> +	 * to enable TBCLK explicitly before enabling PWM device
> +	 */
> +	if (pc->tbclk)
> +		clk_enable(pc->tbclk);
> +
>  	/* Enable time counter for free_run */
>  	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
>  	return 0;
> @@ -374,6 +382,10 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
>  
> +	/* Disabling TBCLK on PWM disable */
> +	if (pc->tbclk)
> +		clk_disable(pc->tbclk);
> +
>  	/* Stop Time base counter */
>  	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
>  
> @@ -464,6 +476,16 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>  		return ret;
>  	}
> +
> +	/* Some platforms require explicit tbclk gating */
> +	if (of_property_read_bool(pdev->dev.of_node, "tbclkgating")) {

Is it really necessary to have an extra boolean property for this?
Couldn't this just be handled by not defining a clock for the tbclk
consumer in board setup/DT

> +		pc->tbclk = clk_get(&pdev->dev, "tbclk");

You should be using devm_clk_get() or add a matching clk_put() in
.remove().

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/288ac5fd/attachment.sig>
