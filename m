From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 15:19:44 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
Message-ID: <20110103151944.GA32508@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another issue to think about in terms of API guarantees...

Pausing an on-going transfer (which from what I read is a recent addition
to the API) can be problematical - having tripped over one such problem
on my Realview EB (PL081 rev1) platform.

With the PL08x, when you program a channel up for a M->P transfer and
enable it, the DMAC will immediately fetch data from memory and mark
itself busy before the first DMA request from the peripheral.

When the first DMA request occurs from the peripheral, the DMAC starts
feeding this data to the peripheral, and fetches new data into its FIFO
as required.

The problem comes when the peripheral stops requesting data from the
DMAC, and then you want to pause it.  Current code sets the HALT bit,
and then spins indefinitely for the BUSY bit to clear - which it will
only ever do if the peripheral drains the FIFO.  As a result of botched
DMA signal selection code for the Realview EB, the DMA signals never
went active, and on terminate_all() the CPU locked up solid (no
interrupts) spinning on the DMAC to clear the busy bit.

It may be worth specifying that a pause followed by a resume is
expected to never lose data - and that drivers must check the result
of a request to pause the channel.  If DMA engine drivers are unable
to pause the channel within a reasonable amount of time, they should
return -ETIMEOUT, so they know that there may still be data that
could still be transferred to the peripheral.

One important note about this condition is that with the DMA channel
marked BUSY+HALT and the channel being configured for M->P, the
peripheral can still transfer data from the DMAC to itself, and this
causes the transfer size value in the CNTL register to decrement (since
reading the CNTL register returns the number of transfers _to_ the
destination, not the number of transfers from the source.)

I've changed the comment against pl08x_pause_phy_chan() to this:

 * Pause the channel by setting the HALT bit.
 *
 * For M->P transfers, pause the DMAC first and then stop the peripheral -
 * the FIFO can only drain if the peripheral is still requesting data.
 * (note: this can still timeout if the DMAC FIFO never drains of data.)
 *
 * For P->M transfers, disable the peripheral first to stop it filling
 * the DMAC FIFO, and then pause the DMAC.

I've not decided whether it should be possible to resume an ETIMEOUT'd
pause request (in theory with pl08x, that's just a matter of clearing
the HALT bit) or whether an ETIMEOUT'd pause request should restore
the previous HALT bit setting (possibly re-enabling transfers on the
channel.)  Allowing it to be re-enabled in some way would be the safest
thing in terms of data integrity for the reason mentioned in the
"important note" above.

Dan, Linus, any thoughts?
