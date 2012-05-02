From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 May 2012 15:45:55 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
Message-ID: <20120502144555.GA4456@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan, Vinod,

What is the desired behaviour of the callback for cyclic DMA?

My understanding is:
1. Such callbacks will be made from tasklet context.
2. Exactly one callback will be issued for every 'period' of the transfer
   which has completed.

My main reason for asking is point (2) - because tasklets have a property
which means that they are guaranteed to run exactly once after a
tasklet_schedule() call even if there are further tasklet_schedule()
calls before the tasklet is actually run.  This property can lead to
dropped callbacks unless DMA engine authors have thought about this.

Alternatively, we could document that for cyclic transfers, one callback
will be made after the expiry of a period or number of periods.  In
other words, if two periods expire before we issue the callback, the
user will only get _one_ callback issued.  In that case, we definitely
need some way to determine the DMA position...

The next issue is this tx_status method, and the residue bytes returned.
There seems to be quite a bit of confusion over what this is, and what
it should be, and its relationship to the passed in cookie.  The drivers
I've seen using it appear to total up the number of pending bytes to
be transferred for every transfer which has been issued.  This seems
wrong to me, I think it should be the number of bytes left until the
transfer with the specified cookie has completed.

Moreover, what's the requirement here when we're using cyclic transfers?
If we take that same definition, then, because cyclic transfers never
complete, effectively they have an infinite number of bytes.  That's not
useful.  What would be more useful is if this was defined as the number
of bytes to the end of the cyclic buffer - or something similar.  That
then would allow the current DMA position to be determined for applications
like ASoC to know how much of the buffer it could refill with new data.
