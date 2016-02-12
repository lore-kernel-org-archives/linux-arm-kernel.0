From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 12 Feb 2016 17:28:16 +0200
Subject: [PATCH V3 6/6] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <1454756672-12790-7-git-send-email-zhang.chunyan@linaro.org>
References: <1454756672-12790-1-git-send-email-zhang.chunyan@linaro.org>
 <1454756672-12790-7-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <87y4aq2bjj.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> +static long stm_generic_set_options(struct stm_data *stm_data,
> +				    unsigned int master,
> +				    unsigned int channel,
> +				    unsigned int nr_chans,
> +				    unsigned long options)
> +{
> +	struct stm_drvdata *drvdata = container_of(stm_data,
> +						   struct stm_drvdata, stm);
> +	if (!(drvdata && drvdata->enable))
> +		return -EINVAL;
> +
> +	if (channel >= drvdata->numsp)
> +		return -EINVAL;
> +
> +	switch (options) {
> +	case STM_OPTION_GUARANTEED:
> +		set_bit(channel, drvdata->chs.guaranteed);
> +		break;
> +
> +	case STM_OPTION_INVARIANT:
> +		clear_bit(channel, drvdata->chs.guaranteed);
> +		break;

This is a bad interface. Firstly, neither option is described
anywhere. Secondly, I'm pretty sure "invariant" does not mean "not
guaranteed" in english, although this function seems to imply this.

> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static long stm_generic_get_options(struct stm_data *stm_data,
> +				    unsigned int master,
> +				    unsigned int channel,
> +				    unsigned int nr_chans,
> +				    u64 *options)
> +{
> +	struct stm_drvdata *drvdata = container_of(stm_data,
> +						   struct stm_drvdata, stm);
> +	if (!(drvdata && drvdata->enable))
> +		return -EINVAL;
> +
> +	if (channel >= drvdata->numsp)
> +		return -EINVAL;
> +
> +	switch (*options) {
> +	case STM_OPTION_GUARANTEED:
> +		*options = test_bit(channel, drvdata->chs.guaranteed);
> +		break;

This just doesn't work. @options here is an on-stack variable in
stm_char_ioctl(), hitherto uninitialized. The get_options ioctl command
as you implemented it doesn't fetch @options from userspace either, it
just passes a pointer to it to this callback, expecting that the
callback will set it so that it can be copy_to_user()ed back to the
user.

Then, when we figure this out, there is again the question of what
should one make of STM_OPTION_{GUARANTEED,INVARIANT} and how do they fit
into *options.

The idea behind set_options ioctl is that the user specifies a bit mask
of options that he/she wants to set.

[snip]

> +#ifndef __UAPI_CORESIGHT_STM_H_
> +#define __UAPI_CORESIGHT_STM_H_
> +
> +#define STM_FLAG_TIMESTAMPED   BIT(3)
> +#define STM_FLAG_GUARANTEED    BIT(7)
> +
> +enum {
> +	STM_OPTION_GUARANTEED = 0,
> +	STM_OPTION_INVARIANT,
> +};

Each of these guys could also use an explanation.

Regards,
--
Alex
