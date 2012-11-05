From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 05 Nov 2012 12:55:59 +0000
Subject: [PATCH 1/2] leds: Add generic support for memory mapped LEDs
In-Reply-To: <1352108387.3212.12.camel@linaro1.home>
References: <1351792722-15250-1-git-send-email-pawel.moll@arm.com>
 <1352108387.3212.12.camel@linaro1.home>
Message-ID: <1352120159.10947.3.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 09:39 +0000, Jon Medhurst (Tixy) wrote:
> > +static void mmio_led_brightness_set(struct led_classdev *cdev,
> > +		enum led_brightness brightness)
> > +{
> > +	struct mmio_led *led = container_of(cdev, struct mmio_led, cdev);
> > +	unsigned long uninitialized_var(flags);
> 
> uninitialized_var seems to be a bit contentious, Linus Torvalds had a
> recent complaint about it which prompted Ingo to post a patch proposing
> to removing it: https://patchwork.kernel.org/patch/1655621/ So perhaps
> best to avoid using it ;-).
> 
> In this case, you could possibly keep gcc quite with something like:
> 
>         spinlock_t *lock = led->lock;
> 
> and then use the local variable 'lock' everywhere instead of led->lock.
> Or just keep it simple an initialise flags to 0 instead.

Yeah, = 0 will do...

> > +	if (!pdata)
> > +		return -EINVAL;
> > +
> > +	if (pdata->reg_size != 8 && pdata->reg_size != 16 &&
> > +			pdata->reg_size != 32)
> > +		return -EFAULT;
> 
> Is EFAULT appropriate here? Why not EINVAL?

Hm. To distinguish it from !pdata case I guess (and a 13 bit wide
transaction sounds like a fault to me ;-), but I can be persuaded
otherwise without much effort...

Thanks!

Pawe?
