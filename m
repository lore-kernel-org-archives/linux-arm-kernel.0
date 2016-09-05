From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 13:10:56 +0200
Subject: [PATCH v4 14/17] pwm: sti: Add PWM Capture call-back
In-Reply-To: <20160816093508.28307-15-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-15-lee.jones@linaro.org>
Message-ID: <20160905111056.GN31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:05AM +0100, Lee Jones wrote:
> Once a PWM Capture has been initiated, the capture call
> enables a rising edge detection IRQ, then waits.  Once each
> of the 3 phase changes have been recorded the thread then
> wakes.  The remaining part of the call carries out the
> relevant calculations and passes back a formatted string to
> the caller.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)

Applied with minor changes. See below.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> +#define SECS_TO_NANOSECS(x) ((x) * 1000 * 1000 * 1000)

I dropped this in favour of doing the multiplication by NSEC_PER_SEC in
situ.

> +
>  #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Device's Duty Cycle register */
>  #define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
>  #define PWM_CPT_EDGE(x) (0x30 + (4 * (x))) /* Edge to capture on */
> @@ -305,7 +307,88 @@ static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clear_bit(pwm->hwpwm, &pc->configured);
>  }
>  
> +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_capture *result, unsigned long timeout)
> +{
> +	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
> +	struct sti_pwm_compat_data *cdata = pc->cdata;
> +	struct sti_cpt_ddata *ddata = pwm_get_chip_data(pwm);
> +	struct device *dev = pc->dev;
> +	unsigned int effective_ticks;
> +	unsigned long long high, low;
> +	int ret;
> +
> +	if (pwm->hwpwm > cdata->cpt_num_devs - 1) {

Turned this into:

	if (pwm->hwpwm >= cdata->cpt_num_devs) {

because I find that easier to read.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/9461fd18/attachment.sig>
