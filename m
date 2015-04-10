From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 12:44:16 +0100
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <5527B331.5000205@free.fr>
References: <5527B331.5000205@free.fr>
Message-ID: <20150410114415.GC12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 01:25:37PM +0200, Mason wrote:
> If I understand correctly, most drivers expect udelay(N) to spin for
> at least N ?s. Is that correct? In that use case, spinning less might
> introduce subtle heisenbugs.

We've never guaranteed this.

The fact is that udelay() can delay for _approximately_ the time you
ask for - it might be slightly shorter, or it could be much longer
than you expect.  On most UP implementations using the software loop
it will typically be around 1% slower than requested.

Adding 1us to every delay is going to be very bad.  Rather than doing
that, why not arrange for the rounding error to be accomodated?

> Typical example
> 
> timer->freq = 90 kHz && HZ = 100
> (thus UDELAY_MULT = 107374 && ticks_per_jiffy = 900)
> 
> udelay(10) => __timer_const_udelay(10*107374)
>            => __timer_delay((1073740*900) >> 30)
>            => __timer_delay(0)

In other words, add (1 << 30) - 1 before shifting right by 30.

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
