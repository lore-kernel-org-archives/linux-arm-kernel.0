From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Fri, 1 May 2015 20:30:04 +0100
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE)
 driver for cygnus
In-Reply-To: <5543CD73.2030902@broadcom.com>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <1429744923-2007-3-git-send-email-jonathar@broadcom.com>
 <6346218.3x3hbSlxMs@wuerfel> <5543CD73.2030902@broadcom.com>
Message-ID: <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It's a bit more than a PTP hardware clock on a NIC. It's a clock for PTP
> plus timestamping 32 other hardware inputs that can be enabled at any
> time with timestamps being generated at varying frequencies. As clients
> are enabled that generate timestamps at higher frequencies, the
> isochronous interrupt frequency needs to be increased so that overflows
> in the the h/w and s/w FIFO's don't occur (this frequency could possibly
> be automated instead of changing it manually as we currently do).

Nice that this is finally happening mainstream having worked on an early
design for this about 25 years ago 8)

> It looks like the driver could almost be a PTP driver instead of a char
> driver controlled with ioctls. PTP does this already using
> clock_gettime(), clock_settime(), clock_adjtime(). But we want to set
> the frequency as well as adjust the clock and I don't see how that is
> possible with the stripped down timex data passed to the driver from
> ptp_clock_adjtime().

Agreed. You also want the plumbing so that socket sk_buffs can be
timestamped by it when it is monitoring the IRQ (the stamp code in the
kernel actually got added way back when for exactly this type of card).

> channel control, unless I'm missing something. If people are flexible
> with extending that I could propose something. Let me know which way you
> prefer to go. Thanks.

I would strongly favour fixing PTP to do this right. Otherwise we will
have 2 or 3 adhoc drivers, then end up moving them to PTP and then end up
dealing with the compat mess.

The only other question I'd ponder is whether aspects of this best fit
PTP or IIO or both depending upon purpose. There's after all no
fundamental reason a driver can't provide services to both types of
consumer depending upon the need.


Alan
