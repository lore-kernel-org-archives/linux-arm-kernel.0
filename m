From: slash.tmp@free.fr (Mason)
Date: Tue, 6 Dec 2016 23:55:49 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xshq12hr9.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <5846D814.9010106@free.fr>
 <yw1xshq12hr9.fsf@unicorn.mansr.com>
Message-ID: <40d34477-b10c-334a-135b-33f23318f2bc@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2016 16:34, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> Meh. The two controller blocks share the I/O pins to the outside
>> world, so it's not possible to have two concurrent accesses.
> 
> OK, you failed to mention that part.  Why are there two controllers at
> all if only one or the other can be used?

I'd have to ask the HW designer what types of use-cases he had
in mind. Perhaps looking at what is *not* shared provides clues.
Configuration registers are duplicated, meaning it is possible
to decide "channel A for chip0, channel B for chip1" if there
are two NAND chips in the system (as is the case on dev boards).
In that case, it is unnecessary to rewrite the chip parameters
every time the driver switches chips. (I don't think the perf
impact is even measurable.)

The ECC engines are duplicated, but I don't know how long it
takes to run the BCH algorithm in HW vs performing I/O over
a slow 8-bit bus.


>> The callback is called from vchan_complete() right?
>> Is that running from interrupt context?
> 
> It runs from a tasklet which is almost the same thing.

I'll read up on tasklets tomorrow.


>> I can give that a shot (if you're busy with real work).
> 
> I have an idea I'd like to try out over the weekend.  If I don't come
> back with something by next week, go for it.

I do have my plate full this week, with XHCI and AHCI :-)


>> Why can't we queue channel requests the same way we queue
>> transfer requests?
> 
> That's in effect what we're doing.  Calling it by another name doesn't
> really solve anything.

Hmmm... the difference is that "tear down" would be explicit
in the release function.

Current implementation for single transfer:

dmaengine_prep_slave_sg()
dmaengine_submit()
dma_async_issue_pending()	/* A */
wait for read channel IRQ	/* B */
spin until NFC idle		/* C */

Setup SBOX route and program MBUS transfer happen in A.
The SBOX route is torn down a little before B (thus before C).


With the proposed implementation, where request_chan
sets up the route and release_chan tears it down:

request_chan()			/* X */
dmaengine_prep_slave_sg()
dmaengine_submit()
dma_async_issue_pending()	/* A */
wait for read channel IRQ	/* B */
spin until NFC idle		/* C */
release_chan()			/* Y */

Now, the SBOX route is setup in X.
(If no MBUS channel are available, thread is put to sleep
until one becomes available.)
Program MBUS transfer in A.
When IRQ falls, cannot start new transfer yet.
vchan_complete() will at some point run the client callback.
The client driver can now spin however long until NFC idle.
In Y, we release the channel, thus calling back into the
DMA driver, at which point a new transfer can be started.

What did I get wrong in this pseudo-code?


I do see one problem with the approach:
It's no big deal for me to convert the NFC driver to
do it that way, but the Synopsys (I think) SATA driver
in tango3 and tango4 is shared across multiple SoCs,
and they probably call request_chan() only in the
probe function, as you mentioned at some point.

http://lxr.free-electrons.com/source/drivers/ata/sata_dwc_460ex.c#L366

BTW, can someone explain what the DMA_CTRL_ACK flag means?


Regards.
