From: Claudiu.Beznea@microchip.com (m18063)
Date: Fri, 17 Mar 2017 11:07:43 +0200
Subject: [PATCH v2 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
In-Reply-To: <20170316121409.3e910813@bbrezillon>
References: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
 <1488468525-28726-2-git-send-email-claudiu.beznea@microchip.com>
 <20170316121409.3e910813@bbrezillon>
Message-ID: <7947e576-d2fa-9e5a-3b46-8001344218e7@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,


On 16.03.2017 13:14, Boris Brezillon wrote:
> Hi Claudiu,
>
> On Thu, 2 Mar 2017 17:28:44 +0200
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>
>> The currently Atmel PWM controllers supported by this driver
>> could change period or duty factor without channel disable,
>> for regular channels (sama5d3 support this by using period
>> or duty factor update registers, sam9rl support this by
>> writing channel update register and select the corresponding
>> update: period or duty factor). The chip doesn't support run
>> time changings of signal polarity. To take advantage of
>> atomic PWM framework and let controller works without glitches,
>> in this patch only the duty factor could be changed without
>> disabling PWM channel. For period and signal polarity the
>> atomic PWM is simulated by disabling + enabling the right PWM channel.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> ---
>>  drivers/pwm/pwm-atmel.c | 271 ++++++++++++++++++++++++------------------------
>>  1 file changed, 138 insertions(+), 133 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index 67a7023..3db82c3 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -58,17 +58,30 @@
>>  #define PWM_MAX_PRD		0xFFFF
>>  #define PRD_MAX_PRES		10
>>  
>> +struct atmel_pwm_reg_data {
>> +	u8 period;
>> +	u8 period_upd;
>> +	u8 duty;
>> +	u8 duty_upd;
>> +};
>> +
>> +struct atmel_pwm_data {
>> +	void (*update_cdty)(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			    unsigned long cdty);
>> +	void (*set_cprd_cdty)(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      unsigned long cprd, unsigned long cdty);
>> +	const struct atmel_pwm_reg_data regs;
> If you go for this per-IP reg layout definition approach, you don't need
> the ->update_cdty()/->set_cprd_cdty() hooks anymore.

Agree, I will send another version.

>
>> +};
>> +
> [...]
>
>> +static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			   struct pwm_state *state)
>> +{
>> +	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>> +	struct pwm_state cstate;
>> +	unsigned long cprd, cdty;
>> +	u32 pres, val;
>> +	bool pwm_reset = false;
>> +	int ret;
>> +
>> +	pwm_get_state(pwm, &cstate);
>> +
>> +	if (cstate.enabled &&
>> +	    (cstate.polarity != state->polarity ||
>> +	     cstate.period != state->period))
>> +		pwm_reset = true;
> You can move that in the 'if (state->enabled)' block, but I'm not even
> sure this is really needed (see below).

Agree. I will send another version. Sorry for the noise.

>
>> +
>> +	if (state->enabled) {
>> +		if (cstate.enabled && !pwm_reset) {
> 		if (cstate.enabled &&
> 		    (cstate.polarity != state->polarity ||
> 		     cstate.period != state->period)) {
>
>> +			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
>> +						  atmel_pwm->data->regs.period);
>> +			atmel_pwm_calculate_cdty(state, cprd, &cdty);
>> +			atmel_pwm->data->update_cdty(chip, pwm, cdty);
>> +			return 0;
>> +		}
>> +
>> +		ret = atmel_pwm_calculate_cprd_and_pres(chip, state, &cprd,
>> +							&pres);
>> +		if (ret) {
>> +			dev_err(chip->dev,
>> +				"failed to calculate cprd and prescaler\n");
>> +			return ret;
>> +		}
>> +
>> +		atmel_pwm_calculate_cdty(state, cprd, &cdty);
>> +
>> +		if (pwm_reset) {
> 		if (cstate.enabled) {
>
>> +			atmel_pwm_disable(chip, pwm, false);
>> +		} else {
>> +			ret = clk_enable(atmel_pwm->clk);
>> +			if (ret) {
>> +				dev_err(chip->dev, "failed to enable clock\n");
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		/* It is necessary to preserve CPOL, inside CMR */
>> +		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
>> +		val = (val & ~PWM_CMR_CPRE_MSK) | (pres & PWM_CMR_CPRE_MSK);
>> +		if (state->polarity == PWM_POLARITY_NORMAL)
>> +			val &= ~PWM_CMR_CPOL;
>> +		else
>> +			val |= PWM_CMR_CPOL;
>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
>> +		atmel_pwm->data->set_cprd_cdty(chip, pwm, cprd, cdty);
>> +		mutex_lock(&atmel_pwm->isr_lock);
>> +		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
>> +		atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
>> +		mutex_unlock(&atmel_pwm->isr_lock);
>> +		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
>> +	} else if (cstate.enabled) {
>> +		atmel_pwm_disable(chip, pwm, true);
>> +	}
>> +
>> +	return 0;
>>  }

Thank you,
Claudiu
