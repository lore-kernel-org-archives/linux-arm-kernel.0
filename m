From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 23 Nov 2016 12:13:10 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <58356EA8.2010806@free.fr> (Mason's message of "Wed, 23 Nov 2016
 11:25:44 +0100")
References: <58356EA8.2010806@free.fr>
Message-ID: <yw1xpolmbdih.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

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
>
> The problem is that the DMA driver tears down the sbox setup
> as soon as it receives the IRQ. However, when writing to the
> device, the interrupt only means "I have pushed all data from
> memory to the memory channel". These data have not reached
> the device yet, and may still be "in flight". Thus the sbox
> setup can only be torn down after the NFC is idle.
>
> How do I call back into the DMA driver after wait_for_NFC_idle,
> to request sbox tear down?
>
> The new architecture would become:
>
>   sg_init_one
>   dma_map_sg
>   dmaengine_prep_slave_sg
>   dmaengine_submit
>   dma_async_issue_pending
>   configure_NFC_transfer
>   wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
>   wait_for_NFC_idle
>   request_sbox_tear_down /*** HOW TO DO THAT ***/
>   dma_unmap_sg
>
> As far as I can tell, my NFC driver should call dmaengine_synchronize ??
> (In other words request_sbox_tear_down == dmaengine_synchronize)
>
> So the DMA driver should implement the device_synchronize hook,
> and tear the sbox down in that function.
>
> Is that correct? Or am I on the wrong track?

dmaengine_synchronize() is not meant for this.  See the documentation:

/**
 * dmaengine_synchronize() - Synchronize DMA channel termination
 * @chan: The channel to synchronize
 *
 * Synchronizes to the DMA channel termination to the current context. When this
 * function returns it is guaranteed that all transfers for previously issued
 * descriptors have stopped and and it is safe to free the memory assoicated
 * with them. Furthermore it is guaranteed that all complete callback functions
 * for a previously submitted descriptor have finished running and it is safe to
 * free resources accessed from within the complete callbacks.
 *
 * The behavior of this function is undefined if dma_async_issue_pending() has
 * been called between dmaengine_terminate_async() and this function.
 *
 * This function must only be called from non-atomic context and must not be
 * called from within a complete callback of a descriptor submitted on the same
 * channel.
 */

This is for use after a dmaengine_terminate_async() call to wait for the
dma engine to finish whatever it was doing.  This is not the problem
here.  Your problem is that the dma engine interrupt fires before the
transfer is actually complete.  Although you get an indication from the
target device when it has received all the data, there is no way to make
the dma driver wait for this.

-- 
M?ns Rullg?rd
