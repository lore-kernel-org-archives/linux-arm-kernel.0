From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 13:07:23 +0000
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <20091125122857.GJ29442@buzzloop.caiaq.de>
References: <20091125122857.GJ29442@buzzloop.caiaq.de>
Message-ID: <20091125130723.GA14045@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 01:28:57PM +0100, Daniel Mack wrote:
> On Wed, Nov 25, 2009 at 11:41:07AM +0000, Mark Brown wrote:
> > On Wed, Nov 25, 2009 at 11:42:26AM +0100, Daniel Mack wrote:

> > > +	if (en) {
> > > +		gpio_set_value(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 1);

> > This looks like you want to add regulator support to the CODEC.

> Well, that's not really a regulator but just a GPIO that drives a FET.
> Doesn't using the regulator framework seem a little overdone?

No, the main goal here is to make sure the CODEC driver knows what's
going on with its power.  In your system it is a trivial GPIO based
regulator that's doing the power control but other systems might have
something different.  Looking at it from the other angle, nothing about
powering on and off the CODEC ought to be board specific.

I do also have a plan in the back of my mind to use the runtime PM
infrastructure to allow ASoC to push things down into BIAS_OFF when
they're idle rather than just BIAS_STANDBY which this won't play well
with.

> > The relevant drivers really need to know about this...  if you are going
> > to stick with this approach I'd push all this stuff into the audio

> The idea was to only let the board support file know about GPIO
> definitions, so the audio part doesn't need to know about the details.

The audio driver is already entirely board specific, knowing about the
GPIOs isn't going to make any odds here.  At the minute reading the
code it looks like part of the audio driver has randomly been lifted out
into a separate file for no particular reason.

> But I can move that if you like. However, I don't see much benefit - I
> would merely just move the whole function over.

If nothing else it'll fix the extern in a .c file issue.
