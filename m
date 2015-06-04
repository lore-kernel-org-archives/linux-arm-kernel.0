From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 4 Jun 2015 08:02:49 +0200
Subject: [PATCH v5 0/6] i2c: at91: add support to FIFOs and alternative
 command
In-Reply-To: <cover.1433348016.git.cyrille.pitchen@atmel.com>
References: <cover.1433348016.git.cyrille.pitchen@atmel.com>
Message-ID: <20150604060249.GB11060@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the whole set of patches:
Acked-by: Ludovic Desroches

Thanks Cyrille

On Wed, Jun 03, 2015 at 06:25:16PM +0200, Cyrille Pitchen wrote:
> ChangeLog
> 
> v5:
> - print I2C controller version in an already existing dev_info() instead of
>   adding a new one.
> 
> v4:
> - replace 0x%x by %#x when printing I2C controller version
> - change the order of patches: the race condition bug fix becomes the first
>   patch so it be can more easily applied to older kernels.
> 
> v3:
> - fix braces {} coding style issue
> - split the alternative command patch into 2 patches: the first one fixes
>   a race condition whereas the second one is the actual alternative command
>   patch
> 
> v2:
> - fix typo in comment for AT91_TWI_SVEN.
> - document new device tree bindings like "atmel,fifo-size".
> - explicitly set the has_alt_cmd boolean to false to already existing chip
>   configs.
> - use the BIT() macro to define the register bits and do a little cleanup in a
>   dedicated patch.
> - reword some comments to better explain why the TXCOMP interrupt is no longer
>   enabled in at91_do_twi_transfer() but later in
>   at91_twi_write_data_dma_callback() to avoid a race condition when DMA is used.
> - remove useless TXCOMP interrupt enable line in at91_twi_write_next_byte()
>   since this interrupt is also enabled by at91_do_twi_transfer() for PIO
>   transfers.
> 
> v1:
> This series of patches adds support of two new features which will be
> introduced with Atmel sama5d2x SoC.
> 
> First, the alternative command mode eases the sending of STOP conditions.
> Before starting an I2C transaction, the size data to be transfered is
> written into the new Alternative Command Register. For each byte transferred,
> the I2C controller decreases this counter and automatically sends a STOP
> condition when the counter value reaches 0, that is to say when the last byte
> of the transaction has been sent/received. So there is no longer need to set
> the STOP bit into the Control Register.
> 
> Then the use of FIFOs allows to reduce number I/O accesses: for instance,
> the TX FIFO allows to write up to 4 data in a single access to the Transmit
> Holding Register. Also the RX FIFO allows to read up to 4 data in a single
> access to the Receive Holding Register. Currently only DMA transfers take
> advantage of FIFOs.
> 
> Cyrille Pitchen (6):
>   i2c: at91: fix a race condition when using the DMA controller
>   i2c: at91: use BIT() macro to define register bits
>   i2c: at91: update documentation for DT bindings
>   i2c: at91: add support for new alternative command mode
>   i2c: at91: print hardware version
>   i2c: at91: add support to FIFOs
> 
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt |  29 +-
>  drivers/i2c/busses/i2c-at91.c                      | 356 +++++++++++++++++----
>  2 files changed, 322 insertions(+), 63 deletions(-)
> 
> -- 
> 1.8.2.2
> 
