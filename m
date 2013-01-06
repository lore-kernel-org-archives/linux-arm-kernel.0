From: mikedunn@newsguy.com (Mike Dunn)
Date: Sun, 06 Jan 2013 14:19:29 -0800
Subject: [PATCH v2] ARM: PXA27x: fix workaround for AC97 reset
In-Reply-To: <1357490881-19015-1-git-send-email-grinberg@compulab.co.il>
References: <87fw2ebe1i.fsf@free.fr>
 <1357490881-19015-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <50E9F871.6030105@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2013 08:48 AM, Igor Grinberg wrote:
> Fix the workaround to a hardware bug in the AC97 controller of PXA27x.
> A bug in the controller's warm reset functionality requires that the MFP
> used by the controller as the AC97_RESET_n line be temporarily
> reconfigured as a GPIO (AF0) and manually held high for the duration of
> the warm reset cycle.
> 
> The workaround was broken long ago by commit fb1bf8cd
> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()).
> The commit above changed the original workaround code in a way that
> changed the MFP to AF0 (GPIO), but forgot to drive the GPIO high output.
> This way, the GPIO state was left input (and undriven) and only worked
> for boards with external pullup on the line.
> 
> Fix the above breakage by actually configurring the GPIO for output high
> in case of reset assert and returning it to default state
> (AF1 - for GPIO95 and AF2 - for GPIO113) in case of reset deassert.


Hi Igor,

I pulled patches 2, 3, and 4 from my patch set (patch #1 fixes an unrelated
problem with ac97 cold reset) and replaced it with this, and warm reset works.
My pxa270 uses gpio 95 for reset, BTW.  I don't have a platform that uses 113.

Honestly, I don't understand why it works :)  The pxa27x_assert_ac97reset()
function calls pxa2xx_mfp_config() with an input direction configuration when it
switches to gpio (AF0), so I don't see how the line remains an output driven
high.  I think you tried to explain that in the email exchange, but I'm still
confused.  I'm looking at __mfp_config_gpio(), and it looks like it's setting
the GPDR register.

[..]


>  
>  void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
>  {
> -	pxa_register_device(&pxa_device_ac97, ops);
> +	int err = 0;
> +
> +	if (ops && gpio_is_valid(ops->reset_gpio)) {
> +		err = gpio_request_one(ops->reset_gpio, GPIOF_INIT_HIGH,
> +				       "ac97 rst");
> +		if (err)
> +			pr_err("%s: Failed requesting GPIO%d (ac97 rst): %d",
> +			       __func__, ops->reset_gpio, err);
> +	}
> +
> +	if (!err)
> +		pxa_register_device(&pxa_device_ac97, ops);
>  }
>  
>  #ifdef CONFIG_PXA25x


On further thought, I'm not sure about doing this here.  This file is for all
pxa's, no?  The gpio only needs to be obtained for pxa270.  And even in that
case, the ac97 controller peripheral may not be used if no codec is attached, in
which case the pins are free to be used for any kind of gpio.  It might be
better to have the ac97 driver request the gpio.

And a more general complaint: the functionality is very obscure.  (Heck, I still
can't figure it out! :)

Thanks Igor,
Mike
