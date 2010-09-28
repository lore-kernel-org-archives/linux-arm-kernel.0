From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Sep 2010 10:46:18 -0700
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
Message-ID: <20100928174617.GE10739@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 28, 2010 at 01:10:42PM +0530, Arun Murthy wrote:

> The existing pwm based led and backlight driver makes use of the
> pwm(include/linux/pwm.h). So all the board specific pwm drivers will
> be exposing the same set of function name as in include/linux/pwm.h.
> As a result build fails.

As others have said it's *really* not clear what the problem is here...

Please also take a look at the work which Bill Gatliff was doing on a
similar PWM core API and the resulting discussion - how does your code
differ from his, and is any of the feedback on his proposal relevant to
yours?

> +void __deprecated pwm_free(struct pwm_device *pwm)
> +{
> +}
> +

Shouldn't this either be an inline function directly in the header or
exported?

> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +{
> +	return pwm->pops->pwm_config(pwm, duty_ns, period_ns);
> +}
> +EXPORT_SYMBOL(pwm_config);

I'd expect some handling of fixed function PWMs (though I'd expect those
to be rare).

> +	down_write(&pwm_list_lock);
> +	pwm = kzalloc(sizeof(struct pwm_dev_info), GFP_KERNEL);
> +	if (!pwm) {
> +		up_write(&pwm_list_lock);
> +		return -ENOMEM;
> +	}

No need to take the lock until the allocation succeeded.

> +static int __init pwm_init(void)
> +{
> +	struct pwm_dev_info *pwm;
> +
> +	pwm = kzalloc(sizeof(struct pwm_dev_info), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&pwm->list);
> +	di = pwm;
> +	return 0;

Why not just use static data for the list head?

> +subsys_initcall(pwm_init);
> +module_exit(pwm_exit);

Usually these are located next to the functions.
