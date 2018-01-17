From: briannorris@chromium.org (Brian Norris)
Date: Wed, 17 Jan 2018 15:10:57 -0800
Subject: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
In-Reply-To: <c2078487-8cc6-429e-6c38-092d776c33aa@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
 <20180112183122.GA102880@google.com>
 <61b85600-7aee-e9d1-6587-17e5e419b03a@microchip.com>
 <c2078487-8cc6-429e-6c38-092d776c33aa@microchip.com>
Message-ID: <20180117231056.GB112833@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 10:29:53AM +0200, Claudiu Beznea wrote:
> With these changes, if pwm-cells=1 then only PWM-channel will be parsed,

I'm not sure if I'm understanding you correctly but...no. If cells is 1,
then your driver change just causes us not to parse correctly, and
everything fails.

> if it is 2 PWM-channel and PWM-period will be parsed, if pwm-cells=3
> then PWM-channel, PWM-period and PWM-flags will be parsed.
> In your driver you used to have only one cell because you wanted to allow
> user to give as argument only PWM channel, and you did not want a change
> of PWM period (and in of_xlate function you initialize pwm period with 0xffff
> value: this is why I changed the binding in patch 7 of this series, file

It's not a matter of "allow", it's a matter of description. The period
isn't actually even 0xffff, that's just a pseudo-period, to reflect that
you have a choice of duty cycles of 0 to 0xffff. I (justifiably, I
think) didn't think putting this false value in the device tree was
accurate.

> rk3399-gru-kevin.dts). But e.g. sysfs could try to change the PWM period,
> there is no restriction to change the PWM period from sysfs, in the sysfs
> interface but the restriction is in PWM apply of the drive. The same things
> happens with these changes too. The user could introduce any PWM period via
> DT but the pwm apply function of the driver will return error.

sysfs has no bearing on a device tree binding. Just because we have a
broken interface here doesn't mean we should change how we describe the
hardware.

Brian
