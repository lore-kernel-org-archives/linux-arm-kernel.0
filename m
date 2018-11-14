From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2018 12:05:00 +0000
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
Message-ID: <20181114120500.GE6567@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> Implementations of arch_gettimeoffset are generally not re-entrant
> and assume that interrupts have been disabled. Unfortunately this
> pre-condition got broken in v2.6.32.

To me, it looks way worse than what you think.

The original code sequence before conversion to arch_gettimeoffset()
was:

1. lock (inc. disabling IRQs)
2. read gettimeoffset correction
3. add offset to current xtime
4. unlock

This means there is no chance for a timer interrupt to happen between
reading the current offset and adding it to the current kernel time.
If the timer does roll over, then the interrupt will remain pending,
so the whole "read offset and add to xtime" is one atomic block and
we can use the pending interrupt to indicate whether the timer has
rolled over and apply the appropriate offset correction.

With the arch_gettimeoffset() code, that changes:

1. read clocksource (which will be jiffies)
2. compute clocksource delta
3. increment nanoseconds
4. add gettimeoffset correction

If we receive a timer interrupt part-way through this, for example,
between 2 and 3, then jiffies will increment (via do_timer()) and the
interrupt will be cleared.  This means that the check in
ioc_timer_gettimeoffset() for a pending interrupt, for example, will
be false, and we will not know that an interrupt has happened.

So, unless I'm missing something, commit 5cfc8ee0bb51 well and truely
broke the accuracy of timekeeping on these platforms, and will result
in timekeeping spontaneously jumping backwards.  I had been wondering
why NTP had become less stable on EBSA110, but never investigated.

However, that still does not justify blowing away this functionality
without replacement, as Finn has been proposing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
