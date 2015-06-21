From: benoar@dolka.fr (Benjamin Cama)
Date: Sun, 21 Jun 2015 19:49:16 +0200
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <CAO10kszcRzLDcWijb6PMQ45YBmTKzx-wXbnMs5r1-wtsoSsKVw@mail.gmail.com>
References: <1434765234.5177.25.camel@dolka.fr>
 <CAO10kszcRzLDcWijb6PMQ45YBmTKzx-wXbnMs5r1-wtsoSsKVw@mail.gmail.com>
Message-ID: <1434908956.5657.28.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche 21 juin 2015 ? 10:05 +0900, Alexey Kopytko a ?crit :
> > 
> > On 20 june 2015 ?., at 10:53, Benjamin Cama <benoar@dolka.fr> wrote:
> > 
> >  as I had a problem with the hardware that I am
> > going to fix soon, but I wanted some comments on it. I included
> > Andrew's remarks, even though I do not know what to do about the
> > buttons name for now: I don't know how the switch is wired exactly for
> > now, and FYI the ?auto-power? is an intermediate position between off
> > and power that in the original firmware does some wake-up/sleep of the
> > disks when the backup utility is run from the PC connected to the NAS.
> > I never used it and do not know what to do with it, and what ?key?
> > should be associated with it.
> > 
> 
> 1. These buttons shall be dealt with from the userspace. Actually
> there is a userspace daemon in the original firmware that reboots the
> whole thing if you turn the switch to off position. That's clearly not
> a kernel's job so don't just worry about this switch for now. Moreover
> I don't think this button does anything at all if there's no daemon.

Sorry, I didn't mean to handle it in the kernel, but to associate a
correct _keycode_ with it. I mean, 0 (KEY_RESERVED) for power and 1
(KEY_ESC) for auto-power don't seem right to me.

> Running evtest against this button and wiggling it gives this:
> 
> # evtest /dev/input/event0
> Input driver version is 1.0.1
> Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
> Input device name: "gpio-keys"
> Supported events:
>   Event type 0 (Sync)
>   Event type 1 (Key)
>     Event code 357 (Option)
>   Event type 5 (?)
>     Event code 0 (?)
>     Event code 1 (?)
> Testing ... (interrupt to exit)
> Event: time 1434848366.955536, type 5 (?), code 0 (?), value 0
> Event: time 1434848366.955557, -------------- Report Sync ------------
> Event: time 1434848366.955576, type 5 (?), code 0 (?), value 1
> Event: time 1434848366.955589, -------------- Report Sync ------------
> Event: time 1434848366.955593, type 5 (?), code 0 (?), value 0
> 
> 
> 2. As far as I remember in my patch I intentionally changed states of
> some of the lights to be able to see if a kernel is booting or we have
> a bad build. Can't tell if you did this too, but if I would that will
> be nice for those people who don't have a serial soldered.

Well, there is the basic blinking blue power (from bootloader) named
now lswsgl:power:blue:bottom that transitions to solid blue, that IIRC
the original firmware does too.

Regarding people without serial access: this is the main problem I
think, that make people not use anything else than their stock
firmware; it is too easy to fuck things up and need serial for repair.
Personally, *every* board that I tried toying with ended up needing
some serial access for recovery, so I understand that less
knowledgeable people don't want to risk ?bricking? their device.

Furthermore, Buffalo are really vicious with serial access: traces cut
under a capacitor for this Mini, but for the newer one (LS-WSXL),
traces cut under the SOIC-8 NOR Flash (more difficult to solder) _and_
bootloader not outputting anything on serial port!

No wonder these boards don't get tested much, only crazy people like
me, you and some others do it.

--
benjamin
