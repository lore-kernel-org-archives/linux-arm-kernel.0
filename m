From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sat, 10 Apr 2010 18:54:43 +0300
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
	<20100406181839.GA2685@gw.healthdatacare.com>
	<x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
	<l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
Message-ID: <20100410155443.GG2685@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 09, 2010 at 06:56:49PM +0100, Martin Guy wrote:
> 
> you end up with:
> 
>         while (espi->tx < t->len) {
>                 ep93xx_do_write(espi, t);
> 
>                 while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_BSY);
> 
>                 ep93xx_do_read(espi, t);
>         }
> 
> This makes each interrupt routine take about 2ms to complete. I don't
> know if that's unacceptably long or not.

Yeah. It's probably bad thing to spend that much time in interrupt
handler.

> I've coded up a version that works differently, by filling the TX FIFO
> and returning from the IRQ routine - it then get interrupted again
> when the TX FIFO is half empty (and the RX FIFO is half full), at
> which point it empties and fills them
> and waits for another interrupt.
> The end of the transfer has to be handled specially because the
> interrupt is held high as long as the TX FIFO is half empty or less,
> so we have to busy-wait while the final four words are transmitted and
> received, concluding the transfer.
> 
> The result is an increase in MMC card read or write speed from 232kB/s
> to 315kB/s and a decrease in CPU usage from 100% to 55-60%, tested
> with plain 1GB SD card.
> A 2GB MLC card instead gets 323kB/sec in read and 319kB/sec in write (!).
> 
> SDHC cards don't work at all - they are rejected by the MMC-SPI driver
> (eror -38, ENOSYS: Function not implemented), the same as happens with
> the old CIrrus driver.
> 
> I've only changed the ep93xx_spi_read_write() function in your v2
> interrupting driver: the new version is below. Would you see if it
> works with your other SPI hardware?

I tested your version with few SD cards (one of them is SDHC) and
works without any problems (and performance is better). Also tested
with SPI EEPROM through at25 driver and it works well.

However, I would really like to have this code to be simpler and
to be suitable for polling as well. I wrote myself version that is
based on yours and also borrowed this fifo_level thingy from
amba-pl022 driver. I tested it with the same devices and performance
seems to be in par with your version.

Can you try following with your devices?

struct ep93xx_spi {
	...
	size_t	fifo_level;
};

static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
{
        struct spi_message *msg;
        struct spi_transfer *t;
        unsigned long flags;

        spin_lock_irqsave(&espi->lock, flags);
        msg = espi->current_msg;
        spin_unlock_irqrestore(&espi->lock, flags);

        t = msg->state;

        if (espi->tx == 0 && espi->rx == 0)
                espi->fifo_level = 0;

        while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
                espi->rx < t->len) {
                ep93xx_do_read(espi, t);
                espi->fifo_level--;
        }

        while (espi->fifo_level < 8 && espi->tx < t->len) {
                ep93xx_do_write(espi, t);
                espi->fifo_level++;
        }

        /* is transfer finished? */
        if (espi->tx == t->len && espi->rx == t->len) {
                msg->actual_length += t->len;
                return t->len;
        }

        return 0;
}

Thanks,
MW
