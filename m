From: rpurdie@rpsys.net (Richard Purdie)
Date: Wed, 26 May 2010 13:01:08 +0100
Subject: [PATCH 1/2] mc13783: add LED support
In-Reply-To: <20100517200017.GA25262@sirena.org.uk>
References: <1274114423-30020-1-git-send-email-philippe.retornaz@epfl.ch>
	<1274114423-30020-2-git-send-email-philippe.retornaz@epfl.ch>
	<20100517190242.GA17604@pengutronix.de>
	<20100517200017.GA25262@sirena.org.uk>
Message-ID: <1274875268.24079.1.camel@rex>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 21:00 +0100, Mark Brown wrote:
> On Mon, May 17, 2010 at 09:02:42PM +0200, Uwe Kleine-K?nig wrote:
> > On Mon, May 17, 2010 at 06:40:22PM +0200, Philippe R?tornaz wrote:
> 
> > > +static void mc13783_led_set(struct led_classdev *led_cdev,
> > > +			   enum led_brightness value)
> > > +{
> > > +	struct mc13783_led *led;
> > > +
> > > +	led = container_of(led_cdev, struct mc13783_led, cdev);
> > > +	led->new_brightness = value;
> > > +	schedule_work(&led->work);
> > > +}
> 
> > I wonder why you don't set the registers directly here, but use a work
> > struct instead.
> 
> The LED API allows clients to configure the LEDs from interrupt context
> so for devices on blocking buses (like this) the driver needs to defer
> the actual implementation of the change.
> 
> It'd be nice to add helpers for this to the LED core, there's quite a
> few drivers implementing this idiom now - a flag that does the deferring
> of the set() for example.

Agreed, or a wrapper around the core which deferred implementations
could just use. I'm open to patches :)

Cheers,

Richard
