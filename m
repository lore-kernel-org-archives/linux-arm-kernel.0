From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 8 Oct 2013 14:05:17 +0200
Subject: [PATCH v2] PWM: atmel-pwm: use request/free instead of
 enable/disable
In-Reply-To: <1380554553-25676-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1380554553-25676-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20131008120516.GA16196@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 05:22:33PM +0200, Alexandre Belloni wrote:
> I found that disabling a pwm while it is at a low level will actually put it
> back at a high level. The main symptom is that leds-pwm is calling pwm_disable()
> after setting the duty cycle to 0. Hence, instead of getting a switched off LED,
> you get an LED lit up at full brightness.

I wonder why that's the case. What's causing the PWM to go back to full
duty cycle when disabled? There was a similar issue with some other PWM
driver a while back and the cause was tracked down to be that you had to
wait for a full period to make sure the signal was constantly low before
switching off the clock. Perhaps something similar is the issue here?

> Solve that by using the request and free callbacks to enable and disable the
> pwm channels and the clock.

"pwm" -> "PWM",  please.

> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
[...]
> +static int atmel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	/*
> +	 * This is a dummy function, required to be able to register the pwm
> +	 * chip, see pwmadd_chip() in pwm/core.c
> +	 */
> +	return 0;
> +}
> +
> +static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	/*
> +	 * This is a dummy function, required to be able to register the pwm
> +	 * chip, see pwmadd_chip() in pwm/core.c
> +	 */
> +}

This just doesn't feel right. Can somebody please investigate what the
real reason is for the behaviour described in the commit message and see
if we can't solve this in some other way? .request() and .free() are
typically called very early or very late, respectively, so this patch
will keep the PWM clock on forever (pretty much).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/e603fb7f/attachment.sig>
