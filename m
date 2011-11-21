From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Nov 2011 16:34:00 +0000
Subject: [PATCH RFC] ARM: unwind: optimize to not convert each table
 value but the address
In-Reply-To: <1321830763-7227-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20111120225207.GB30612@pengutronix.de>
 <1321830763-7227-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111121163359.GD3272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2011 at 11:12:42PM +0000, Uwe Kleine-K?nig wrote:
> The offsets in the unwind index section are signed 31 bit numbers and
> the structs are sorted by this offset. So it first has offsets between
> 0x40000000 and 0x7fffffff (i.e. the negative offsets) and then offsets
> between 0x00000000 and 0x3fffffff. When seperating these two blocks the
> numbers are sorted even when interpreting the offsets as unsigned longs.
> 
> So instead of converting each offset hit during bisection to an absolute
> address, first determine which of the blocks needs to be searched and
> then adapt the key to find for the offset while bisecting using a simple
> unsigned long comparison.
> 
> In my tests this is faster than the original implementation modifying
> the unwind index section by 4.5%.

If you don't care about the 7% unwinding performance drop on XIP
kernels, we could just have a prel31_lt() macro (or whatever other name)
which is a standard '<' comparison on !XIP kernels and does the prel31
conversion with XIP. It's only two places in search_index() where it is
needed and the code would still be more readable than the changes in
this patch :).

If you still want such improvement, I'll do a proper review of the
patch.

Thanks.

-- 
Catalin
