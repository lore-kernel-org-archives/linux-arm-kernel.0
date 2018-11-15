From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 Nov 2018 17:21:59 +0100
Subject: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
In-Reply-To: <20181115091644.d5hdk5vao6x74zwp@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181114123236.GG2620@ulmo>
 <20181115091644.d5hdk5vao6x74zwp@pengutronix.de>
Message-ID: <20181115162159.GD8611@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:16:44AM +0100, Uwe Kleine-K?nig wrote:
> Hello Thierry,
> 
> On Wed, Nov 14, 2018 at 01:32:36PM +0100, Thierry Reding wrote:
> > On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K?nig wrote:
> > > This helps to convert drivers from the legacy API to pwm_apply_state without
> > > having to make the aware of the configured polarity (and in some cases even
> > > period).
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  include/linux/pwm.h | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > So if I understand your intention correctly here you want consumers to
> > be able to get at the default state, which would be the state as it was
> > "configured" in DT or the PWM lookup table so that you can modify that
> > state (well, really just setting the duty-cycle) before you actually
> > send the state to the hardware.
> > 
> > So the difference to pwm_apply_args() is that you don't want the driver
> > to specifically program a duty cycle of 0 before setting the actual duty
> > cycle that you want to set.
> > 
> > Is that about right?
> 
> Yes, and a resulting advantage is that the apply callback is only called
> once.
>  
> > Isn't that exactly what pwm_init_state() already does? pwm-backlight
> > uses it for exactly the same purpose that you seem to be using it in
> > RX1950 backlight control.
> 
> I didn't use pwm_init_state because that doesn't give a helpful value
> for state->enabled. (I think it is: if the driver provides a get_state
> callback it is whatever that one set, otherwise it's off.)

That's correct. It's pretty much the same thing that you have, except
you explicitly set enable = false. But that's not really important
because consumers are supposed to explicitly override that anyway.

> Also the name pwm_init_state isn't that good IMHO. Just from the name
> I'd expect it to be something like
> 
> 	memset(state, 0, sizeof(&state));
> 
> instead of something more informed that depends on hardware state and/or
> data provided by a device tree.

Be that as it may, the kerneldoc is pretty explicit about what it does
and so is the code. Not liking the name shouldn't be an excuse for
duplicating functionality.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/775d5c3a/attachment.sig>
