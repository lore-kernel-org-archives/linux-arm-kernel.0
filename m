From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Aug 2011 22:33:47 +0100
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <CAMPhdO8qCXrPN7ASo=Fhm+BQJN11NRy=kNPv8ySHMbd24df3Rw@mail.gmail.com>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
	<4E41A4A4.80000@gmail.com>
	<CAMPhdO8qCXrPN7ASo=Fhm+BQJN11NRy=kNPv8ySHMbd24df3Rw@mail.gmail.com>
Message-ID: <20110809213347.GB1831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 05:28:05AM +0800, Eric Miao wrote:
> On Wed, Aug 10, 2011 at 5:20 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On 08/09/2011 12:13 PM, Marc Zyngier wrote:
> >> sched_clock() is yet another blocker on the road to the single
> >> image. This patch implements an idea by Russell King:
> >>
> >> http://www.spinics.net/lists/linux-omap/msg49561.html
> >>
> >> Instead of asking the platform to implement both sched_clock()
> >> itself and the rollover callback, simply register a read()
> >> function, and let the ARM code care about sched_clock() itself,
> >> the conversion to ns and the rollover. sched_clock() uses
> >> this read() function as an indirection to the platform code.
> >>
> >> This allow some simplifications and possibly some footprint gain
> >> when multiple platforms are compiled in. Among the drawbacks,
> >> the removal of the *_fixed_sched_clock optimization which could
> >> negatively impact some platforms (sa1100, tegra, versatile
> >> and omap).
> >
> > There are similar patchsets that move sched_clock into clocksource code.
> > That seems like a cleaner approach to me.
> >
> > http://thread.gmane.org/gmane.linux.kernel/844872
> >
> > http://www.spinics.net/lists/arm-kernel/msg122716.html
> 
> +1, yeah would be better for clocksource to handle that if possible.

clocksources initialize too late, and we have platforms where the
clocksource is not used for sched_clock.

If clocksources were suitable universally for sched_clock, sched_clock
would not exist.
