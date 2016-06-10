From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 17:21:09 +0200
Subject: [PATCH v2 01/13] pwm: Add new helpers to create/manipulate PWM
 states
In-Reply-To: <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160610152109.GQ27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 06:34:36PM +0200, Boris Brezillon wrote:
> The pwm_prepare_new_state() helper prepares a new state object
> containing the current PWM state except for the polarity and period
> fields which are set to the reference values.
> This is particurly useful for PWM users who want to apply a new
> duty-cycle expressed relatively to the reference period without
> changing the enable state.
> 
> The PWM framework expect PWM users to configure the duty cycle in
> nanosecond, but most users just want to express this duty cycle
> relatively to the period value (i.e. duty_cycle = 33% of the period).
> Add pwm_{get,set}_relative_duty_cycle() helpers to ease this kind of
> conversion.

This looks pretty useful and good, though I think these could be two
separate patches. A couple of suggestions on wording and such below.

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/pwm.h | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 17018f3..e09babf 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -148,6 +148,87 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
>  }
>  
>  /**
> + * pwm_prepare_new_state() - prepare a new state to be applied with
> + *			     pwm_apply_state()

This is weirdly indented.

> + * @pwm: PWM device
> + * @state: state to fill with the prepared PWM state
> + *
> + * This functions prepares a state that can later be tweaked and applied
> + * to the PWM device with pwm_apply_state(). This is a convenient function
> + * that first retrieves the current PWM state and the replaces the period
> + * and polarity fields with the reference values defined in pwm->args.
> + * Once the new state is created you can adjust the ->enable and ->duty_cycle

"created" has the connotation of allocating. Perhaps: "Once the function
returns, you can adjust the ->enabled and ->duty_cycle fields according
to your needs before calling pwm_apply_state()."?

Also note that the field is called ->enabled.

> + * according to your need before calling pwm_apply_state().

Maybe mention that the ->duty_cycle field is explicitly zeroed. Then
again, do we really need it? If users are going to overwrite it anyway,
do we even need to bother? I suppose it makes some sense because the
current duty cycle is stale when the ->period gets set to the value from
args. I think the documentation should mention this in some way.

> + */
> +static inline void pwm_prepare_new_state(const struct pwm_device *pwm,
> +					 struct pwm_state *state)

Perhaps choose a shorter name, such as: pwm_init_state()?

> +{
> +	struct pwm_args args;
> +
> +	/* First get the current state. */
> +	pwm_get_state(pwm, state);
> +
> +	/* Then fill it with the reference config */
> +	pwm_get_args(pwm, &args);
> +
> +	state->period = args.period;
> +	state->polarity = args.polarity;
> +	state->duty_cycle = 0;
> +}
> +
> +/**
> + * pwm_get_relative_duty_cycle() - Get a relative duty_cycle value
> + * @state: the PWM state to extract period and duty_cycle from
> + * @scale: the scale you want to use for you relative duty_cycle value

Other kerneldoc comments in this file don't prefix the description with
"the".

Also, perhaps the following descriptions would be slightly less
confusing:

	@state: PWM state to extract the duty cycle from

We don't extract (i.e. return) period from the state, so it's a little
confusing to mention it here.

	@scale: scale in which to return the relative duty cycle

This is slightly more explicit in that it says what the returned duty
cycle will be in. Perhaps as an alternative:

	@scale: target scale of the relative duty cycle

> + *
> + * This functions converts the absolute duty_cycle stored in @state
> + * (expressed in nanosecond) into a relative value.

Perhaps: "... into a value relative to the period."?

> + * For example if you want to get the duty_cycle expressed in nanosecond,

The example below would give you the duty cycle in percent, not
nanoseconds, right?

> + * call:
> + *
> + * pwm_get_state(pwm, &state);
> + * duty = pwm_get_relative_duty_cycle(&state, 100);
> + */
> +static inline unsigned int
> +pwm_get_relative_duty_cycle(const struct pwm_state *state, unsigned int scale)
> +{
> +	if (!state->period)
> +		return 0;
> +
> +	return DIV_ROUND_CLOSEST_ULL((u64)state->duty_cycle * scale,
> +				     state->period);
> +}
> +
> +/**
> + * pwm_set_relative_duty_cycle() - Set a relative duty_cycle value
> + * @state: the PWM state to fill
> + * @val: the relative duty_cycle value
> + * @scale: the scale you use for you relative duty_cycle value

"scale in which @duty_cycle is expressed"?

> + *
> + * This functions converts a relative duty_cycle stored into an absolute
> + * one (expressed in nanoseconds), and put the result in state->duty_cycle.
> + * For example if you want to change configure a 50% duty_cycle, call:
> + *
> + * pwm_prepare_new_state(pwm, &state);
> + * pwm_set_relative_duty_cycle(&state, 50, 100);
> + * pwm_apply_state(pwm, &state);
> + */
> +static inline void
> +pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int val,

Any reason why we can't call "val" "duty_cycle"? That's what it is,
after all.

> +			    unsigned int scale)
> +{
> +	if (!scale)
> +		return;
> +
> +	/* Make sure we don't have duty_cycle > period */
> +	if (val > scale)
> +		val = scale;

Can we return -EINVAL for both of the above checks? I don't like
silently clamping the duty cycle that the user passed in.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/a1491895/attachment.sig>
