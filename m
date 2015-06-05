From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 5 Jun 2015 20:58:06 +0530
Subject: [PATCHv7 0/2] INPUT: Route keyboard LEDs through the generic
 LEDs layer
In-Reply-To: <CAKdAkRSk4t2PKHB33f0=V2-zAhV9LXABp1TQ9NsiFLBQet66BQ@mail.gmail.com>
References: <20150217191527.GA9594@type.youpi.perso.aquilenet.fr>
 <201504012200.07408@pali>
 <20150401211140.GI2901@type.youpi.perso.aquilenet.fr>
 <20150402144410.GB18125@amd> <20150423165544.GG7646@pali>
 <CAKdAkRSk4t2PKHB33f0=V2-zAhV9LXABp1TQ9NsiFLBQet66BQ@mail.gmail.com>
Message-ID: <20150605152806.GE2267@type>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Dmitry Torokhov, le Thu 23 Apr 2015 10:04:49 -0700, a ?crit :
> One thing that I know we'd have to fix is that input device must be
> "opened" before we can engage it, right now LED interface violates
> this requirement.

What do you mean precisely by "engage"?  In the following, I guess
actually calling dev->event(EV_LED)

> It works right now because keyboard handler attaches
> to most input devices with LEDs early enough for it to be
> unnoticeable, but it does not mean that it is correct. It might be as
> easy as calling input_open() unconditionally if devices has LEDs.

This seems like only a workaround, perhaps it should rather be leds.c
which checks for dev->users before calling dev->event(EV_LED)?

> Another issue is that I do not think we should be introducing virtual
> VT leds. I believe LEDs should belong to real devices;

But then how to fix console-setup's bug? (it was actually the starter
for all this work)

See http://bugs.debian.org/514464

console-setup needs a way to tell which kbd modifier should toggle the
capslock LED on all the keyboards used by the VT. Thus the point of VT
leds, which people can use to decide the LED behavior of all keyboards,
including hotplugged ones etc.

Samuel
