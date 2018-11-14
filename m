From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2018 07:58:17 +0000
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
Message-ID: <20181114075817.GQ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 02:35:29PM +1300, Michael Schmitz wrote:
> So we'd still have to use jiffies + interpolation from the current timer
> rundown counter as clocksource (since that will be monotonous and won't
> wrap)?
> 
> The way Finn did the clocksource for m68k, the clocksource counter does
> behave as it should (monotonous, doesn't wrap) at least so far as I've
> tested. Using the same timer for clocksource and clock events will degrade
> timekeeping based on timer events to jiffies resolution, as you point out.
> That would already have been the case before, so no gain in resolution.

... and that is where you are wrong.

RPC, for example, has gettimeofday() resolution of 500ns.  Removing
gettimeoffset() will result in a resolution of 1/HZ since there is
no longer any interpolation between interrupts.

> Other timekeeping would have worked at higher resolution before
> (interpolating through arch_gettimeoffset) just the same as now
> (interpolating through clocksource reads). Finn's clocksource read code
> essentially is arch_gettimeoffset under a new name.

Where is this code - all I've seen is code adding IRQ exclusion in
the gettimeoffset method.  If some other solution is being proposed,
then it's no good beating about the bush - show the damn code, and
then that can be considered.

However, what has been said in this thread is basically "remove the
gettimeoffset method", which is _not_ acceptable, it will cause
gettimeofday() on these platforms to lose resolution, which is a
user visible REGRESSION, plain and simple.

If what is actually meant is "we have a replacement for gettimeoffset"
then, and I'm sure we all know this, there needs to be a patch
proposed showing what is being proposed, rather than waffling around
the issue.

> Are you saying that's not possible on arm, because the current timer rundown
> counter can't be read while the timer is running?
> 
> If I were to run a second timer at higher rate for clocksource, but keeping
> the 10 ms timer as clock event (could easily do that by using timer D on
> Atari Falcon) - how would that improve my timekeeping? Clock events still
> only happen 10 ms apart ...

Ah, I think you're talking about something else.

You seem to be talking about what happens when time keeping interrupts
happen.

I'm talking about the resolution of gettimeofday() and the other
interfaces that are used (eg) for packet capture timestamping and
the like - the _user_ visible effects of the timekeeping system.

With the existing implementation, all these have better-than-jiffy
resolution - in the case of RPC, that's 500ns, rather than 10ms
which would be the case without gettimeoffset().  Removing
gettimeoffset() as Finn has proposed without preserving that
resolution is simply completely unacceptable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
