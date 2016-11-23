From: slash.tmp@free.fr (Mason)
Date: Wed, 23 Nov 2016 11:25:44 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
Message-ID: <58356EA8.2010806@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On my platform, setting up a DMA transfer is a two-step process:

1) configure the "switch box" to connect a device to a memory channel
2) configure the transfer details (address, size, command)

When the transfer is done, the sbox setup can be torn down,
and the DMA driver can start another transfer.

The current software architecture for my NFC (NAND Flash controller)
driver is as follows (for one DMA transfer).

  sg_init_one
  dma_map_sg
  dmaengine_prep_slave_sg
  dmaengine_submit
  dma_async_issue_pending
  configure_NFC_transfer
  wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
  wait_for_NFC_idle
  dma_unmap_sg


The problem is that the DMA driver tears down the sbox setup
as soon as it receives the IRQ. However, when writing to the
device, the interrupt only means "I have pushed all data from
memory to the memory channel". These data have not reached
the device yet, and may still be "in flight". Thus the sbox
setup can only be torn down after the NFC is idle.

How do I call back into the DMA driver after wait_for_NFC_idle,
to request sbox tear down?

The new architecture would become:

  sg_init_one
  dma_map_sg
  dmaengine_prep_slave_sg
  dmaengine_submit
  dma_async_issue_pending
  configure_NFC_transfer
  wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
  wait_for_NFC_idle
  request_sbox_tear_down /*** HOW TO DO THAT ***/
  dma_unmap_sg


As far as I can tell, my NFC driver should call dmaengine_synchronize ??
(In other words request_sbox_tear_down == dmaengine_synchronize)

So the DMA driver should implement the device_synchronize hook,
and tear the sbox down in that function.

Is that correct? Or am I on the wrong track?

Regards.
