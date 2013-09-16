From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Sep 2013 18:14:16 +0100
Subject: mvneta: oops in __rcu_read_lock on mirabox
In-Reply-To: <20130916182450.639084c6@skate>
References: <CACzLR4tTvt+ROEhkXUCQhV6=bPPTX4LFSkWfrEhF+OdM1Jm1Rw@mail.gmail.com>
 <20130915205701.5c61a444@skate> <20130916065047.GH27487@1wt.eu>
 <20130916175152.4e013457@skate>
 <20130916162209.GL12758@n2100.arm.linux.org.uk>
 <20130916182450.639084c6@skate>
Message-ID: <20130916171416.GM12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 06:24:50PM +0200, Thomas Petazzoni wrote:
> Could this be caused by bitflips in the RAM due to bad timings, or
> overheating or that kind of things?

Well, the SoC is an Armada 370, which uses Marvell's own Sheeva core.
>From what I understand, this is a CPU designed entirely by Marvell, so
the interpretation of these codes may not be correct.  This is made
harder to diagnose in that Marvell is soo secret with their
documentation; indeed for this CPU there is no information publically
available (there's only the product briefs).

Bad timings could certainly cause bitflips, as could poor routing of
data line D8 (eg, incorrect termination or routing causing reflections
on the data line - remember that with modern hardware, almost every
signal is a transmission line).

Marginal or noisy power supplies could also be a problem - for example,
if the impedance of the power supply connections is too great, it may
work with some patterns of use but not others.

There's soo many possibilities...

However, if the fault codes above really do equate to what's in the ARMv7
Architecture Reference Manual, I think we can rule out the routing and
RAM chips - because a cache parity error points to bit flips in the cache,
or if there is no cache parity checking implemented, it means something
is corrupting the state of the SoC - which could be due to bad power
supplies.

How do we get to the bottom of this?  That's a very good question - one
which is going to be very difficult to solve.  Ideally, it means working
with the manufacturer's design team to try and work out what's going on
at the board level, probably using logic analysers to capture the bus
activity leading up to the failure.  Also, checking the power supplies
at the SoC too - checking that they're within correct tolerance and
checking the amount of noise on them.

I think all we can do at the moment is to wait for further reports to roll
in and see whether a better pattern emerges.

If you want to try something - and you suspect it may be heat related,
you could try putting the board inside a container, monitor the temperature
inside the container, and put it in your freezer!  Just be careful of the
temperature of the other devices on the board getting too cold though -
remember, most consumer electronics is only rated for an *operating*
temperature range of 0?C to 70?C and your freezer will be something like
-20?C - so don't let the ambient temperature inside the container go
below 0?C!  If the CPU is producing lots of heat though, it may keep the
container sufficiently warm that that's not a problem.  The theory is
that by making the ambient 15 to 20?C cooler, you will also lower the
temperature of the hotter parts by a similar amount.
