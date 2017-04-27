From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 27 Apr 2017 15:14:28 +0200
Subject: [PATCH 4/4] mmc: pxamci: Fix race condition between
 pxamci_dma_irq() and pxamci_irq()
In-Reply-To: <43c3a3b4-75b5-613e-4e28-9c38271ccb63@tul.cz> (Petr Cvek's
 message of "Fri, 21 Apr 2017 03:30:10 +0200")
References: <cover.1492492523.git.petr.cvek@tul.cz>
 <31e332fa-f152-1eff-39fb-91f332b84757@tul.cz>
 <87fuh46w3r.fsf@belgarion.home>
 <43c3a3b4-75b5-613e-4e28-9c38271ccb63@tul.cz>
Message-ID: <87inlq0z7v.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Dne 19.4.2017 v 21:22 Robert Jarzmik napsal(a):
>> Petr Cvek <petr.cvek@tul.cz> writes:

Hi Petr,

As promised, I though it a bit more, and I have a counter proposal, which looks
simpler (if it works for you).

Why not remove completely the call to pxamci_data_done() from pxamci_dma_irq() ?
The pxamci_dma_irq() will only remain for the partial full write, and for the
dev_err() part, but won't act on command completion, that part being full dealt
with by pxamci_data_done().

I still seeing a small race window, in that :
 - DATA_TRAN_DONE is asserted for a MMC read transaction, because the MMC FIFO
   was just emptied by the DMA IP
 - imagine the memory is not yet written to by the DMA IP (ie. this is the race
   window, the DATA being help in DMA IP internal FIFO)
 - the pxamci_data_done() is called, and it calls dma_unmap_sg(), flushing the
   cache
 - the consumer reads this last data bit, which is still the old data, and then
   the DMA finishes ...

I know the probability is almost 0 for this scenario to happen given the
timings, it's just to add fuel to the technical exchange.

> The patches 1, 1+2, 1+2+3 should boot, but the MMC will of course fail as only
> the 4 repairs it. Do you want me to send them independently? (or I can sort
> them that the race condition repair is the first one)
No no, I like it the way it is, and as far as Ulf is happy as his tree will
carry them, I'm happy too.

Cheers.

--
Robert
