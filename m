From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 25 Nov 2016 10:25:49 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <58356EA8.2010806@free.fr>
References: <58356EA8.2010806@free.fr>
Message-ID: <20161125045549.GC2698@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 11:25:44AM +0100, Mason wrote:
> Hello,
> 
> On my platform, setting up a DMA transfer is a two-step process:
> 
> 1) configure the "switch box" to connect a device to a memory channel
> 2) configure the transfer details (address, size, command)
> 
> When the transfer is done, the sbox setup can be torn down,
> and the DMA driver can start another transfer.
> 
> The current software architecture for my NFC (NAND Flash controller)
> driver is as follows (for one DMA transfer).
> 
>   sg_init_one
>   dma_map_sg
>   dmaengine_prep_slave_sg
>   dmaengine_submit
>   dma_async_issue_pending
>   configure_NFC_transfer
>   wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
>   wait_for_NFC_idle
>   dma_unmap_sg

Looking at thread and discussion now, first thinking would be to ensure
the transaction is completed properly and then isr fired. You may need
to talk to your HW designers to find a way for that. It is quite common
that DMA controllers will fire and complete whereas the transaction is
still in flight.

If that is not doable, then since you claim this is custom part which
other vendors wont use (hope we are wrong down the line), then we can
have a custom api,

foo_sbox_configure(bool enable, ...);

This can be invoked from NFC driver when required for configuration and
teardown. For very specific cases where people need some specific
configuration we do allow custom APIs.

Only problem with that would be it wont be a generic solution and you
seem to be fine with that.


-- 
~Vinod
