From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 12:35:21 +0200
Subject: [RESEND 08/11] pwm: sti: Add support for PWM Capture IRQs
In-Reply-To: <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412103521.GD18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:32:06PM +0000, Lee Jones wrote:
[...]
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> +static irqreturn_t sti_pwm_interrupt(int irq, void *data)
> +{
> +	struct sti_pwm_chip *pc = data;
> +	struct device *dev = pc->dev;
> +	struct sti_cpt_data *d;
> +	int channel;
> +	int cpt_int_stat;
> +	int reg;
> +	int ret = IRQ_NONE;
> +
> +	ret = regmap_field_read(pc->pwm_cpt_int_stat, &cpt_int_stat);
> +	if (ret)
> +		return ret;
> +
> +	while (cpt_int_stat) {
> +		channel = ffs(cpt_int_stat) - 1;
> +
> +		d = pc->cpt_data[channel];
> +
> +		/*
> +		 * Capture input:
> +		 *    _______                   _______
> +		 *   |       |                 |       |
> +		 * __|       |_________________|       |________
> +		 *   ^0      ^1                ^2
> +		 *
> +		 * Capture start by the first available rising edge
> +		 * When a capture event occurs, capture value (CPT_VALx)
> +		 * is stored, index incremented, capture edge changed.
> +		 *
> +		 * After the capture, if the index > 1, we have collected
> +		 * the necessary data so we signal the thread waiting for it
> +		 * and disable the capture by setting capture edge to none
> +		 *
> +		 */

How do you deal with the situation where someone will stop the PWM
signal half-way in? That is, suppose you've got events for the first and
second snapshots (0 and 1) and then someone stops the PWM and the event
for snapshot 2 never happens, how does the code recover?

> +
> +		regmap_read(pc->regmap,
> +			    PWM_CPT_VAL(channel), &d->snapshot[d->index]);
> +
> +		switch (d->index) {
> +		case 0:
> +		case 1:
> +			regmap_read(pc->regmap, PWM_CPT_EDGE(channel), &reg);
> +			reg ^= PWM_CPT_EDGE_MASK;
> +			regmap_write(pc->regmap, PWM_CPT_EDGE(channel), reg);
> +
> +			d->index++;
> +			break;
> +		case 2:
> +			regmap_write(pc->regmap,
> +				     PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> +			wake_up(&d->wait);
> +			break;
> +		default:
> +			dev_err(dev, "Internal error\n");
> +		}
> +
> +		clear_bit(channel, (unsigned long int *)&cpt_int_stat);

clear_bit() is a little unusual to use on regular data types, as
evidenced by the need for the goofy cast here.

> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	/* Just ACK everything */
> +	regmap_write(pc->regmap, PWM_INT_ACK, PWM_INT_ACK_MASK);
> +
> +	return ret;
> +}
> +
>  static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  {
>  	struct device *dev = pc->dev;
> @@ -354,6 +425,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  	if (IS_ERR(pc->pwm_cpt_int_en))
>  		return PTR_ERR(pc->pwm_cpt_int_en);
>  
> +	pc->pwm_cpt_int_stat = devm_regmap_field_alloc(dev, pc->regmap,
> +						reg_fields[PWM_CPT_INT_STAT]);
> +	if (IS_ERR(pc->pwm_cpt_int_stat))
> +		return PTR_ERR(pc->pwm_cpt_int_stat);
> +
>  	return 0;
>  }
>  
> @@ -371,7 +447,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	struct sti_pwm_chip *pc;
>  	struct resource *res;
>  	unsigned int chan;
> -	int ret;
> +	int ret, irq;
>  
>  	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>  	if (!pc)
> @@ -392,6 +468,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->regmap))
>  		return PTR_ERR(pc->regmap);
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> +		return -ENODEV;
> +	}

I think you need to propagate the return value of platform_get_irq()
here.

> +
> +	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt,
> +			       0, pdev->name, (void *) pc);

No need for the explicit cast to void *.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/53a2b6d2/attachment.sig>
