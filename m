From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 4 Jan 2016 17:50:29 +0100
Subject: [PATCH linux-next 1/5] mtd: spi-nor: properly detect the memory
 when it boots in Quad or Dual mode
In-Reply-To: <20151218015544.GG10460@google.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <813edd1addf9a09b9f01031d3cb279c8cdfe97bb.1449494420.git.cyrille.pitchen@atmel.com>
 <20151218015544.GG10460@google.com>
Message-ID: <568AA2D5.6080504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Le 18/12/2015 02:55, Brian Norris a ?crit :
> Hi Cyrille,
> 
> On Mon, Dec 07, 2015 at 03:09:10PM +0100, Cyrille Pitchen wrote:
[...]
>> +
>> +			/* Set this protocol for all commands. */
>> +			nor->reg_proto = configs[i].proto;
>> +			nor->read_proto = configs[i].proto;
>> +			nor->write_proto = configs[i].proto;
>> +			nor->erase_proto = configs[i].proto;
> 
> Are these all fully independent? Do we really need 4 fields for this?
> 

Currently, for sure reg_proto and read_proto are independent. Let's take
Spansion memories as an example:
- Fast Read Quad Data 0x6B uses SPI 1-1-4
- register accesses (read/write) use SPI 1-1-1

AFAIK, Quad IO write commands are not used yet but if one day they are, for
instance with Macronix memories (QPI mode disabled):
- 4x I/O Page Program 0x38 uses SPI 1-1-4
- register accesses (read/write) uses SPI 1-1-1
- Fast Read Quad I/O 0xEB uses SPI 1-4-4
- Sector Erase 0x20 uses SPI 1-1-1

For now, I don't have any example where erase_proto is different from
reg_proto but for clarity reasons I'd rather keep erase_proto and reg_proto
distinct. Otherwise both field should be renamed as it looks odd to use
reg_proto when implementing the nor->erase() hook, doesn't it?

The names were chosen according to both the *_opcode and hooks from the
struct spi_nor:

hook           op code          protocol
read_reg()     N/A              reg_proto
write_reg()    N/A              reg_proto
read()         read_opcode      read_proto
write()        program_opcode   write_proto
erase()        erase_opcode     erase_proto

I admit following this logic 'program_opcode' should be renamed
'write_opcode'.



[...]
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index fac3f6f53981..c91986a99caf 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -75,8 +75,9 @@
>>  #define SPINOR_OP_BRWR		0x17	/* Bank register write */
>>  
>>  /* Used for Micron flashes only. */
>> -#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
>> -#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
>> +#define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
>> +#define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
>> +#define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
>>  
>>  /* Status Register bits. */
>>  #define SR_WIP			BIT(0)	/* Write in progress */
>> @@ -105,6 +106,16 @@ enum read_mode {
>>  	SPI_NOR_QUAD,
>>  };
>>  
>> +enum spi_protocol {
>> +	SPI_PROTO_1_1_1,	/* SPI */
>> +	SPI_PROTO_1_1_2,	/* Dual Output */
>> +	SPI_PROTO_1_1_4,	/* Quad Output */
>> +	SPI_PROTO_1_2_2,	/* Dual IO */
>> +	SPI_PROTO_1_4_4,	/* Quad IO */
>> +	SPI_PROTO_2_2_2,	/* Dual Command */
>> +	SPI_PROTO_4_4_4,	/* Quad Command */
> 
> Would it help at all to make this enum into something more like a
> bitfield? So in some cases, rather than a bit switch block, we can just
> extract the "number of lines" from the integer value? e.g.:
> 
> #define SNOR_PROTO(command, addr, data) \
> 	(((command) << 0) | \
> 	 ((addr) << 4) | \
> 	 ((data) << 8)) // or some other kind of macro magic
> 
> enum spi_nor_protocol {
> 	SNOR_PROTO_1_1_1		= SNOR_PROTO(1, 1, 1),
> 	SNOR_PROTO_1_1_2		= SNOR_PROTO(1, 1, 2),
> 	...
> };
> 
> static inline int spi_nor_io_lines_command(enum spi_nor_protocol proto)
> {
> 	return proto & 0xf;
> }
> 
> (Similar for addr and data phases. Also, my naming might suck. Feel free
> to improve!)
> 
> I don't think we should stomp on the SPI namespace with the
> "SPI_PROTO_*" definitions. That's why I chose SNOR_PROTO_ and spi_nor_
> prefixes.
> 

It looks good to me so I'll change for that :)

> Brian


Best regards,

Cyrille
