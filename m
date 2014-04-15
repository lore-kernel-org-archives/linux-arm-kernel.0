From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 15 Apr 2014 19:25:28 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <3138967.5Gj2T0XUGf@phil>
References: <3748421.ND1tAjvgKS@typ> <3138967.5Gj2T0XUGf@phil>
Message-ID: <2745802.Mh5myQIMrf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 15. April 2014, 10:42:18 schrieb Heiko St?bner:
> > The driver is almost finished, it's just missing support for long
> > transfers
> > (>32 bytes) and a bit of cleanup. Communication with the ACT8846 works
> > without problems. It depends on your clock driver though, so I'll wait
> > with
> > a patch until that is finished, right?
> 
> Not necessarily. Normally the drivers go through different trees anyway
> (here clock tree vs. i2c tree) and you might get comments and might need a
> v2 anyway. Also as the driver will simply use the standard clock API, you
> have no dependies on my series - so in my mind you should simply go ahead
> when you're finished with it.

Looking at the grf-handling of your i2c-driver [0] reminded me, that I'm 
generally not sure how we should handle these registers. All of them use what 
recently always got called a hiword-mask, with the upper 16 bit indicating 
which lower 16 bit get changed.

So while the

	regmap_write(grf, 4, BIT(11 + bus_idx) | BIT(27 + bus_idx));

will most likely get the desired result at least once, I'm not sure how this 
interacts with the caching regmap implements [and regmap in general], as the 
bit(27 + bus_idx) is not a real value bit and will always read 0.

It may be sensible to teach regmap to handle such hiword-mask registers itself 
like in the clock case [1], so that it can automatically select the 
appropriate mask bits when value-bits are changed.


I've added Mark Brown, the regmap maintainer, in Cc because I'm not 100% sure 
if this is the correct way to go.


Heiko


[0] 
https://github.com/xqms/linux/commit/531bcb12a2ac1975f61d16d05e4608800c054c0d#diff-375822b3a417ed4faea8f6ae3e5c1766R621
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/174687.html
