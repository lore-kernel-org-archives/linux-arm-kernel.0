From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Thu, 23 Aug 2012 15:36:54 +0200 (CEST)
Subject: [BUG] leds-pwm: First setting of brightness does nothing
In-Reply-To: <322770447.2755463.1345727876098.JavaMail.root@advansee.com>
Message-ID: <320569847.2756382.1345729013971.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have found a bug using leds-pwm with the i.MX PWM driver. The first time a
non-0 brightness is set through sysfs, this has no effect. It works fine from
the 2nd time.

The cause of this bug is that leds-pwm.c:led_pwm_set() calls pwm_config() before
pwm_enable(), while in the i.MX PWM driver pwm_enable() enables the PWM IP
clock, so that a call to pwm_config() has no effect before the first call to
pwm_enable().

Several other PWM drivers in drivers/pwm/ work in the same way. pwm-beeper.c and
pwm_bl.c also call pwm_config() before pwm_enable(). The PWM documentation does
not say if the wrong doers are these PWM users or the i.MX-like PWM drivers.

So what should be fixed? Fixing these PWM users would be quite easy since it's a
simple swap of the pwm_config() and pwm_enable() calls. This should not produce
any glitch since the duty cycle is always set to 0 by these PWM users before
calling pwm_disable().

Best regards,
Beno?t
