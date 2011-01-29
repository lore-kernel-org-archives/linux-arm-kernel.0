From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 29 Jan 2011 21:38:21 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110129213821.0e51dc32@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, 28 Jan 2011 13:21:21 +0100, Sascha Hauer wrote:
> While implementing just another pwm driver I thought it's time to implement
> generic pwm support. The following series adds drivers/pwm/pwmlib.c and
> a i.MX23/28 pwm driver which serves as a usage example for pwmlib. The
> code is inspired by gpiolib support and tested using the backlight pwm
> driver by Eric Miao.
> 
> Currently the pwm_request, pwm_add, pwm_remove and pwm_free operations are
> protected with a single mutex wherea the pwm_enable, pwm_disable and
> pwm_config operations are unlocked. It is assumed that the owners of the
> pwm handle the serialization of the pwm accesses. This may not be enough, so
> i'd like to discuss the locking (and type of locking) here.
> 
> I Cced the people working with PWMs in the kernel in the hope that they can
> give input on what's missing / wrong in this implementation

I do not have the time to review your patches. But I think your
introduction above lacks a fundamental point, which is: what are you
trying to achieve? What would you be able to do with pwmlib, which you
currently aren't?

As far as hwmon driver are concerned, please understand that "PWM" is a
misnomer for "fan speed control". Some hwmon drivers have pwm
attributes which actually correspond to analog voltage outputs. In both
cases (PWM and DC) these are outputs which are dedicated to fan
control, and I've never seen any other use of these, so I doubt it
would make much sense to register them as generic pwm outputs.

So I believe that hwmon drivers are out of scope for pwmlib. Which
makes me wonder what you intend to do with pwmlib (back to my first
question...) as the only use I know of for PWM signals in computers is
for fan control.

-- 
Jean Delvare
