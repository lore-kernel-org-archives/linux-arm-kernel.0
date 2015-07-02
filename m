From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 2 Jul 2015 09:43:19 +0200
Subject: [RFC PATCH 13/15] pwm: rockchip: add support for atomic update
In-Reply-To: <1709826.dVqTms8REP@diego>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-14-git-send-email-boris.brezillon@free-electrons.com>
 <1709826.dVqTms8REP@diego>
Message-ID: <20150702094319.11794da8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wed, 01 Jul 2015 23:48:31 +0200
Heiko St?bner <heiko@sntech.de> wrote:

> Hi Boris,
> 
> 
> Am Mittwoch, 1. Juli 2015, 10:21:59 schrieb Boris Brezillon:
> > Implement the ->apply() function to add support for atomic update.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > @@ -110,6 +113,26 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip
> > *chip, writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> >  }
> > 
> > +static void rockchip_pwm_init_v2(struct pwm_chip *chip, struct pwm_device
> > *pwm) +{
> > +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> > +	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
> > +			  PWM_CONTINUOUS;
> > +	u32 val;
> > +
> > +	val = readl(pc->base + pc->data->regs.ctrl);
> > +
> > +	if ((val & enable_conf) != enable_conf)
> > +		return;
> > +
> > +	pwm->state.enabled = true;
> > +
> > +	enable_conf = PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> > +
> > +	if ((val & enable_conf) == enable_conf)
> > +		pwm->state.polarity = PWM_POLARITY_INVERSED;
> 
> the inactive setting does not affect the polarity of the running pwm, only what 
> to do when it gets turned off. Also PWM_DUTY_NEGATIVE is the "0" value for the 
> bit so also is bad to compare against (and results in wrong readings). So I 
> would suggest changing this like

Indeed

> 
> -       enable_conf = PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> +       enable_conf = PWM_DUTY_POSITIVE;
>  
> -       if ((val & enable_conf) == enable_conf)
> +       if ((val & enable_conf) != enable_conf)

Or just:

	if(val & PWM_DUTY_POSITIVE)


Thanks for the fix.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
