From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 12 Apr 2014 18:30:49 -0700
Subject: [PATCH] Route keyboard LEDs through the generic LEDs layer.
In-Reply-To: <20140412100934.GA7196@amd.pavel.ucw.cz>
References: <20140331122323.GC6044@type.bordeaux.inria.fr>
 <20140407021015.GA8518@core.coreip.homeip.net>
 <20140407075423.GZ7179@type.wlan.youpi.perso.aquilenet.fr>
 <20140408083940.GA22855@core.coreip.homeip.net>
 <20140412100934.GA7196@amd.pavel.ucw.cz>
Message-ID: <20140413013049.GB28990@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 12, 2014 at 12:09:34PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > This permits to reassign keyboard LEDs to something else than keyboard "leds"
> > > > > state, by adding keyboard led and modifier triggers connected to a series
> > > > > of VT input LEDs, themselves connected to VT input triggers, which
> > > > > per-input device LEDs use by default.  Userland can thus easily change the LED
> > > > > behavior of (a priori) all input devices, or of particular input devices.
> > > > > 
> > > > 
> > > > I still have the same concern that I believe I already mentioned a while
> > > > ago: how do we reconcile the LED control via triggers with LED control
> > > > done through event devices?
> 
> I think we should deprecate LED controls using event devices. We have
> nice API for LEDs, and it is not in input.
> 
> 
> 
> 
> > > > Currently, as far as I can see, they will be
> > > > clashing with each other. I.e. if I remap my capslock led to be the new
> > > > shiftlock and then userspace writes EV_LED/LED_CAPSL it would light up
> > > > my new "shift lock", right?
> > > 
> > > Well, yes, sure, if you shoot in your foot it will hurt :) (although
> > > here the damage is really small, it is just LED lighting or not).
> > 
> > This is not about amount of damage but the overall correctness of the
> > implementation. I'd rather not have a solution with known holes, if
> > possible.
> 
> I'd say that applications using direct EV_LED interface should just
> stop doing it. Yes, you can probably use led API and still toggle the
> led using gpio api behind leds back (not tested, perhaps there are
> interlocks that prevent that)... and it is same situation with
> EV_LED. We should just teach applications not to do that.
> 
> Would solution where EV_LED would be ignored when there's non-default
> trigger selected work for you?

Not ignored but rather routed to the LED that is currently selected for
given function. This way if I re-purposed CapsLock LED for Wifi and do
not provide a replacement EV_LED will be effectively dropped, but if I
switch CapsLock with NumLock I want the event to affect the appropriate
LED.

Thanks.

-- 
Dmitry
