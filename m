From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 19 Jun 2013 00:17:06 +0200
Subject: [PATCH 08/15] pwm: Add new pwm-samsung driver
In-Reply-To: <1920640.1A218CWh3x@flatron>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
 <20130617202910.GB5265@mithrandir> <1920640.1A218CWh3x@flatron>
Message-ID: <20130618221705.GC1926@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:50:40PM +0200, Tomasz Figa wrote:
> On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
[...]
> > > +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> > > +static DEFINE_SPINLOCK(samsung_pwm_lock);
> > > +#endif
> > 
> > Why is this lock global? Shouldn't it more correctly be part of
> > samsung_pwm_chip?
> 
> There are few registers shared with samsung_pwm_timer clocksource driver 
> and so normally the spinlock is exported from it. However on on some 
> platforms (namely Exynos >=4x12) kernel can be compiled without that 
> driver, so the lock must be defined locally, just to synchronize multiple 
> PWM channels, as they share registers as well.

Okay, I think this needs further explanation. The clocksource driver is
used for what exactly? From a quick look it seems to be very much PWM-
specific. According to the device tree binding for the PWM driver, the
timer blocks can also be used as clock sources and clock event timers.
So if I understand correctly you have setups where you use one or more
channels as clock source or clock event timer and one or more channels
as PWM outputs.

In that case it's a very bad idea to use a global lock to synchronize
accesses. You need to do much more than that. To properly split this
across several drivers there needs to be a mechanism to allocate
channels for use either as clock source/event timer or PWM. Otherwise,
how do you know that drivers aren't stepping on each other's toes?

> > > +		ret = pwm_samsung_parse_dt(chip);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		chip->chip.of_xlate = of_pwm_xlate_with_flags;
> > > +		chip->chip.of_pwm_n_cells = 3;
> > > +	} else {
> > > +		if (!pdev->dev.platform_data) {
> > > +			dev_err(&pdev->dev, "no platform data 
> specified\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		memcpy(&chip->variant, pdev->dev.platform_data,
> > > +							sizeof(chip-
> >variant));
> > > +	}
> > 
> > Obviously this needs some modification in order for the variant to
> > become constant. But I think you can easily do so by making the driver
> > match using the platform_driver's id_table field, similar to how the
> > matching is done for OF.
> 
> Generally output_mask is board-dependent and is passed inside a variant 
> struct using platform_data pointer.

That's okay. But output_mask is the only thing that's board-dependent.
Everything else in the variant is SoC dependent judging by the OF device
table. So really only the output_mask should be part of the platform
data.

> Same platform data is used in samsung_pwm_timer clocksource driver, so I 
> just reused it here without adding the need to rename platform device at 
> runtime (see arch/arm/plat-samsung/devs.c).

Looking a bit at git log for the clocksource driver, there's this
commit:

	a3ce54f clocksource: samsung_pwm_timer: Do not request PWM mem region

That's an ugly workaround for sharing registers between two drivers.
There's a reason why drivers do request_mem_region(), and it is
precisely to prevent them from accessing the same registers. As I
already said above, I think you need to come up with some sort of API to
share resources between the drivers.

There was a similar issue a few months back with the pwm-tiehrpwm and
pwm-tiecap drivers, which use a shared block of registers. Initially
something similar was done as you do here, but eventually we came up
with a much better solution that involved introducing a new driver for
the shared functionality and an exported API.

The situation seems to be somewhat different here since you actually
share the same resources for different functionality instead of sharing
one subset of register across multiple drivers, but I think a similar
solution can be applied here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/a85e8a07/attachment-0001.sig>
