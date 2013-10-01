From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Oct 2013 22:49:26 +0200
Subject: [PATCH 08/10] pwm-backlight: Use new enable_gpio field
In-Reply-To: <524B16E8.5080506@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-9-git-send-email-treding@nvidia.com>
 <524B16E8.5080506@wwwdotorg.org>
Message-ID: <20131001204925.GC9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:39:36PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> > Make use of the new enable_gpio field and allow it to be set from DT as
> > well. Now that all legacy users of platform data have been converted to
> > initialize this field to an invalid value, it is safe to use the field
> > from the driver.
> 
> > diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> 
> >  Optional properties:
> 
> > +  - enable-gpios: a list of GPIOs to enable and disable the backlight
> 
> That seems to imply that multiple GPIOs are legal. Was that intended? If
> not, I would suggest:
> 
> - enable-gpios: contains a single GPIO specifier for the GPIO which
> 		enables/disables the backlight. See [1] for the format.
> 
> >  
> >  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
> + [1]: Documentation/devicetree/bindings/gpio/gpio.txt

Yes, that sounds better. Indeed only a single GPIO is supported. Adding
more than one would require representing the timing between the two and
that will take us back to where we left off with the power sequences.

> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> 
> > @@ -51,12 +55,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness,
> >  		     pb->lth_brightness;
> >  
> >  	pwm_config(pb->pwm, duty_cycle, pb->period);
> > +
> > +	if (gpio_is_valid(pb->enable_gpio)) {
> > +		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> > +			gpio_set_value(pb->enable_gpio, 0);
> > +		else
> > +			gpio_set_value(pb->enable_gpio, 1);
> > +	}
> 
> Feel completely free to ignore this, but when the difference in two
> code-paths is solely in function parameters, I prefer to calculate the
> parameter inside the if statement, then call the function outside the
> conditional code, to highlight the common/different parts:
> 
> int value;
> 
> /* or an if statement for the next 1 line, if you don't like ?: */
> value = (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW) ? 0 : 1;
> gpio_set_value((pb->enable_gpio, value);

I actually tried that, but it looked cluttered, so I opted for the
alternative. Not that this matters all that much, because beginning with
3.13 the GPIO subsystem should be able to handle the active low flag
internally using the new gpiod_*() API. I plan on converting the driver
to use that during the next cycle.

> > @@ -148,11 +168,10 @@ static int pwm_backlight_parse_dt(struct device *dev,
> 
> > +	data->enable_gpio = of_get_named_gpio_flags(node, "enable-gpios", 0,
> > +						    &flags);
> > +	if (gpio_is_valid(data->enable_gpio) && (flags & OF_GPIO_ACTIVE_LOW))
> > +		data->enable_gpio_flags |= PWM_BACKLIGHT_GPIO_ACTIVE_LOW;
> 
> This doesn't seem to handle deferred probe correctly; I would expect
> something more like:
> 
> 	data->enable_gpio = of_get_named_gpio_flags(...);
> 	if (data->enable_gpio == -EPROBE_DEFERRED)
> 		return data->enable_gpio;
> 	if (gpio_is_valid(...))
> 		...
> 	return 0;
> 
> I suppose it's possible that the value filters down to
> gpio_request_one() and this actually does work out OK, but that feels
> very accidental/implicit to me.

Yes, I think it does indeed propagate to gpio_request_one(), but you're
right, it should be caught explicitly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/71667a87/attachment.sig>
