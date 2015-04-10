From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Apr 2015 14:41:37 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150410114415.GC12732@n2100.arm.linux.org.uk>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk>
Message-ID: <5527C501.2040808@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2015 13:44, Russell King - ARM Linux wrote:
> On Fri, Apr 10, 2015 at 01:25:37PM +0200, Mason wrote:
>> If I understand correctly, most drivers expect udelay(N) to spin for
>> at least N ?s. Is that correct? In that use case, spinning less might
>> introduce subtle heisenbugs.
>
> We've never guaranteed this.
>
> The fact is that udelay() can delay for _approximately_ the time you
> ask for - it might be slightly shorter, or it could be much longer
> than you expect.

OK, but asking for 10 ?s and spinning 0 is a problem, right?

> On most UP implementations using the software loop
> it will typically be around 1% slower than requested.

Please correct any misconception, it seems to me that typical
driver writers, reading "operation X takes 10 ?s to complete"
will write udelay(10); (if they want to spin-wait)

Do you think they should take the inherent imprecision of loop-based
delays into account, and add a small cushion to be safe?

Also, it seems timer-based delays were introduced, in part, because
they did away with the imprecision of loop-based delays on DVFS
systems.

> Adding 1us to every delay is going to be very bad.  Rather than doing
> that, why not arrange for the rounding error to be accommodated?

Are you saying that my proposed patch blindly adds a 1 ?s delay?

In fact, it adds one /timer cycle/ (which, in my 90 kHz example,
is much more than 1 ?s), and this increment is just rounding up
the conversion result.

So if a user wants to spin N ?s, and N ?s is equivalent to
X.7 cycles, then we delay X+1 cycles.

Regards.
