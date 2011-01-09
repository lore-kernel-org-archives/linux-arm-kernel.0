From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Jan 2011 10:52:00 +0000
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with
	high frequency clocks
In-Reply-To: <1294084049.2571.30.camel@work-vm>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
	<20101221105149.GO28157@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012291703300.10437@xanadu.home>
	<20110103003718.GF17727@n2100.arm.linux.org.uk>
	<1294084049.2571.30.camel@work-vm>
Message-ID: <20110109105200.GC31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 11:47:29AM -0800, john stultz wrote:
> Now, for sched_clock, there are a different set of expectations with
> regards to accuracy and expected idle times, and we'll probably need a
> similar consolidation effort to make sure the mult/shift calculations
> are correct and the resulting limits are taken into account by the
> scheduler when going into NOHZ mode.

However, it's exactly the same concerns wrt idle time.  If you want
a 100% accurate sched_clock() and you're using the same counter
register for both sched_clock() and clocksource, then you might as
well have a 100% accurate clocksource too (it's essentially the same
conversion with the same upper bound.)

With a 32-bit counter at 200MHz, theoretically you have a wrap time of
slightly less than 21.5s, but with a 5ns accuracy (actually 5ns).

The existing sched_clock() code comes out with:

sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
Versatile: shift = 26 mult = 2796202667
sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 1165084ms
SA11x0: shift = 23 mult = 2275555556
sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
Tegra: shift = 22 mult = 4194304000
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
OMAP: shift = 17 mult = 4000000000
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
Orion: shift = 27 mult = 671088640

Reducing down the minsec from 60 to 5 gives:

sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
Versatile: shift = 26 mult = 2796202667
sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 1165084ms
SA11x0: shift = 23 mult = 2275555556
sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
Tegra: shift = 22 mult = 4194304000
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
OMAP: shift = 17 mult = 4000000000
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
Orion: shift = 29 mult = 2684354560

Note that the resolution and wrap periods are calculated using the chosen
constants.  The constants for "Orion" do change, but it produces no visible
effect on the outcome - we still achieve the same resolution and the same
wrap period.  Let's just check that with bc:

1 * 671088640 / 2^27
5.00000000000000000000
1 * 2684354560 / 2^29
5.00000000000000000000

Let's look at 183MHz, which is a value I've randomly picked to be obscure:

minsec=60
sched_clock: 32 bits at 183MHz, resolution 5ns, wraps every 23469ms
Orion: shift = 27 mult = 733430208
minsec=5
sched_clock: 32 bits at 183MHz, resolution 5ns, wraps every 23469ms
Orion: shift = 29 mult = 2933720831

1 * 733430208 / 2^27
5.46448087692260742187
1 * 2933720831 / 2^29
5.46448087505996227264

The difference between is 1.00000000034086406226 - so about 34 parts
per trillion. (34 * 10^-12)

Now, a Caesium fountain frequency standard may have an accuracy of
approx. 1 part in 10^-14.  Rubidium frequency standards are around
1 part in 10^-12.

A standard crystal oscillator is around 1 part in 10^-6 to 10^-7.  If
you really care about accuracy, you might use an ovened crystal
oscillator (OXCO) which'll get you to around 1 part in 10^-7..10^-9,
still well short of the calculation inaccuracy.  You wouldn't use an
OXCO in a battery operated device though due to power consumption.

We're generally don't have a Caesium or Rubidium frequency standard, not
even a OXCO providing the clock source for the counter, so the accuracy
of the counters clock is much more significant than the conversion
factors by a factor of about one million.

What I'm saying is that there becomes a time where it really doesn't
matter if the conversion isn't accurate, provided it's accurate enough,
and it would appear to be accurate enough.
