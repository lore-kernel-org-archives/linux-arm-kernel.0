From: stigge@antcom.de (Roland Stigge)
Date: Wed, 16 May 2012 14:24:02 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <4FB39C62.3030305@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/16/2012 01:04 PM, Russell King - ARM Linux wrote:
> This series removes the dependence on the dma_slave_config direction
> argument for the PL08x DMA engine driver, and in doing so, we end up
> with less code in the driver.
> 
> We now compute the cctl values for both directions, and continue to
> select the appropriate one at prepare time.  If this is found to be
> invalid, the prepare function will return NULL.
> 
> However, we still use the direction argument in the slave configuration
> call to determine whether we should report and fail an invalid
> configuration.  Eventually this will be removed.
> 
> * This has only been compile tested.  Test feedback welcomed. *
> 
>  drivers/dma/amba-pl08x.c   |  196 +++++++++++++++++++++++++++++---------------
>  include/linux/amba/pl08x.h |   84 +------------------
>  2 files changed, 134 insertions(+), 146 deletions(-)
> 

After applying series 1-6 (as well as with 1-7), my just posted LPC32xx
NAND drivers have problems mounting the MTD (basically, NAND page reads,
DMA dev to mem from NAND controller internal buffers).

* SLC driver says:

lpc32xx-nand 20020000.flash: FIFO not empty!
lpc32xx-nand 20020000.flash: FIFO held data too long
lpc32xx-nand 20020000.flash: DMA FIFO failure

* MLC driver just gets bad data resulting in detected bad blocks.

Without the patches, they work as tested.

Any hints, before I find the time to sort out all the details with
amba-pl08x?

Thanks,

Roland
