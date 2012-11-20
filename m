From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 18:10:59 +0900
Subject: [PATCH 3/4] i2c-s3c2410: use exponential back off while polling
 for bus idle
In-Reply-To: <CAGS+omCKm+aN9ZXApmQJh1OrST-t2sA8WP7NyDOzKnv-xqJ5vg@mail.gmail.com>
References: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
 <1352981613-2098-4-git-send-email-ch.naveen@samsung.com>
 <20121120044859.GA10154@sirena.org.uk>
 <CAGS+omCKm+aN9ZXApmQJh1OrST-t2sA8WP7NyDOzKnv-xqJ5vg@mail.gmail.com>
Message-ID: <20121120091056.GZ10560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 04:57:16PM +0800, Daniel Kurtz wrote:
> On Tue, Nov 20, 2012 at 12:49 PM, Mark Brown

> > On the hardware I was using when I wrote the original code here we were
> > hitting 1-2 spins often enough to be interesting - starting off with a
> > direct busy wait was definitely useful when doing large batches of I/O,
> > especially compared to sleeps which might cause us to schedule.

> We check the status first to avoid any sleep()/schedule() in the case,
> that the CPU is slower than I2C transaction.

Right, but this only works if we hit this on the very first spin.

> Remember, this loop only happens after the event_wait loop has been
> woken up by the i2c irq.

Duh.

> Since you are talking about hitting a tiny window of time at some
> arbitrary point after an irq, the CPU time to this point & I2C
> finishing would have to be very precisely aligned for the 1-2 loops
> (at CPU clock rate) to matter.

On some systems that can happen enormously reliably, finger in the air
it's your fast case on the A15s you're playing with scaled down to a
much slower CPU.  The 20 spins I was setting the loop to was a massive
overestimate for conservativism but more than 1 was common enough, IIRC
spinning 5 times would have covered essentially everything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/8c42a44d/attachment-0001.sig>
