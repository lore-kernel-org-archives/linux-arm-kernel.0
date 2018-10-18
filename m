From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 18 Oct 2018 17:32:50 +0200
Subject: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
In-Reply-To: <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
 <20181016122508.GH8852@ulmo>
 <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
Message-ID: <20181018153250.GC6226@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:42:00PM +0000, Claudiu.Beznea at microchip.com wrote:
> On 16.10.2018 15:25, Thierry Reding wrote:
> > On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
[...]
> >> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
> >> +{
> >> +	static const char * const modes[] = {
> >> +		"invalid",
> >> +		"normal",
> >> +		"complementary",
> >> +	};
> >> +
> >> +	if (!pwm_mode_valid(pwm, mode))
> >> +		return modes[0];
> >> +
> >> +	return modes[ffs(mode)];
> >> +}
> > 
> > Do we really need to be able to get the name of the mode in the context
> > of a given PWM channel? Couldn't we drop the pwm parameter and simply
> > return the name (pwm_get_mode_name()?) and at the same time remove the
> > extra "invalid" mode in there? I'm not sure what the use-case here is,
> > but it seems to me like the code should always check for supported modes
> > first before reporting their names in any way.
> 
> Looking back at this code, the main use case for checking PWM mode validity
> in pwm_mode_desc() was only with regards to mode_store(). But there is not
> need for this checking since the same thing will be checked in
> pwm_apply_state() and, in case user provides an invalid mode via sysfs the
> pwm_apply_state() will fail.
> 
> To conclude, I will change this function in something like:
> 
> if (mode == PWM_MODE_NORMAL)
> 	return "normal";
> else if (mode == PWM_MODE_COMPLEMENTARY)
> 	return "complementary";
> else if (mode == PWM_MODE_PUSH_PULL)
> 	return "push-pull";
> else
> 	return "invalid";
> 
> Please let me know if it is OK for you.

Do we even have to check here for validity of the mode in the first
place? Shouldn't this already happen at a higher level? I mean we do
need to check for valid input in mode_store(), but whatever mode we
pass into this could already have been validated, so that this would
never return "invalid".

For example, you already define an enum for the PWM modes. I think it'd
be best if we then used that enum to pass the modes around. That way it
becomes easy to check for validity.

So taking one step back, I think we can remove some of the ambiguities
by making sure we only ever specify one mode. When the mode is
explicitly being set, we only ever want one, right? The only point in
time where we can store more than one is for the capabilities. So I
think being more explicit about that would be useful. That way we remove
any uncertainties about what the unsigned long might contain at any
point in time.

> >> +/**
> >>   * pwmchip_add_with_polarity() - register a new PWM chip
> >>   * @chip: the PWM chip to add
> >>   * @polarity: initial polarity of PWM channels
> >> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> >>  
> >>  	mutex_lock(&pwm_lock);
> >>  
> >> +	chip->get_default_caps = pwmchip_get_default_caps;
> >> +
> >>  	ret = alloc_pwms(chip->base, chip->npwm);
> >>  	if (ret < 0)
> >>  		goto out;
> >> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> >>  		pwm->pwm = chip->base + i;
> >>  		pwm->hwpwm = i;
> >>  		pwm->state.polarity = polarity;
> >> +		pwm->state.mode = pwm_mode_get_valid(chip, pwm);
> >>  
> >>  		if (chip->ops->get_state)
> >>  			chip->ops->get_state(chip, pwm, &pwm->state);
> >> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
> >>  	int err;
> >>  
> >>  	if (!pwm || !state || !state->period ||
> >> -	    state->duty_cycle > state->period)
> >> +	    state->duty_cycle > state->period ||
> >> +	    !pwm_mode_valid(pwm, state->mode))
> >>  		return -EINVAL;
> >>  
> >>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
> >> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
> >>  
> >>  			pwm->state.enabled = state->enabled;
> >>  		}
> >> +
> >> +		/* No mode support for non-atomic PWM. */
> >> +		pwm->state.mode = state->mode;
> > 
> > That comment seems misplaced. This is actually part of atomic PWM, so
> > maybe just reverse the logic and say "mode support only for atomic PWM"
> > or something. I would personally just leave it away.
> 
> Ok, sure. I will remove the comment. But the code has to be there to avoid
> unassigned mode value for PWM state (normal mode means BIT(0)) and so to
> avoid future PWM applies failure.

Oh yeah, definitely keep the code around. I was only commenting on
the... comment. =)

> The legacy API has
> > no way of setting the mode, which is indication enough that we don't
> > support it.
> > 
> >> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> >> index 56518adc31dd..a4ce4ad7edf0 100644
> >> --- a/include/linux/pwm.h
> >> +++ b/include/linux/pwm.h
> >> @@ -26,9 +26,32 @@ enum pwm_polarity {
> >>  };
> >>  
> >>  /**
> >> + * PWM modes capabilities
> >> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
> >> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
> >> + * @PWMC_MODE_CNT: PWM modes count
> >> + */
> >> +enum {
> >> +	PWMC_MODE_NORMAL_BIT,
> >> +	PWMC_MODE_COMPLEMENTARY_BIT,
> >> +	PWMC_MODE_CNT,
> >> +};
> >> +
> >> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)
> > 
> > Why the C in the prefix? Why not just PWM_MODE_* for all of the above?
> 
> Well... PWM_MODE() macro was already took by pwm-sun4i.c driver at the time
> I wrote this patch... So I choose to add extra C to this macro, "C" meaning
> "constant" in my mind. I was not sure it was the best solution at that time
> either.

We can always rename definitions in drivers if we want to use
conflicting names in the core. In this particular case, and given what I
said above regarding the PWM mode definitions, I think it'd be better to
drop the _BIT suffix from the enum values, so that we get something like
this:

	enum pwm_mode {
		PWM_MODE_NORMAL,
		PWM_MODE_COMPLEMENTARY,
		PWM_MODE_COUNT
	};

Then in order to create the actual bitmasks we can use a macro that is
explicit about creating bitmasks:

	#define PWM_MODE_MASK(name) BIT(PWM_MODE_##name##)

With that, the conflict with pwm-sun4i conveniently goes away.

> >> +struct pwm_caps {
> >> +	unsigned long modes;
> >> +};
> >> +
> >> +/**
> >>   * struct pwm_args - board-dependent PWM arguments
> >>   * @period: reference period
> >>   * @polarity: reference polarity
> >> + * @mode: reference mode
> > 
> > As discussed in my reply to the cover letter, what is the use for the
> > reference mode? Drivers want to use either normal or some other mode.
> > What good is it to get this from board-dependent arguments if the
> > driver already knows which one it wants or needs?
> 
> For the moment, no, there is no in-kernel user. Only sysfs. I was thinking
> I would also adapt, e.g., the pwm-regulator driver to also make use of this
> features in setups like the one described in [1], page 2126
> (Figure 56-13: Half-Bridge Converter Application: No Feedback Regulation).
> But, for the moment there is no in-kernel user.
> 
> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

Okay, so that means we don't have any use-cases where we even need the
mode in DT? If so, I don't think we should add that code yet. We'd be
adding an ABI that we don't know how it will be used or if it is even
sufficient. Granted, as long as nobody uses it we could probably just
silently drop it again, but why risk if it's just dead code anyway.

If I understand the half-bridge converter application correctly you
would want to model that with pwm-regulator and instead of using a
regular PWM (normal mode) you'd use a PWM_MODE_PUSH_PULL instead. Is
that really all there is to support this? Does the voltage output of
the half-bridge converter vary linearly with the duty-cycle? I suppose
one could always combine the push-pull PWM with a voltage table to make
it work. I'm not opposed to the idea, just trying to figure out if the
pwm-regulator driver would be viable or whether there are other things
we need to make these setups work.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/222faa94/attachment-0001.sig>
