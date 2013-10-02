From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 2 Oct 2013 19:45:51 +0200
Subject: [PATCH 10/10] pwm-backlight: Allow backlight to remain disabled
 on boot
In-Reply-To: <524B198B.3010609@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-11-git-send-email-treding@nvidia.com>
 <524B198B.3010609@wwwdotorg.org>
Message-ID: <20131002174550.GA29973@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:50:51PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:41 PM, Thierry Reding wrote:
[...]
> > +	if (gpio_is_valid(pb->enable_gpio)) {
> > +		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> > +			gpio_set_value(pb->enable_gpio, 0);
> > +		else
> > +			gpio_set_value(pb->enable_gpio, 1);
> > +	}
> 
> ... That assumes that the backlight is on at boot, and hence presumably
> after this patch still always turns on the backlight, only to turn it
> off very quickly once the following code in this patch executes:

I was just going to fix this, but then saw that the code in .probe() is
actually this:

	if (gpio_is_valid(pb->enable_gpio)) {
		unsigned long flags;

		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
			flags = GPIOF_OUT_INIT_HIGH;
		else
			flags = GPIOF_OUT_INIT_LOW;

		ret = gpio_request_one(pb->enable_gpio, flags, "enable");
		...
	}

Which sets the backlight up to be disabled by default and is consistent
with the PWM and regulator setup. Only later, depending on the value of
boot_off it gets enabled (or stays disabled).

> (and perhaps we also need to avoid turning the backlight off then on if
> it was already on at boot)

That's true. Although I'm not sure if that's even possible. I think the
pinctrl driver doesn't touch the registers, but what about the GPIO and
PWM drivers. It might be impossible to always query the boot status and
set the internal state based on that. The easiest would probably be if
both the bootloader and the kernel use the same DT, in which case the
bootloader could set the backlight-boot-on property, in which case we
wouldn't need to do anything at .probe() time really.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/4cfcbc8f/attachment.sig>
