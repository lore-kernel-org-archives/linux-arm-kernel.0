From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 26 Nov 2009 17:27:31 +0900
Subject: [PATCH 5/5] SPI S3C64XX: SPI Controller driver for S3C64XX
In-Reply-To: <fa686aa40911252340j102f250dw586091c4de73a106@mail.gmail.com>
References: <1259218110-9905-1-git-send-email-jassi.brar@samsung.com>
	<fa686aa40911252340j102f250dw586091c4de73a106@mail.gmail.com>
Message-ID: <1b68c6790911260027oe29cccasa06c12e4832bcb8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 4:40 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Nov 25, 2009 at 11:48 PM, Jassi Brar <jassi.brar@samsung.com> wrote:
>> Added S3C64XX SPI controller driver.
>>
>> Each SPI controller has exactly one CS line and as such doesn't
>> provide for multi-cs. We implement a workaround to support
>> multi-cs by _not_ configuring the mux'ed CS pin for each SPI
>> controller. The CS mechanism is assumed to be fully machine
>> specific - the driver doesn't even assume some GPIO pin is used
>> to control the CS.
>>
>> The driver selects between DMA and POLLING mode depending upon
>> the xfer size - DMA mode for xfers bigger than FIFO size, POLLING
>> mode otherwise.
>>
>> The driver has been designed to be capable of running SoCs since
>> s3c64xx and till date, for that reason some of the register fields
>> have been passed via, SoC specific, platform data.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> ---
>> ?drivers/spi/Kconfig ? ? ? | ? ?7 +
>> ?drivers/spi/Makefile ? ? ?| ? ?1 +
>> ?drivers/spi/spi_s3c64xx.c | 1033 +++++++++++++++++++++++++++++++++++++++++++++
>> ?drivers/spi/spi_s3c64xx.h | ?189 +++++++++
>
> This is in the drivers/spi tree, but depends on the arch/arm stuff
> from the first 4 patches. ?Will need to decide which tree to merge
> this driver though.
>
> I won't review patches 1-4, but I've got a few comments for this
> patch. ?Mostly minor stuff. ?I don't seen anything on quick review
> that jumps out at me as bad.
>
>> +
>> +#include "spi_s3c64xx.h"
>
> First, why the separate header file? ?It doesn't look like there are
> any external users of the header file data. ?Please merge it into the
> top of the .c file.
there is no user other than spi_s3c64xx.c
okay, I will merge the header in code.

>> +
>> +static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
>> + ? ? ? .name = "s3c64xx-spi-dma",
>> +};
>> +
>> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>> +
>> +static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>> +{
>> + ? ? ? struct s3c64xx_spi_cntrlr_info *sci = sdd->cntrlr_info;
>> + ? ? ? unsigned long loops;
>> + ? ? ? u32 val;
>> +
>> + ? ? ? val = readl(sdd->regs + S3C64XX_SPI_CH_CFG);
>> + ? ? ? val |= S3C64XX_SPI_CH_SW_RST;
>> + ? ? ? val &= ~S3C64XX_SPI_CH_HS_EN;
>> + ? ? ? writel(val, sdd->regs + S3C64XX_SPI_CH_CFG);
>> +
>> + ? ? ? /* Flush TxFIFO*/
>> + ? ? ? loops = msecs_to_loops(1);
>> + ? ? ? do {
>> + ? ? ? ? ? ? ? val = readl(sdd->regs + S3C64XX_SPI_STATUS);
>> + ? ? ? } while (TX_FIFO_LVL(val, sci) && loops--);
>
> nasty spin. ?Can you sleep here instead? ?How much time do you project
> is needed to flush the fifo. ?It is a worthwhile question to ask on
> the other spin loops through this file.
Since this is called from between two xfers of a message,
sleeping isn't an option. Besides, the loops shudn't take more than a few
counts if everything is working fine.
FIFO needs to be flushed before setting the PACKET_CNT register.
The real flushing is done by the S3C64XX_SPI_CH_SW_RST bit, these
loops are just to 'confirm' flushing. So, ideally, it shudn't loop even second
counter. Practically, a few microseconds shud be enough waiting for correct
status. Btw, if it waits 1ms full, its pretty much the controller
malfunctioned and subsequent xfers will fail too(so we don't catch the
error here).
This function is called after every xfer so we can not sleep, even one slice,
 when the FIFO is flushed but the status register doesn't yet reflect that.

The same holds for the other loop.

>> +static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_device *spi)
>> +{
>> + ? ? ? struct s3c64xx_spi_csinfo *cs;
>> +
>> + ? ? ? if (sdd->tgl_spi != NULL) { /* If last device toggled after mssg */
>> + ? ? ? ? ? ? ? if (sdd->tgl_spi != spi) { /* if last mssg on diff device */
>> + ? ? ? ? ? ? ? ? ? ? ? /* Deselect the last toggled device */
>> + ? ? ? ? ? ? ? ? ? ? ? cs = sdd->tgl_spi->controller_data;
>> + ? ? ? ? ? ? ? ? ? ? ? if (sdd->tgl_spi->mode & SPI_CS_HIGH)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cs->set_level(0);
>> + ? ? ? ? ? ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cs->set_level(1);
>> + ? ? ? ? ? ? ? }
>> + ? ? ? ? ? ? ? sdd->tgl_spi = NULL;
>> + ? ? ? }
>> +
>> + ? ? ? cs = spi->controller_data;
>> + ? ? ? if (spi->mode & SPI_CS_HIGH)
>> + ? ? ? ? ? ? ? cs->set_level(1);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? cs->set_level(0);
>
> cs->set_level(spi->mode & SPI_CS_HIGH ? 1 : 0) perhaps?
yes, that wud be better.

>> +
>> + ? ? ? S3C64XX_SPI_ACT(sdd);
>> +}
> [...]
>> +static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_device *spi)
>> +{
>> + ? ? ? struct s3c64xx_spi_csinfo *cs;
>> +
>> + ? ? ? S3C64XX_SPI_DEACT(sdd);
>> +
>> + ? ? ? if (sdd->tgl_spi == spi)
>> + ? ? ? ? ? ? ? sdd->tgl_spi = NULL;
>> +
>> + ? ? ? cs = spi->controller_data;
>> + ? ? ? if (spi->mode & SPI_CS_HIGH)
>> + ? ? ? ? ? ? ? cs->set_level(0);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? cs->set_level(1);
>
> ditto here.
yes sure.
Thanks.
