From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Fri, 22 May 2015 20:43:54 +0530
Subject: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC GQSPI
 controller
In-Reply-To: <20150522115854.GG21391@sirena.org.uk>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150522115854.GG21391@sirena.org.uk>
Message-ID: <CAFcVECJRqebzAjU+rfAtUQFG=7-KoE1GiXet5XJB-4D3i0or6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, May 22, 2015 at 5:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 20, 2015 at 12:57:51PM +0530, Ranjit Waghmode wrote:
>
> This looks pretty good overall but there are a few issues below from a
> first read through.
>
>> +static void zynqmp_gqspi_selectflash(struct zynqmp_qspi *instanceptr,
>> +                                  u8 flashcs, u8 flashbus)
>
> Is this a SPI controller or a flash controller?  It looks like it is
> actually a SPI controller but the above is a bit worrying.

It is a Quad SPI controller. SPI NOR flash devices are the most common
interface. But we hope to keep this driver generic.
The above function name is probably misleading; it can be renamed.

>
>> +{
>> +     /*
>> +      * Bus and CS lines selected here will be updated in the instance and
>> +      * used for subsequent GENFIFO entries during transfer.
>> +      */
>> +     /* Choose slave select line */
>
> Coding style - at least a blank linne between the two comment blocks.
>
>> +     switch (flashcs) {
>> +     case GQSPI_SELECT_FLASH_CS_BOTH:
>> +             instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
>> +                 GQSPI_GENFIFO_CS_UPPER;
>> +             break;
>> +     case GQSPI_SELECT_FLASH_CS_UPPER:
>> +             instanceptr->genfifocs = GQSPI_GENFIFO_CS_UPPER;
>> +             break;
>> +     case GQSPI_SELECT_FLASH_CS_LOWER:
>> +     default:
>> +             instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER;
>> +     }
>
> Why is there a default case here?  That's going to men we try to handle
> any random chip select that gets passed in as pointing to this lower
> device which doesn't seem right.  The fact that this is trying to handle
> mirroring of the chip select to two devices is also raising alarm bells
> here...

This SPI controller has two CS lines and two data bus.
Two devices can be connected to these and either the upper or the
lower or both (Explained below) can be selected.

When two flash devices are used, one of the HW configurations in
which they can be connected is called "parallel" mode where they
share the same CS but use separate 4 bit data bus each
(essentially making it 8 bit bus width).
Another configuration is "stacked" mode where the
same 4 bit data bus is shared and lower or upper CS lines are
used to select the flash.

Nevertheless, we will deal with acceptable ways to add such features
incrementally or maybe send an RFC separately.
For the current patch (which is intended to support a single device),
the above selection of "both" CS wont be necessary.
@Ranjit, please remove it.

<snip>
>> +static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
>> +{
>
>> +     if (is_high) {
>> +             /* Manually start the generic FIFO command */
>> +             zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
>> +                             zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
>> +                             GQSPI_CFG_START_GEN_FIFO_MASK);
>
> No, this is broken - setting the chip select should set the chip select,
> it shouldn't have any impact on transfers.  Transfers should be started
> in the transfer operations.
>

This is the only way to assert the CS. It doesn't start transferring any data.
The controller has a Generic FIFO. All operations to be performed on the
bus have to be given in the form of any entry in this FIFO.
The controller fetches each entry from the FIFO and performs the operations.
And that includes asserting and de-asserting CS. There is no dedicated
register bit to assert or de-assert the CS.

The GEN FIFO entry has fields such as:
- TX or RX
- CS - lower/upper
- data bus - lower/upper
- bytecount
- bus width - x1 or x2 or x4
etc.

@Ranjit It might be useful to describe the GENFIFO format in
the driver at some appropriate place.

Regards,
Harini
