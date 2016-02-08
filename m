From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Feb 2016 08:43:24 +0530
Subject: [PATCH v4] dmaengine: edma: fix residue race for cyclic
In-Reply-To: <87k2mu2e16.fsf@linutronix.de>
References: <87k2mu2e16.fsf@linutronix.de>
Message-ID: <20160208031324.GJ2531@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 11:29:08AM +0100, John Ogness wrote:
> When retrieving the residue value, the SRC/DST fields of the
> active PaRAM are read to determine the current position of
> the DMA engine. However, the AM335x Technical Reference Manual
> states:
> 
>   11.3.3.6 Parameter Set Updates
> 
>   After the TR is read from the PaRAM (and is in the process
>   of being submitted to the EDMA3TC), the following fields are
>   updated as needed: ... SRC DST
> 
> This means SRC/DST is incremented even though the DMA transfer
> may not have started yet or is in progress. Thus if the reader
> of the residue accesses the DMA buffer too quickly, the CPU is
> misinformed about the data that has been successfully processed.
> 
> The CCSTAT.ACTV register is a boolean that is set if any TR is
> being processed by either the EMDA3CC or EDMA3TC. By polling
> this register it is possible to ensure that the residue value
> returned is valid for immediate processing. However, since the
> DMA engine may be active, polling may never hit a moment where
> no TR is being processed. To handle this, the SRC/DST is also
> polled to see if it changes. And as a last resort, a max loop
> count for the busy waiting exists to avoid an infinite loop.

Applied, thanks

-- 
~Vinod
