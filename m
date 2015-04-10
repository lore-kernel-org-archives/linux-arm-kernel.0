From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 17:08:17 +0100
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <5527EC90.9050900@free.fr>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk>
 <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk>
 <5527EC90.9050900@free.fr>
Message-ID: <20150410160817.GH12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 05:30:24PM +0200, Mason wrote:
> I appreciate (very much so) that you spend time replying to me,
> but I also sense a lot of animosity, and I don't know what I've
> done wrong to deserve it :-(

I'm putting the point across strongly because I really don't think
there is an issue to be solved here.

> On 10/04/2015 17:06, Russell King - ARM Linux wrote:
> >And what this means is that udelay(n) where 'n' is less than the
> >period between two timer interrupts /will/ be, and is /expected to
> >be/ potentially shorter than the requested period.
> 
> You've made it clear how loop-based delays are implemented; and also
> that loop-based delays are typically 1% shorter than requested.
> (Thanks for the overview, by the way.) Please note that I haven't
> touched to the loop-based code, I'm only discussing the timer-based
> code.

1% is a figure I pulled out of the air.  It really depends on the CPU
instructions per cycle, and how much work is being done in the timer
interrupt handler.

> >There's no getting away from that, we can't estimate how long the timer
> >interrupt takes to handle without the use of an external timer, and if
> >we've got an external timer, we might as well use it for all delays.
> 
> Exactly! And my patch only changes __timer_const_udelay() so again I'm
> not touching loop-based code.

What I'm trying to get through to you is that udelay() as a _whole_ does
not provide a guarantee that it will wait for _at least_ the time you
asked for.  All that it does is provide an _approximate_ delay.

Yes, we can improve the timer delays to provide a guaranteed delay of at
least the requested period.  We _can't_ do the same for the loop-based
delay.

So, if we fix the timer based delays, udelay() will then have two differing
expectations depending on whether it's using a timer or a loop based delay.
That is bad.  It's extremely poor.  The expectations of an API should not
change because of a different implementation, that's the way bugs happen.

That's why...

> >No.  See above.  Not doing that.  Live with it.

it's not a problem, and why we're not going to fix the timer code to
provide a minimum guaranteed delay.

> Specifically, should a driver writer use
> 
>   udelay(101);
> 
> when his spec says to spin 100 ?s?
> 
> (Anyway, this is just a tangential question, as I digest the ins
> and outs of kernel and driver development.)

A driver writer should always use the required delay plus an adequate
cushion to ensure that the delay required by the hardware is met.

I suggest you read this:

	https://lkml.org/lkml/2011/1/9/37

which is the discussion I had with Linus on the point you are raising
here, which is the 4th hit in google for "udelay shorter delays".

Given that some udelay() implementations have been known to be as much
as 50% off, that suggests using a delay value of 200 in your above
example for a delay of 100?s.  ARM is /relatively/ good in that
regard, cpufreq and scheduling effects withstanding.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
