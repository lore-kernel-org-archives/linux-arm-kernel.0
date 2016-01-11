From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 11 Jan 2016 15:30:32 +0100
Subject: [PATCH linux-next v2 03/14] mtd: spi-nor: select op codes and SPI
 NOR protocols by manufacturer
In-Reply-To: <20160111112421.5919b531@bbrezillon>
References: <cover.1452268345.git.cyrille.pitchen@atmel.com>
 <fd5ca97795c35b3df5ffee95075e2e03a70c7e48.1452268345.git.cyrille.pitchen@atmel.com>
 <20160111112421.5919b531@bbrezillon>
Message-ID: <5693BC88.6070907@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Le 11/01/2016 11:24, Boris Brezillon a ?crit :
> Hi,
> 
> On Fri, 8 Jan 2016 17:02:15 +0100
> Cyrille Pitchen <cyrille.pitchen@atmel.com> wrote:
> 
>> This is a transitional patch to prepare the split by Manufacturer of the
>> support of Single/Dual/Quad SPI modes.
>>
>> Indeed every QSPI NOR manufacturer (Spansion, Micron, Macronix, Winbond)
>> supports Dual or Quad SPI modes on its way. Especially the Fast Read op
>> code and the SPI NOR protocols to use are not quite the same depending on
>> the manufacturer.
>>
>> For instance Quad commands can use either the SPI 1-1-4, 1-4-4 or 4-4-4
>> protocol.
>>
>> This is why this patch will be completed by fixes for each manufacturer.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 110 ++++++++++++++++++++++++++++++++----------
>>  include/linux/mtd/spi-nor.h   |  12 +++--
>>  2 files changed, 92 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 8967319ea7da..8793cebbe5a9 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1180,17 +1180,61 @@ static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
>>  			dev_err(nor->dev, "Macronix quad-read not enabled\n");
>>  			return -EINVAL;
>>  		}
>> -		return status;
>> +		/* Check whether Macronix QPI mode is enabled. */
>> +		if (nor->read_proto != SNOR_PROTO_4_4_4)
>> +			nor->read_proto = SNOR_PROTO_1_1_4;
>> +		break;
>> +
>>  	case SNOR_MFR_MICRON:
>> -		return 0;
>> -	default:
>> +		/* Check whether Micron Quad mode is enabled. */
>> +		if (nor->read_proto != SNOR_PROTO_4_4_4)
>> +			nor->read_proto = SNOR_PROTO_1_1_4;
>> +		break;
>> +
>> +	case SNOR_MFR_SPANSION:
> 
> The following comment is not only related to your changes, but after
> looking at the spi_nor_scan() function and a few other functions in the
> core, I see a lot of vendor specific initialization.
> 
> Would it make sense to somehow set a default configuration in
> spi_nor_scan() and then overload this default config using a
> per-manufacturer ->init() method. Something like that.
> 
> struct spi_nor_manufacturer {
> 	int (*init)(struct spi_nor *nor, const struct flash_info *fi);
> }
> 
> static const struct spi_nor_manufacturer manufacturers[] = {
> 	[<manuf-id>] = {
> 		.init = <manuf-init-callback>
> 	},
> };
> 
> Of course you could add other methods if you think this differentiation
> is needed after the initialization step.
> 

It might be a good idea. I don't mind changing if needed. Brian, could you
please comment on this point?

>>  		status = spansion_quad_enable(nor);
>>  		if (status) {
>>  			dev_err(nor->dev, "Spansion quad-read not enabled\n");
>>  			return -EINVAL;
>>  		}
>> -		return status;
>> +		nor->read_proto = SNOR_PROTO_1_1_4;
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>>  	}
>> +
>> +	nor->read_opcode = SPINOR_OP_READ_1_1_4;
>> +	return 0;
>> +}
>> +
>> +static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
>> +{
>> +	switch (JEDEC_MFR(info)) {
>> +	case SNOR_MFR_MICRON:
>> +		/* Check whether Micron Dual mode is enabled. */
>> +		if (nor->read_proto != SNOR_PROTO_2_2_2)
>> +			nor->read_proto = SNOR_PROTO_1_1_2;
>> +		break;
>> +
>> +	default:
>> +		nor->read_proto = SNOR_PROTO_1_1_2;
>> +		break;
>> +	}
>> +
>> +	nor->read_opcode = SPINOR_OP_READ_1_1_2;
>> +	return 0;
>> +}
>> +
>> +static int set_single_mode(struct spi_nor *nor, const struct flash_info *info)
>> +{
>> +	switch (JEDEC_MFR(info)) {
>> +	default:
>> +		nor->read_proto = SNOR_PROTO_1_1_1;
>> +		break;
>> +	}
> 
> You can just put
> 
> 	nor->read_proto = SNOR_PROTO_1_1_1;
> 
> until you have a manufacturer specific case.
>

I did it on purpose: it is a transitional patch which was written only to ease
the split of the QSPI support by manufacturer. So the diff producing the next
patch of this series is a little bit more easy to review: it is just a new
case in a switch statement instead of replacing a 'if' statement by a 'switch'
one.
Also it removes some (not all) constraints on the order the manufacturer
specific patches should be applied, which makes it easier to remove some of
them from the series if needed: the rebase job will be simplified.
Ideally, all manufacturer patches should be totally independent.

[...]

Best regards,

Cyrille
