From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 15:53:02 +0200
Subject: [PATCH v3 08/20] pwm: Add PWM Capture support
In-Reply-To: <20160608092135.21184-9-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-9-lee.jones@linaro.org>
Message-ID: <20160610135302.GK27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:21:23AM +0100, Lee Jones wrote:
> Supply a PWM Capture call-back Op in order to pass back
> information obtained by running analysis on PWM a signal.
> This would normally (at least during testing) be called from
> the Sysfs routines with a view to printing out PWM Capture
> data which has been encoded into a string.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
>  include/linux/pwm.h | 25 +++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index dba3843..4678de6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -525,6 +525,33 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  EXPORT_SYMBOL_GPL(pwm_apply_state);
>  
>  /**
> + * pwm_capture() - capture and report a PWM signal
> + * @pwm: PWM device
> + * @result: struct to fill with capture result
> + * @timeout_ms: time to wait, in milliseconds, before giving up on capture
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
> +		unsigned int timeout_ms)
> +{
> +	int err;
> +
> +	if (!pwm || !pwm->chip->ops)
> +		return -EINVAL;
> +
> +	if (!pwm->chip->ops->capture)
> +		return -ENOSYS;
> +
> +	mutex_lock(&pwm_lock);
> +	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout_ms);
> +	mutex_unlock(&pwm_lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(pwm_capture);
> +
> +/**
>   * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
>   * @pwm: PWM device
>   *
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 17018f3..13cac27 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -5,7 +5,9 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  
> +struct pwm_capture;
>  struct seq_file;
> +
>  struct pwm_chip;
>  
>  /**
> @@ -153,6 +155,7 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
>   * @free: optional hook for freeing a PWM
>   * @config: configure duty cycles and period length for this PWM
>   * @set_polarity: configure the polarity of this PWM
> + * @capture: capture and report PWM signal
>   * @enable: enable PWM output toggling
>   * @disable: disable PWM output toggling
>   * @apply: atomically apply a new PWM config. The state argument
> @@ -172,6 +175,8 @@ struct pwm_ops {
>  		      int duty_ns, int period_ns);
>  	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    enum pwm_polarity polarity);
> +	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
> +		       struct pwm_capture *result, unsigned int timeout_ms);

Can we please drop the _ms suffix. It's already documented to be in
milliseconds. Also maybe make that unsigned long for consistency with
the type of the timeout parameter elsewhere in the kernel.

>  	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
>  	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
>  	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -212,6 +217,16 @@ struct pwm_chip {
>  	bool can_sleep;
>  };
>  
> +/**
> + * struct pwm_capture - PWM capture data
> + * @period: period of the PWM signal (in nanoseconds)
> + * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
> + */
> +struct pwm_capture {
> +	unsigned long long period;
> +	unsigned long long duty_cycle;
> +};

I'd prefer these to be unsigned int, for symmetry with the PWM output
part of the framework. With 32 bits you get about 4.2 seconds of period
and duty cycle, and I doubt that any reasonable signal would extend
beyond that.

> @@ -322,6 +337,9 @@ static inline void pwm_disable(struct pwm_device *pwm)
>  
>  
>  /* PWM provider APIs */
> +int pwm_capture(struct pwm_device *pwm,
> +		struct pwm_capture *result,
> +		unsigned int timeout_ms);

This fits into 2 lines. And same comments on the timeout parameter.

>  int pwm_set_chip_data(struct pwm_device *pwm, void *data);
>  void *pwm_get_chip_data(struct pwm_device *pwm);
>  
> @@ -373,6 +391,13 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
>  	return -EINVAL;
>  }
>  
> +static inline int pwm_capture(struct pwm_device *pwm,
> +			      struct pwm_capture *result,
> +			      unsigned int timeout_ms)

Same here.

Otherwise this looks really nice to me from an API point of view.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/a0d06dff/attachment.sig>
