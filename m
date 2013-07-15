From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Mon, 15 Jul 2013 21:08:03 +0200
Subject: [PATCH] Route kbd LEDs through the generic LEDs layer
In-Reply-To: <CANq1E4TRAOp+=w4oqPt4sjV7iLyDygxxpwrZy7dSB8UK288aNA@mail.gmail.com>
References: <201011112205.oABM5KVJ005298@imap1.linux-foundation.org>
 <201011111440.07882.dmitry.torokhov@gmail.com>
 <20110102090935.GV32469@atrey.karlin.mff.cuni.cz>
 <20110102103210.GA25662@core.coreip.homeip.net>
 <20110102225741.GX5480@const.famille.thibault.fr>
 <20110112182702.GA9168@core.coreip.homeip.net>
 <20111114040613.GA4992@type.famille.thibault.fr>
 <20121221003449.GA6999@type.youpi.perso.aquilenet.fr>
 <20130707101028.GD5651@type.youpi.perso.aquilenet.fr>
 <CANq1E4TRAOp+=w4oqPt4sjV7iLyDygxxpwrZy7dSB8UK288aNA@mail.gmail.com>
Message-ID: <20130715190803.GG11600@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

David Herrmann, le Mon 15 Jul 2013 17:03:08 +0200, a ?crit :
> > @@ -13,6 +13,10 @@
> >         bool "Virtual terminal" if EXPERT
> >         depends on !S390 && !UML
> >         select INPUT
> > +       select NEW_LEDS
> > +       select LEDS_CLASS
> > +       select LEDS_TRIGGERS
> > +       select INPUT_LEDS
> 
> This looks odd. Any dependency changes in the input-layer will break
> this. But I guess that's what we get for a non-recursive "select". Hmm

Yes, that's the issue.

> I also think that the macros don't really simplify this. So:
>   [VC_SHIFTLOCK] = { .name = "shiftlock", .activate =
> kbd_lockstate_trigger_activate },
> isn't much longer than:
>   DEFINE_LOCKSTATE_TRIGGER(VC_SHIFTLOCK,  "shiftlock"),

That makes it more than 80 columns, at least.

> > +       for (i = 0; i < ARRAY_SIZE(ledtrig_ledstate); i++)
> > +               led_trigger_register(&ledtrig_ledstate[i]);
> > +       for (i = 0; i < ARRAY_SIZE(ledtrig_lockstate); i++)
> > +               led_trigger_register(&ledtrig_lockstate[i]);
> > +
> 
> This returns "int", are you sure no error-handling is needed?

ATM only registering the same name several times can happen, and
shouldn't ever happen. But better warn than be sorry, indeed.

> > + * Keyboard LEDs are propagated by default like the following example:
> > + *
> > + * VT keyboard numlock trigger
> > + * -> vt::numl VT LED
> > + * -> vt-numl VT trigger
> 
> Nitpick: What's the reason for the syntax difference? "vt-numl" vs. "vt::numl"

vt::numl is a clear LED classification convention. For triggers, I don't
see a clear convention, but at least I have never seen "::", only "-".
That makes me realize that for keyboard triggers I haven't introduced a
prefix, and only used "scrollock", "numlock", etc. Perhaps
"kbd-scrollock" etc. or (in phase with LEDs), "kbd::scrollock" etc.?

Samuel
