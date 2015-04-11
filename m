From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Apr 2015 13:10:49 +0100
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <55290C18.8070301@free.fr>
References: <20150410114415.GC12732@n2100.arm.linux.org.uk>
 <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk>
 <5527EC90.9050900@free.fr>
 <20150410160817.GH12732@n2100.arm.linux.org.uk>
 <55282C1F.3000600@free.fr>
 <20150410204221.GI12732@n2100.arm.linux.org.uk>
 <55283F30.7030109@free.fr>
 <20150411073022.GJ12732@n2100.arm.linux.org.uk>
 <55290C18.8070301@free.fr>
Message-ID: <20150411121049.GM12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 01:57:12PM +0200, Mason wrote:
> On 11/04/2015 09:30, Russell King - ARM Linux wrote:
> 
> > On Fri, Apr 10, 2015 at 11:22:56PM +0200, Mason wrote:
> >
> >> It was you who wrote some time ago: "Timers are preferred
> >> because of the problems with the software delay loop."
> >> (My system implements DVFS.)
> >>
> >> It seems to me that a 90 kHz timer is still better than
> >> the jiffy counter, or am I mistaken again?
> > 
> > Given the choice of a 90kHz timer vs using a calibrated software
> > delay loop, the software delay loop wins.  I never envisioned that
> > someone would be silly enough to think
> 
> I'm full of surprises.
> 
> > that a 90kHz timer would somehow be suitable to replace a software
> > delay loop calibrated against a timer.
> 
> Only one message ago, you were arguing that loop-based delays
> could be up to 50% inaccurate. Thus, if one wanted to spin for
> 500 ?s, they'd have to request 1 ms just to be sure. An 11 ?s
> accuracy looks like a better deal to me, overall.
> 
> Add DVFS to the mix, and that 500 ?s loop-based delay turns into
> a 50 ?s delay when the other core decides to boost the cluster
> from 100 MHz to 1 GHz. And then drivers break randomly.

*Think* please.

What you've just said is total rubbish.

As you've already found out, with a 90kHz clock, if you request a 5?s
delay, you get a zero delay.

That's because 90kHz has _insufficient_ resolution to be used for a
microsecond delay, and in that case it is _FAR_ better to use the
software delay loop.

Asking for a 1?s and getting an 11?s delay is _total_ bollocks.  It's
worse than a 50% error.  It's an 1100% error.

As I say, *THINK*.  I know it's a foreign idea.

You're not going to convince me to accept the idea that a 90kHz
counter is going to be suitable for a delay.  In fact, what you're
actually doing is convincing me that we need to put a test into
arch/arm/lib/delay.c to stop this stupidity: prevent it considering
any counter which does not have a clock rate in the MHz range.

That means we will reject your stupid 90kHz counter, and your
problem will be solved.

What this also means is that if you only have a 90kHz counter
available, doing DVFS is also a stupid idea.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
