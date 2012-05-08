From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 May 2012 20:12:12 +0000
Subject: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
In-Reply-To: <CANqRtoRHekxkbpW9diJy27d1a1EofeyotLFfgN4tcabmJxZmsA@mail.gmail.com>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205051921.13209.arnd@arndb.de>
 <CANqRtoRHekxkbpW9diJy27d1a1EofeyotLFfgN4tcabmJxZmsA@mail.gmail.com>
Message-ID: <201205082012.12514.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 May 2012, Magnus Damm wrote:
> Please allow me to jump in here for a second.
> 
> You are right that none of the current in-tree SoCs were developed by
> NEC, but exactly which bits that end up inside the SoC varies quite a
> bit. The r8a7779 is for instance in the R-Car line which I believe for
> some reason has more similarities with ex-NEC chips. The pinmux is not
> that different from Emma mobile. Some timers and serial ports are
> shared with other SoCs but many other IP blocks have nothing in common
> with other mach-shmobile SoCs. But I sort of fail to see why this
> matters since it's stuff kept outside of arch/arm anyways. As you
> probably know the r8a7779 SoC is already merged in mach-shmobile but
> we can of course move it out if that helps.

I want the structure to make sense and be consistent so that anyone
who works with a lot of platforms knows where to find stuff and can
work on all the platforms. Simplicity sometimes trumps consistency,
but both are important.

The r8a7779 SoC is indeed an interesting case, it seems to fit
well into shmobile because you use some of the same devices (e.g.
sh-sci and the clock code). If you think there are lots of
commonalities with the new one, it's probably fair to put them
in the same directory even when that means we also have completely
unrelated stuff in there now. I would still prefer having separate
directories, but I'll leave it up to you as long as you put
an explanation about the history into the changeset comment.

One thing is I really don't like is when I get the impression that
people are trying to cheat and hide important facts from the upstream
maintainer in order to improve their chance of getting stuff included.
The best way to avoid giving that impression is to add as much
information as possible about why you do things in a certain way.

> So if all these things are moved out of arch/arm (which I believe is
> the right way forward) then what is the point of having mach
> directories at all? In the end it's some random ARM IP with I/O
> devices hanging off it. With that in mind i'd rather work on putting
> the Emma Mobile stuff in a common arch/arm location than create yet
> another separate directory for something that isn't really special at
> all.

We're heading that way for 64 bit ARM, but it needs more work. When
all drivers (irqchip, clock, pinctrl, ...) have been moved out of arch/arm,
I guess a lot of simple platforms become a single source file with just
one DT_MACHINE_START statement (or something even simpler), and then
we can put them into a common directory.

	Arnd
