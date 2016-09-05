From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:50:11 +0200
Subject: [PATCH v4 12/17] pwm: sti: Initialise PWM Capture device data
In-Reply-To: <20160816093508.28307-13-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-13-lee.jones@linaro.org>
Message-ID: <20160905105011.GL31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:03AM +0100, Lee Jones wrote:
> Each PWM Capture device is allocated a structure to hold its own
> state.  During a capture the device may be partaking in one of 3
> phases.  Initial (rising) phase change, a subsequent (falling)
> phase change indicating end of the duty-cycle phase and finally
> a final (rising) phase change indicating the end of the period.
> The timer value snapshot each event is held in a variable of the
> same name, and the phase number (0, 1, 2) is contained in the
> index variable.  Other device specific information, such as GPIO
> pin, the IRQ wait queue and locking is also contained in the
> structure.  This patch initialises this structure for each of
> the available devices.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)

Applied this with two small changes. See below.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> +struct sti_cpt_ddata {
> +	u32 snapshot[3];
> +	int index;

I made this unsigned int because it never needs to be negative.

> @@ -350,6 +366,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	struct sti_pwm_compat_data *cdata;
>  	struct sti_pwm_chip *pc;
>  	struct resource *res;
> +	unsigned int devnum;

Renamed this variable to "i" because it's...

>  	int ret;
>  
>  	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> @@ -378,7 +395,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	cdata->reg_fields   = &sti_pwm_regfields[0];
>  	cdata->max_prescale = 0xff;
>  	cdata->max_pwm_cnt  = 255;
> -	cdata->num_devs     = 1;
> +	cdata->pwm_num_devs = 1;
> +	cdata->cpt_num_devs = 0;
>  
>  	pc->cdata = cdata;
>  	pc->dev = dev;
> @@ -416,7 +434,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	pc->chip.dev = dev;
>  	pc->chip.ops = &sti_pwm_ops;
>  	pc->chip.base = -1;
> -	pc->chip.npwm = pc->cdata->num_devs;
> +	pc->chip.npwm = pc->cdata->pwm_num_devs;
>  	pc->chip.can_sleep = true;
>  
>  	ret = pwmchip_add(&pc->chip);
> @@ -426,6 +444,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	for (devnum = 0; devnum < cdata->cpt_num_devs; devnum++) {

... usage here becomes more idiomatic.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/60494605/attachment.sig>
