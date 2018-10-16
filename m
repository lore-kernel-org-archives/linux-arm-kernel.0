From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Oct 2018 14:25:08 +0200
Subject: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
In-Reply-To: <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20181016122508.GH8852@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
> Add basic PWM modes: normal and complementary. These modes should
> differentiate the single output PWM channels from two outputs PWM
> channels. These modes could be set as follow:
> 1. PWM channels with one output per channel:
> - normal mode
> 2. PWM channels with two outputs per channel:
> - normal mode
> - complementary mode
> Since users could use a PWM channel with two output as one output PWM
> channel, the PWM normal mode is allowed to be set for PWM channels with
> two outputs; in fact PWM normal mode should be supported by all PWMs.
> 
> The PWM capabilities were implemented per PWM channel. Every PWM controller
> will register a function to get PWM capabilities. If this is not explicitly
> set by the driver a default function will be used to retrieve the PWM
> capabilities (in this case the PWM capabilities will contain only PWM
> normal mode). This function is set in pwmchip_add_with_polarity() as a
> member of "struct pwm_chip". To retrieve capabilities the pwm_get_caps()
> function could be used.
> 
> Every PWM channel have associated a mode in the PWM state. Proper
> support was added to get/set PWM mode. The mode could also be set
> from DT via flag cells. The valid DT modes are located in
> include/dt-bindings/pwm/pwm.h. Only modes supported by PWM channel could be
> set. If nothing is specified for a PWM channel, via DT, the first available
> mode will be used (normally, this will be PWM normal mode).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/core.c  | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++
>  include/linux/pwm.h |  39 +++++++++++++++++
>  3 files changed, 221 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6ab1b1f..59a9df9120de 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -136,6 +136,7 @@ struct pwm_device *
>  of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>  {
>  	struct pwm_device *pwm;
> +	int modebit;
>  
>  	/* check, whether the driver supports a third cell for flags */
>  	if (pc->of_pwm_n_cells < 3)
> @@ -154,9 +155,23 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>  
>  	pwm->args.period = args->args[1];
>  	pwm->args.polarity = PWM_POLARITY_NORMAL;
> +	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
>  
> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> -		pwm->args.polarity = PWM_POLARITY_INVERSED;
> +	if (args->args_count > 2) {
> +		if (args->args[2] & PWM_POLARITY_INVERTED)
> +			pwm->args.polarity = PWM_POLARITY_INVERSED;
> +
> +		for (modebit = PWMC_MODE_COMPLEMENTARY_BIT;
> +		     modebit < PWMC_MODE_CNT; modebit++) {
> +			unsigned long mode = BIT(modebit);
> +
> +			if ((args->args[2] & mode) &&
> +			    pwm_mode_valid(pwm, mode)) {
> +				pwm->args.mode = mode;
> +				break;
> +			}
> +		}
> +	}
>  
>  	return pwm;
>  }
> @@ -183,6 +198,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
>  		return pwm;
>  
>  	pwm->args.period = args->args[1];
> +	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
>  
>  	return pwm;
>  }
> @@ -250,6 +266,97 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
>  }
>  
>  /**
> + * pwm_get_caps() - get PWM capabilities of a PWM device
> + * @chip: PWM chip
> + * @pwm: PWM device to get the capabilities for
> + * @caps: returned capabilities
> + *
> + * Returns: 0 on success or a negative error code on failure
> + */
> +int pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
> +		 struct pwm_caps *caps)
> +{
> +	if (!chip || !pwm || !caps)
> +		return -EINVAL;
> +
> +	if (chip->ops && chip->ops->get_caps)
> +		pwm->chip->ops->get_caps(chip, pwm, caps);
> +	else if (chip->get_default_caps)
> +		chip->get_default_caps(caps);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwm_get_caps);

I'm confused by the way ->get_default_caps() is used here. This always
points at pwmchip_get_default_caps() if I understand correctly, so why
bother with the indirection?

I think it would be better to either export pwmchip_get_default_caps()
as a default implementation of ->get_caps(), something like:

	void pwm_get_default_caps(struct pwm_chip *chip, struct pwm_device *pwm,
				  struct pwm_caps *caps)
	{
		...
	}
	EXPORT_SYMBOL_GPL(pwm_get_default_caps);

This could be used by the individual drivers as the implementation if
they don't support any modes.

Another, probably simpler approach would be to just get rid of the
chip->get_default_caps() pointer and directly call
pwmchip_get_default_caps() from pwm_get_caps():

	int pwm_get_caps(...)
	{
		/*
		 * Note that you don't need the check for chip->ops because
		 * the core checks for that upon registration of the chip.
		 */
		if (chip->ops->get_caps)
			return chip->ops->get_caps(...);

		return pwm_get_default_caps(...);
	}

And if we do that, might as well fold pwm_get_default_caps() into
pwm_get_caps().

> +/**
> + * pwm_mode_get_valid() - get the first available valid mode for PWM
> + * @chip: PWM chip
> + * @pwm: PWM device to get the valid mode for
> + *
> + * Returns: first valid mode for PWM device
> + */
> +unsigned long pwm_mode_get_valid(struct pwm_chip *chip, struct pwm_device *pwm)

This is a little ambiguous. Perhaps pwm_get_default_mode()?

> +/**
> + * pwm_mode_valid() - check if mode is valid for PWM device
> + * @pwm: PWM device
> + * @mode: PWM mode to check if valid
> + *
> + * Returns: true if mode is valid and false otherwise
> + */
> +bool pwm_mode_valid(struct pwm_device *pwm, unsigned long mode)

Again, this is slightly ambiguous because the name suggests that it
merely tests a mode for validity, not that it is really supported by the
given device. Perhaps something like pwm_supports_mode()?

> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
> +{
> +	static const char * const modes[] = {
> +		"invalid",
> +		"normal",
> +		"complementary",
> +	};
> +
> +	if (!pwm_mode_valid(pwm, mode))
> +		return modes[0];
> +
> +	return modes[ffs(mode)];
> +}

Do we really need to be able to get the name of the mode in the context
of a given PWM channel? Couldn't we drop the pwm parameter and simply
return the name (pwm_get_mode_name()?) and at the same time remove the
extra "invalid" mode in there? I'm not sure what the use-case here is,
but it seems to me like the code should always check for supported modes
first before reporting their names in any way.

> +/**
>   * pwmchip_add_with_polarity() - register a new PWM chip
>   * @chip: the PWM chip to add
>   * @polarity: initial polarity of PWM channels
> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  
>  	mutex_lock(&pwm_lock);
>  
> +	chip->get_default_caps = pwmchip_get_default_caps;
> +
>  	ret = alloc_pwms(chip->base, chip->npwm);
>  	if (ret < 0)
>  		goto out;
> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  		pwm->pwm = chip->base + i;
>  		pwm->hwpwm = i;
>  		pwm->state.polarity = polarity;
> +		pwm->state.mode = pwm_mode_get_valid(chip, pwm);
>  
>  		if (chip->ops->get_state)
>  			chip->ops->get_state(chip, pwm, &pwm->state);
> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  	int err;
>  
>  	if (!pwm || !state || !state->period ||
> -	    state->duty_cycle > state->period)
> +	    state->duty_cycle > state->period ||
> +	    !pwm_mode_valid(pwm, state->mode))
>  		return -EINVAL;
>  
>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  
>  			pwm->state.enabled = state->enabled;
>  		}
> +
> +		/* No mode support for non-atomic PWM. */
> +		pwm->state.mode = state->mode;

That comment seems misplaced. This is actually part of atomic PWM, so
maybe just reverse the logic and say "mode support only for atomic PWM"
or something. I would personally just leave it away. The legacy API has
no way of setting the mode, which is indication enough that we don't
support it.

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 56518adc31dd..a4ce4ad7edf0 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -26,9 +26,32 @@ enum pwm_polarity {
>  };
>  
>  /**
> + * PWM modes capabilities
> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
> + * @PWMC_MODE_CNT: PWM modes count
> + */
> +enum {
> +	PWMC_MODE_NORMAL_BIT,
> +	PWMC_MODE_COMPLEMENTARY_BIT,
> +	PWMC_MODE_CNT,
> +};
> +
> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)

Why the C in the prefix? Why not just PWM_MODE_* for all of the above?

> +
> +/**
> + * struct pwm_caps - PWM capabilities
> + * @modes: PWM modes

This should probably say that it's a bitmask of PWM_MODE_*.

> +struct pwm_caps {
> +	unsigned long modes;
> +};
> +
> +/**
>   * struct pwm_args - board-dependent PWM arguments
>   * @period: reference period
>   * @polarity: reference polarity
> + * @mode: reference mode

As discussed in my reply to the cover letter, what is the use for the
reference mode? Drivers want to use either normal or some other mode.
What good is it to get this from board-dependent arguments if the
driver already knows which one it wants or needs?

> @@ -300,6 +331,7 @@ struct pwm_chip {
>  
>  	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>  					const struct of_phandle_args *args);
> +	void (*get_default_caps)(struct pwm_caps *caps);

As mentioned above, I don't think we need this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181016/c246c189/attachment.sig>
