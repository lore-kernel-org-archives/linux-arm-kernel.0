From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 14 Apr 2016 17:23:04 +0200
Subject: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
In-Reply-To: <20160414085707.GE18024@sirena.org.uk>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
 <57067694.8030806@atmel.com>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C720DE@XAP-PVEXMBX02.xlnx.xilinx.com>
 <570F4F9F.3090605@atmel.com> <20160414085707.GE18024@sirena.org.uk>
Message-ID: <570FB5D8.90807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/04/2016 10:57, Mark Brown a ?crit :
> On Thu, Apr 14, 2016 at 10:06:55AM +0200, Cyrille Pitchen wrote:
> 
>> I understand but you propose to patch both the SPI layer and the m25p80 driver
>> to introduce some support which is already provided by the "spi_flash_read"
>> hook: struct spi_flash_read_message has already a "dummy_bytes" field.
>> IMHO, it looks redundant.
> 
> My understanding is that this is intended for dummy bits rather than
> dummy bytes.
> 

dummy_bits == (dummy_bytes * 8) and
dummy_cycles == ((dummy_bytes * 8) / addr_nbits)

witch addr_nbits in {1, 2, 4}

the struct_flash_read_message has both dummy_bytes and addr_nbits members.

The spi-nor framework seems to always provide a multiple of 8 for dummy *bits*.
I guess because the m25p80 driver only supports such number of dummy bits but
also because all SPI memories can be configured so their number of dummy cycles keeps the byte alignment for the data to follow.

It still allows to use less than 8 dummy *cycles*, for instance the factory
settings for Macronix Quad SPI memories are:
- 4 dummy cycles for Fast Read 1-2-2 (hence 8 dummy bits)
- 6 dummy cycles for Fast Read x-4-4 (hence 24 dummy bits)

AFAIK, only Micron QSPI memories could be configured so the number of dummy
cycles doesn't result in a multiple of 8 bits but theirs are not the
recommanded timings provided by the datasheet.

Micron factory settings are:
- 10 dummy cycles for Fast Read x-4-4 (hence 40 dummy bits)
- 8 dummy cycles for other Fast Reads.


Best regards,

Cyrille
