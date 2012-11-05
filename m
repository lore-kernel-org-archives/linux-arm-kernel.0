From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 05 Nov 2012 13:52:48 +0000
Subject: [PATCH 1/2] leds: Add generic support for memory mapped LEDs
In-Reply-To: <1352120159.10947.3.camel@hornet>
References: <1351792722-15250-1-git-send-email-pawel.moll@arm.com>
 <1352108387.3212.12.camel@linaro1.home> <1352120159.10947.3.camel@hornet>
Message-ID: <1352123568.3212.52.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 12:55 +0000, Pawel Moll wrote:
> On Mon, 2012-11-05 at 09:39 +0000, Jon Medhurst (Tixy) wrote:
> > > +static void mmio_led_brightness_set(struct led_classdev *cdev,
> > > +		enum led_brightness brightness)
> > > +{
> > > +	struct mmio_led *led = container_of(cdev, struct mmio_led, cdev);
> > > +	unsigned long uninitialized_var(flags);
> > 
> > uninitialized_var seems to be a bit contentious, Linus Torvalds had a
> > recent complaint about it which prompted Ingo to post a patch proposing
> > to removing it: https://patchwork.kernel.org/patch/1655621/ So perhaps
> > best to avoid using it ;-).
> > 
> > In this case, you could possibly keep gcc quite with something like:
> > 
> >         spinlock_t *lock = led->lock;
> > 
> > and then use the local variable 'lock' everywhere instead of led->lock.
> > Or just keep it simple an initialise flags to 0 instead.
> 
> Yeah, = 0 will do...
> 
> > > +	if (!pdata)
> > > +		return -EINVAL;
> > > +
> > > +	if (pdata->reg_size != 8 && pdata->reg_size != 16 &&
> > > +			pdata->reg_size != 32)
> > > +		return -EFAULT;
> > 
> > Is EFAULT appropriate here? Why not EINVAL?
> 
> Hm. To distinguish it from !pdata case I guess (and a 13 bit wide
> transaction sounds like a fault to me ;-), but I can be persuaded
> otherwise without much effort...

I was asking as much for my own education about use of error values as
anything else. The comments in errno-base.h are:

#define	EINVAL		22	/* Invalid argument */
#define	EFAULT		14	/* Bad address */

and from looking in the source tree it seems EFAULT is mostly used to
indicate a bad memory address passed from user-side to the kernel.

It's a trivial point so it's not worth wasting time on a long
discussion.

-- 
Tixy
