From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 13 Oct 2017 18:26:23 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <20171003220311.GU457@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
 <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
 <20171003220311.GU457@codeaurora.org>
Message-ID: <4f067c09-9ecf-9266-baa0-18575bca94eb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2017 05:03 PM, Stephen Boyd wrote:
> I don't see any value
> beyond system wide debug in figuring out the default pin
> configuration of a pin that doesn't have a consumer in Linux.

I can agree with that.

> Could we remove the pin direction finding part here in
> gpiochip_add_pin_range() and lazily resolve the pin direction
> when a pin is requested? We would need a similar check in the msm
> specific debugfs code where we skip pins that aren't requested.
> This is basically a revert of commit 72d320006177 ("gpio: set up
> initial state from .get_direction()").
> 
> ACPI can still describe only the pin ranges that they care about
> exposing, but from the devicetree side it's been working well
> enough to not touch pins that aren't used by anything in Linux.
> 
> ---8<----
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cd003b74512f..673028823bc5 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1210,16 +1210,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
>   		 * wrong direction in sysfs.
>   		 */
>   
> -		if (chip->get_direction) {
> -			/*
> -			 * If we have .get_direction, set up the initial
> -			 * direction flag from the hardware.
> -			 */
> -			int dir = chip->get_direction(chip, i);
> -
> -			if (!dir)
> -				set_bit(FLAG_IS_OUT, &desc->flags);
> -		} else if (!chip->direction_input) {
> +		if (!chip->direction_input) {
>   			/*
>   			 * If the chip lacks the .direction_input callback
>   			 * we logically assume all lines are outputs.
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 273badd92561..4a0aeceb42f1 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -24,7 +24,7 @@
>   #include <linux/pinctrl/pinconf.h>
>   #include <linux/pinctrl/pinconf-generic.h>
>   #include <linux/slab.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>   #include <linux/interrupt.h>
>   #include <linux/spinlock.h>
>   #include <linux/reboot.h>
> @@ -494,6 +494,12 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
>   	};
>   
>   	g = &pctrl->soc->groups[offset];
> +
> +	if (!gpiochip_is_requested(chip, gpio)) {
> +		seq_printf(s, " %-8s:", g->name);
> +		return;
> +	}
> +
>   	ctl_reg = readl(pctrl->regs + g->ctl_reg);
>   
>   	is_out = !!(ctl_reg & BIT(g->oe_bit));

In order for this to work, I had to add this function from patch #1:

static int msm_gpio_request(struct gpio_chip *chip, unsigned int offset)
{
	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
	const struct msm_pingroup *g = &pctrl->soc->groups[offset];

	if (!g->npins)
		return -ENODEV;

	return gpiochip_generic_request(chip, offset);
}

The problem with this is that none of the GPIOs are "requested", so it 
displays an output like this:

# cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-149, parent: platform/QCOM8002:00, QCOM8002:00:
  (null)  :
  (null)  :
  (null)  :
[... truncated ]]
  (null)  :
  (null)  :
  (null)  :
  (null)  :
  gpio36  :
  gpio37  :
  gpio38  :
  gpio39  :
  (null)  :
  (null)  :

It can't differentiate between GPIOs that don't exist and GPIOs that 
haven't been requested.  Plus, the "(null)" entries are what I've been 
trying to avoid in the first place.

So overall, this patch seems okay, although it needs a little work. 
However, it doesn't address Bjorn's complaint that he doesn't want me to 
use pin ranges at all.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
