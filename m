From: egtvedt@samfundet.no (Hans-Christian Noren Egtvedt)
Date: Sun, 24 Jan 2016 21:37:21 +0100
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <yw1xsi1mlogt.fsf@unicorn.mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124200959.GA15633@samfundet.no>
 <yw1xsi1mlogt.fsf@unicorn.mansr.com>
Message-ID: <20160124203720.GA29010@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Sun 24 Jan 2016 20:19:46 +0000 or thereabout, M?ns Rullg?rd wrote:
> Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> writes:
>> Around Sun 24 Jan 2016 19:21:50 +0000 or thereabout, Mans Rullgard wrote:
>>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> 
>>> The source and destination masters are reflecting buses or their layers to
>>> where the different devices can be connected. The patch changes the master
>>> names to reflect which one is related to which independently on the transfer
>>> direction.
>>> 
>>> The outcome of the change is that the memory data width is now always limited
>>> by a data width of the master which is dedicated to communicate to memory.
>>> 
>>> The patch will not break anything since all current users have the same data
>>> width for all masters. Though it would be nice to revisit avr32 plaforms to
>>> check what is the actual hardware topology is used there. It seems that it has
>>> one bus and two masters on it as stated by Table 8-2, that's why everything
>>> works independently on the master in use. The purpose of the sequential patch
>>> is to fix the driver for configuration of more that one bus.
>>
>> Not entirely sure what you want to have confirmed here. There are multiple
>> masters and slaves on the HMATRIX internal bus on AVR32, and the DMA
>> controller supports up to three simultaneous configurations.
>>
>> Sounds good to support configuration of more than one bus. I thought we
>> always did support that? Perhaps it was a non-standard avr32 implementation.
> 
> The DW DMA controller on the AT32AP7000 serves the MCI, AC97, and ABDAC
> peripherals.  It appears to work regardless of the values put in the
> various master select fields.  Perhaps the topology is hardwired in the
> DMA controller and those fields are ignored.  The AVR32 works both
> before and after this patch series, the main purpose of which (at least
> my patches) is to fix the SATA driver on 460EX.

DEST_PER and SRC_PER in the DMA controller selects this, numbers placed here
should match the table you most likely found, 9-3.

Wiring the handshake connections is done with the struct dw_dma_slave src_id
or dst_id member, depending on data direction. Configured in the at32ap700x.c
machine code.

It is not hard wired on avr32, as there are not one-to-one configurations and
masters.

>>> The change is done in the assumption that src_master and dst_master are
>>> reflecting a connection to the memory and peripheral correspondently on all
>>> platforms except 460ex.

OK, I have no knowledge about the 460ex.

>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>
>> For the avr32 related stuff:
>>
>> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>>
>>> ---
>>>  Documentation/devicetree/bindings/dma/snps-dma.txt |  4 ++--
>>>  arch/avr32/mach-at32ap/at32ap700x.c                | 16 ++++++++--------
>>>  drivers/ata/sata_dwc_460ex.c                       |  4 ++--
>>>  drivers/dma/dw/core.c                              | 15 +++++++--------
>>>  drivers/dma/dw/platform.c                          | 12 ++++++------
>>>  drivers/dma/dw/regs.h                              |  4 ++--
>>>  drivers/spi/spi-pxa2xx-pci.c                       |  8 ++++----
>>>  drivers/tty/serial/8250/8250_pci.c                 |  8 ++++----
>>>  include/linux/platform_data/dma-dw.h               |  8 ++++----
>>>  9 files changed, 39 insertions(+), 40 deletions(-)
>>
>> <snipp diff>
-- 
Best regards, Hans-Christian Egtvedt
