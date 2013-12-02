From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Dec 2013 14:03:30 +0100
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <20131202120845.GI12952@e106331-lin.cambridge.arm.com>
References: <20131112153057.GA9683@earth.universe>
 <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
 <20131112200514.GA15413@earth.universe>
 <CACRpkdaAaLjm_b+OLj3tobxBN8YGUcTPnXJ=qtBqd02=FTxhjQ@mail.gmail.com>
 <20131112204013.GA17674@earth.universe>
 <20131113142406.GH21713@e106331-lin.cambridge.arm.com>
 <20131117182852.GC30012@xo-6d-61-c0.localdomain>
 <20131202113720.GF12952@e106331-lin.cambridge.arm.com>
 <20131202115442.GA4725@amd.pavel.ucw.cz>
 <20131202120845.GI12952@e106331-lin.cambridge.arm.com>
Message-ID: <20131202130330.GA6203@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > This flag says "this is device where autorepeat makes sense". It does
> > make sense for qwerty keyboard, it does not make sense for power
> > button. There's nothing Linux specific here.
> 
> If you follow that argument, you don't need the property at all. We know
> whether something is being handled as a keyboard or a power button, from
> the rest of the data in the DT and how the driver is handling the
> device. From that you can figure out if it's sensible to handle the
> device as autorepeat or not.

gpio-button can be used for both power button and arrows... So yes,
driver could do the decision, but you 

Yes, dt "autorepeat" attribute is there to set up the defaults, so
that the device does not have to look at the list of keycodes.

(And it is still not linux specific).

> > > > I believe we don't want to end up with
> > > > 
> > > > linux,input-no-autorepeat
> > > > bsd,keypad-autorepeat
> > > > windows-phone,disable-autorepeat
> > > 
> > > I do not see a problem with this. This is only as bad as the current
> > 
> > Not a problem? DTS bloat? Code bloat for the drivers? (Because that
> > way, we'll need to handle "windows-phone,disable-autorepeat" DTS for
> > compatibility one day).
> 
> I would be extremely surprised if we ever discovered
> "windows-phone,disable-autorepeat" in a DT ;)

If you pretend that other operating systems do not exist, why bother
with "linux," prefix at all...

> I believe that namespacing the property is sensible for the moment, as
> it currently is Linux specific. It also doesn't erroneously imply that
> this is a hardware property. If another OS happen to pick it up, then
> living with a "linux," prefix isn't that horrendous.

I think that would be pretty bad. Also we would be expected to handle
"bsd,keyboard-autorepeat" and
"windows-phone,please-do-not-autorepeat".

And there's nothing really wrong with current "autorepeat" solution we
are using, is it?

> > > situation, but has the benefit that the madness is constrained to
> > > particular vendor prefixes, which we can uniquely identify and handle
> > > differently if required.
> > 
> > Madness? We want to avoid madness and improve current situation where
> > different driver use different attributes.
> 
> Then why not have a way of figuring this out automatically, and get rid
> of the madness of having this in the DT at all? 

We already have few drivers that use DT to do this, using different
variants of "[linux,][no]autorepeat". Yes, we could move the
complexity from DT to drivers, but that does not seem like a win.

> It's not a property of
> the device, and it doesn't even make sense as a piece of static
> configuration -- what if I prefer my keyboard to not autorepeat, but my
> board vendor has decided autorepeat should be on?

Input already has controls you can use.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
