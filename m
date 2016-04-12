From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 12:29:26 +0200
Subject: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
In-Reply-To: <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412102926.GC18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
[...]
> +struct sti_cpt_data {
> +	u32 snapshot[3];
> +	int index;
> +	int gpio;

On a side-note, this should probably use struct gpio_desc * instead of
an integer along with the gpiod_*() APIs for the GPIO handling.

> +	struct mutex lock;
> +	wait_queue_head_t wait;
> +};
> +
>  struct sti_pwm_compat_data {
>  	const struct reg_field *reg_fields;
> -	unsigned int num_chan;
> +	unsigned int pwm_num_chan;
> +	unsigned int cpt_num_chan;
>  	unsigned int max_pwm_cnt;
>  	unsigned int max_prescale;
>  };
> @@ -77,6 +90,7 @@ struct sti_pwm_chip {
>  	struct clk *cpt_clk;
>  	struct regmap *regmap;
>  	struct sti_pwm_compat_data *cdata;
> +	struct sti_cpt_data *cpt_data[STI_MAX_CPT_CHANS];

The PWM subsystem allows chip-specific data to be associated with each
PWM device. I'd prefer if the driver used it rather than homebrew some-
thing similar. See pwm_set_chip_data() and pwm_get_chip_data().

> @@ -389,6 +411,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	for (chan = 0; chan < cdata->cpt_num_chan; chan++) {
> +		struct sti_cpt_data *data;
> +
> +		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +
> +		init_waitqueue_head(&data->wait);
> +		mutex_init(&data->lock);
> +		data->gpio = of_get_named_gpio(np, "capture-gpios", chan);
> +		pc->cpt_data[chan] = data;

Converting to per-PWM data should be as simple as turning this last line
into:

	pwm_set_chip_data(pc->chip.pwms[chan], data);

Also I don't see any cleanup for this data in the driver. The memory for
the per-PWM data should be freed by devm_*() infrastructure, but how
will the GPIO be released?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/43bda11f/attachment.sig>
