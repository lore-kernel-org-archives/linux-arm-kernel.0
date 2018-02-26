From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 10:00:38 +0100
Subject: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
In-Reply-To: <20180225135308.GA14561@arx-s1>
References: <20180225135308.GA14561@arx-s1>
Message-ID: <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for respinning this serie. It looks mostly good, but you still
have a quite significant number of checkpatch (--strict) warnings that
you should address.

On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
> +#define CAPTURE_IRQ_ENABLE_REG	0x0010
> +#define CFIE(ch)	BIT(ch << 1 + 1)
> +#define CRIE(ch)	BIT(ch << 1)

You should also put your argument between parentheses here (and in all
your other macros).

> +static const u16 div_m_table[] = {
> +	1,
> +	2,
> +	4,
> +	8,
> +	16,
> +	32,
> +	64,
> +	128,
> +	256
> +};

If this is just a power of two, you can use either the power of two /
ilog2 to switch back and forth, instead of using that table.

> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +		struct pwm_state *state)
> +{
> +	int ret;
> +	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
> +	struct pwm_state cstate;
> +
> +	pwm_get_state(pwm, &cstate);
> +	if (!cstate.enabled) {
> +		ret = clk_prepare_enable(sun8i_pwm->clk);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to enable PWM clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock(&sun8i_pwm->ctrl_lock);

What do you need that spinlock for? Can you use a mutex instead?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/b8890ab2/attachment.sig>
