From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 7 Jun 2016 09:28:07 +0100
Subject: [STLinux Kernel] [[PATCH v2] 08/11] pwm: sti: Initialise PWM
 Capture device data
In-Reply-To: <1461320295-20414-9-git-send-email-lee.jones@linaro.org>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <1461320295-20414-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20160607082807.GC22744@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, 22 Apr 2016, Lee Jones wrote:

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
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 78979d0..9d597bb 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/interrupt.h>
>  #include <linux/math64.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -18,8 +19,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
> +#include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> +#include <linux/wait.h>
>  
>  #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Device's Duty Cycle register */
>  #define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
> @@ -64,9 +67,17 @@ enum sti_cpt_edge {
>  	CPT_EDGE_BOTH,
>  };
>  
> +struct sti_cpt_ddata {
> +	u32 snapshot[3];
> +	int index;
> +	struct mutex lock;
> +	wait_queue_head_t wait;
> +};
> +
>  struct sti_pwm_compat_data {
>  	const struct reg_field *reg_fields;
> -	unsigned int num_devs;
> +	unsigned int pwm_num_devs;
> +	unsigned int cpt_num_devs;
>  	unsigned int max_pwm_cnt;
>  	unsigned int max_prescale;
>  };
> @@ -307,10 +318,15 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  	struct device_node *np = dev->of_node;
>  	struct sti_pwm_compat_data *cdata = pc->cdata;
>  	u32 num_devs;
> +	int ret;
>  
> -	of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> -	if (num_devs)
> -		cdata->num_devs = num_devs;
> +	ret = of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> +	if (!ret)
> +		cdata->pwm_num_devs = num_devs;

dt binding document documents this as st,pwm-num-chan currently. Why do you need
this  binding anyway? Why can't you determine how many channels you have based on
the number of pinctrl groups you are given?

Also with this series I don't currently understand how the driver is configured to be
pwm-in or pwm-out. Can you explain how that decision is made?

For example at the moment I can't see any code in this series for handling the different
pinctrl groups which presumably are required to have this working.

If I look at pinctrl_pwm1_chan0_default and friends declared in
stih407-pinctrl.dtsi all are currently named pwm-out, and declared as outputs. For
pwm-in functionality I was expecting to see another set of pinctrl definitions,
declaring these pins as inputs, and something in the driver selecting the
correct pin config depending on how the device has been configured?

Maybe an updated dt example / bindings would make this clearer.

regards,

Peter
