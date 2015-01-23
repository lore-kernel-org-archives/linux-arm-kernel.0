From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 23 Jan 2015 13:31:22 +0100
Subject: [PATCHv5 0/2] INPUT: Route keyboard LEDs through the generic
 LEDs layer
In-Reply-To: <20150121152112.GA24789@type.bordeaux.inria.fr>
References: <20141226232116.GA5069@type> <20150102195350.GB27538@amd>
 <20150121152112.GA24789@type.bordeaux.inria.fr>
Message-ID: <20150123123122.GC3188@type.bordeaux.inria.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Samuel Thibault, le Wed 21 Jan 2015 16:21:12 +0100, a ?crit :
> I have just tried what you described on a thinkpad lenovo T500, without
> any problem, except that the thinkpad BIOS does a couple of funky
> things:

Actually it's even worse than that: depending on whether it is in
synchronized mode or independent mode, *and* depending on the current
*state* of the internal numlock LED, and probably also whether an
external keyboard is connected, the internal numlock key will produce
*or not* key events!  The actual transition table for this seems quite
clumsy, basically the BIOS seems to be assuming that the the numlock
key toggles the numlock LED, and setting up anything different leads
to all kinds of confusing effects, the "simplest" of which being that
you definitely not want to set e.g. a heartbeat trigger on the numlock
LED, or else the right part of the keyboard will randomly behave as a
keypad...

I guess that may happen with other laptops, so I'm afraid I can only
reject any kind of bug report involving the internal numlock LED or key
of a laptop.

So we're left with these:

Pavel Machek, le Fri 02 Jan 2015 20:53:51 +0100, a ?crit :
> > Here is v5 coming, with separate patches for the kbd and the input
> > parts.
> 
> After booting with this, capslock led does not seem to work on text
> console.

Did you check that it was working before?  If you are using
console-setup, it is a known bug that the capslock LED doesn't reflect
the layout capslock state, because console-setup uses another modifier
than the capslock modifier, because that one has unwanted legacy
hardcoded effects.  That's precisely the point of the keyboard part
of my two led patches to provide console-setup with an interface to
properly route the layout capslock state (expressed as another modifier
than capslock) to the capslock LED.

> input4::capsl/trigger was none by default, that can't be right, right?

That is still not right, and I still don't see how that can happen: my
patch registers the input4::capsl LED with its default trigger name
just before the input4-capsl trigger, and doesn't do anything about
trigger assignment after that, so I don't see how it can be coming from
my patch.

> I tried putting kbd-capslock and input4-capsl there, but that did not
> seem to help.

Was it at least changing the content of the trigger file?  Again, if you
are using console-setup, it is normal that the capslock modifier does
not change, console-setup uses another modifier, that can be seen in
dumpkeys | grep 58, depending on your precise configuration it will use
various modifiers.  So in that case the kbd-capslock and input*-capsl
are not good tests.

Basically you're left with the kbd-scrollock and input*-scrolll triggers
and scrollock key for easy testing, if you happen to have that key on
your keyboard... (apparently the thinkpad I'm testing doesn't do funky
things with it).

> It works with heartbeat trigger, but not with input4-numl
> trigger. (But numlock led works ok with that trigger, weird).

That is probably due to the weird numlock behavior of the thinkpad.

> vt::capsl/brightness controls capslock led, even when
> input4-capsl/trigger is set to input4-numl.

That is also not right, I can't reproduce it, and I don't see how it can
happen with my patch.  Could you copy/paste the commands you are using?

I have also posted reworked patches according to Dmitry's comments,
probably better try those now.

I'm sorry I forgot to make the second threaded with the first, but they
are independent anyway.

Samuel
