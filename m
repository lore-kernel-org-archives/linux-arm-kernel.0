From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 4 Jan 2011 11:47:58 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20110103151944.GA32508@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<20110103151944.GA32508@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimfJZ7y-f9Tcd6PAmckiM9DxW7E10YhFwmMCLxM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Pausing an on-going transfer (which from what I read is a recent addition
> to the API)

Added by me to handle the PrimeCells actually, but also needed
especially for good audio streaming.

> The problem comes when the peripheral stops requesting data from the
> DMAC, and then you want to pause it. ?Current code sets the HALT bit,
> and then spins indefinitely for the BUSY bit to clear - which it will
> only ever do if the peripheral drains the FIFO. ?As a result of botched
> DMA signal selection code for the Realview EB, the DMA signals never
> went active, and on terminate_all() the CPU locked up solid (no
> interrupts) spinning on the DMAC to clear the busy bit.

Argh, how typical.

BTW it's great that you have the EB up, I think it's very close or
identical to PB11MPCore and PBA8/PBA9 in this regard.

> It may be worth specifying that a pause followed by a resume is
> expected to never lose data - and that drivers must check the result
> of a request to pause the channel.

Sounds reasonable.

> If DMA engine drivers are unable
> to pause the channel within a reasonable amount of time, they should
> return -ETIMEOUT, so they know that there may still be data that
> could still be transferred to the peripheral.

So the -ETIMEOUT needs to have the semantic meaning
"data is in flight". Doesn't -EBUSY fit better to describe that,
though it will be caused by a spin-loop timeout?

(OK maybe nitpicky, doesn't really matter as long as we specify
*something*, but see below for the better semantic meaning of
this when handling the error code.)

> One important note about this condition is that with the DMA channel
> marked BUSY+HALT and the channel being configured for M->P, the
> peripheral can still transfer data from the DMAC to itself, and this
> causes the transfer size value in the CNTL register to decrement (since
> reading the CNTL register returns the number of transfers _to_ the
> destination, not the number of transfers from the source.)
>
> I've changed the comment against pl08x_pause_phy_chan() to this:
>
> ?* Pause the channel by setting the HALT bit.
> ?*
> ?* For M->P transfers, pause the DMAC first and then stop the peripheral -
> ?* the FIFO can only drain if the peripheral is still requesting data.
> ?* (note: this can still timeout if the DMAC FIFO never drains of data.)
> ?*
> ?* For P->M transfers, disable the peripheral first to stop it filling
> ?* the DMAC FIFO, and then pause the DMAC.

This is exactly how it must work. Thanks Russell.

> I've not decided whether it should be possible to resume an ETIMEOUT'd
> pause request (in theory with pl08x, that's just a matter of clearing
> the HALT bit) or whether an ETIMEOUT'd pause request should restore
> the previous HALT bit setting (possibly re-enabling transfers on the
> channel.) ?Allowing it to be re-enabled in some way would be the safest
> thing in terms of data integrity for the reason mentioned in the
> "important note" above.

Hmhm. One part of me wants the DMAC to clear the state of that
channel completely if this timeout happens and you return
-ETIMEOUT and not allow resuming, but if you return -EBUSY
as per above, the pause has definately failed and there is
nothing to resume, we're still in flight and the only way to
really stop the transfer from that point is to TERMINATE_ALL.

Yours,
Linus Walleij
