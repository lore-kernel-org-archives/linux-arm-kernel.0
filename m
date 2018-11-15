From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Nov 2018 09:58:08 +0100
Subject: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
In-Reply-To: <20181114120814.GD2620@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
 <20181114120814.GD2620@ulmo>
Message-ID: <20181115085808.ihg4of72forhulzc@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

On Wed, Nov 14, 2018 at 01:08:14PM +0100, Thierry Reding wrote:
> On Fri, Oct 26, 2018 at 08:41:56PM +0200, Uwe Kleine-K?nig wrote:
> > +static struct pwm_state lcd_pwm_state;
> 
> You shouldn't need this. The whole point of the atomic API is that the
> PWM carries its state, so the proper way to make a change is to query
> the current state, make any required modifications and then apply the
> new state.

I thought the whole point of the atomic API is to be atomic :-)

> >  static struct pwm_device *lcd_pwm;
> >  
> >  static void rx1950_lcd_power(int enable)
> > @@ -428,15 +429,17 @@ static void rx1950_lcd_power(int enable)
> >  
> >  		/* GPB1->OUTPUT, GPB1->0 */
> >  		gpio_direction_output(S3C2410_GPB(1), 0);
> > -		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> > -		pwm_disable(lcd_pwm);
> > +		lcd_pwm_state.duty_cycle = 0;
> > +		lcd_pwm_state.enabled = false;
> > +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
> 
> The correct way to do this would be:
> 
> 	struct pwm_state state;
> 
> 	pwm_get_state(lcd_pwm, &state);
> 	state.enabled = false;
> 	state.duty_cycle = 0;
> 	pwm_apply_state(lcd_pwm, &state);

The difference here is that with my approach the rx1950 driver caches
the intended pwm_state saving a few cycles for repeatedly copying the
pwm cache to a stack variable at the cost of some memory. I like my
approach a little better but I'm not willing to argue about that one and
can give in.

> >  		gpio_direction_output(S3C2410_GPC(0), 1);
> >  		gpio_direction_output(S3C2410_GPC(5), 1);
> > @@ -491,11 +494,8 @@ static int rx1950_backlight_init(struct device *dev)
> >  		return PTR_ERR(lcd_pwm);
> >  	}
> >  
> > -	/*
> > -	 * FIXME: pwm_apply_args() should be removed when switching to
> > -	 * the atomic PWM API.
> > -	 */
> > -	pwm_apply_args(lcd_pwm);
> > +	pwm_get_state_default(lcd_pwm, &lcd_pwm_state);
> > +	lcd_pwm_state.period = LCD_PWM_PERIOD;
> 
> This is wrong, though it's probably because the comment is also
> confusing. There should be nothing wrong with using pwm_apply_args() in
> this case.

In my eyes it is wrong because it results in a call to the backend
driver's apply callback to get the default setting just to fix the
configuration and apply that in the code to follow.

> While at it, I think the conversion should also be include replacing the
> call to pwm_request() by pwm_get(). There's already a PWM lookup table
> in the RX1950 board code, so pwm_get() would be able to use that. Note
> that for some reason that table contains a period that is different from
> LCD_PWM_PERIOD, so I think that should also be addressed. Basically all
> the information other than duty cycle should be coming from either DT or
> a lookup table.

Yeah, I noticed that, too. It's not entirely clear to me how to do that
yet. So I thought to care about getting rid of the legacy usage of
pwm_config and pwm_apply_args first.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
