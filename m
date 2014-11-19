From: w@1wt.eu (Willy Tarreau)
Date: Wed, 19 Nov 2014 17:57:00 +0100
Subject: ARM: mvebu: ethernet packets corruption and I/O coherency
In-Reply-To: <20141119174007.640b6ed4@free-electrons.com>
References: <20141118142520.GD24819@dev0.local>
 <20141118153035.757fe0fc@free-electrons.com>
 <20141119160108.GJ24819@dev0.local>
 <20141119174007.640b6ed4@free-electrons.com>
Message-ID: <20141119165700.GC30756@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 05:40:07PM +0100, Thomas Petazzoni wrote:
> > Do you think that this bug on I/O cache coherency could also trigger some
> > sporadic random OOPS and kernel panic? I got an OOPS with a broken LR in
> > skb_segment() and a kernel panic in put_page(), but I was never able to
> > reproduce any of them.
> 
> It's hard to say exactly what could happen with the wrong I/O cache
> coherency setup. I would expect only the buffers used for DMA to not be
> updated properly, but I might be wrong.

Interestingly I used to experience some random panics under high network
loads on the mirabox and I never knew whether they were attributed to the
power supply or to cache corruption. But since I have modified the driver
and cache management to synchronize caches before the Rx loop, I haven't
encountered them anymore. It could be a pure coincidence just like it
could also be more or less related, maybe due to the fact that the cache
is synchronized much earlier than the data are used and that this changes
the access patterns.

Just my few cents,
Willy
