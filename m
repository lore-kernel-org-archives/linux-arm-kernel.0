From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Sep 2016 08:45:52 +0200
Subject: [PATCHv6 0/3] pwm: imx: support output polarity inversion
In-Reply-To: <20160912211254.GA4637@archie.localdomain>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
 <20160909091857.7a263220@ipc1.ka-ro>
 <20160912124553.aqgv7b4vsx4urogi@piout.net>
 <20160912140401.qkezay7sqqavsf4i@pengutronix.de>
 <074eed0df23199bc82f8d221690596d3@agner.ch>
 <20160912200021.fsnfdgnng4it354g@pengutronix.de>
 <20160912211254.GA4637@archie.localdomain>
Message-ID: <20160913064552.oywq74iqo3fecsgz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Clemens,

On Mon, Sep 12, 2016 at 11:12:54PM +0200, Clemens Gruber wrote:
> On Mon, Sep 12, 2016 at 10:00:21PM +0200, Uwe Kleine-K?nig wrote:
> > I want that the pwm driver disables its clock on pwm_config(mypwm, 0,
> > someperiod) such that the consumer doesn't need to call
> > pwm_disable(mypwm) to save power (assuming it's safe to do so, which
> > only the pwm provider knows).
> 
> I am not sure if this is such a good idea, because there are use cases
> where you want to keep the PWM driver enabled the whole time but still
> be able to change the duty cycle to 0 for some time without adding
> unnecessary delays when changing the duty cycle back to something else.
> 
> We have an application where we control fluid valves in a beer
> dispensing system through PWMs and these valves are pulsed with
> different PWM duty cycles for a short time. In-between the duty cycle
> is also 0. For example: Start at 0%, 100ms 90%, 200ms 70%, 300ms 0%,
> 100ms 90%, and so on..
> There it is critical that the change from and to 0 duty cycle is not
> delayed by disabling and reenabling the clock.
> The oscillator (if there is one) should be up and running, only the duty
> cycle should be 0 for a short time.

I don't think it is sensible to map this requirement in the pwm api. The
trade-off between performance and power saving is common between all
types of devices and there are other mechanisms to handle this.

Also only some pwms are affected by this because disabling the clock
doesn't introduce a measurable overhead for all of them.

With write(2) there is also no way to define if the hard disk should
spin down after the request is completed. And this wouldn't make sense
for an ssd.

So yes, there would be no way to prohibit stopping the pwm with the pwm
API, but you could implement runtime pm for your device.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
