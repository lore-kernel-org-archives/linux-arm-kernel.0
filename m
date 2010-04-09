From: martinwguy@gmail.com (Martin Guy)
Date: Fri, 9 Apr 2010 18:56:49 +0100
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
	<20100406181839.GA2685@gw.healthdatacare.com>
	<x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
Message-ID: <l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again

I've looked at this again, and v2 does send every complete block (up
to 512 bytes) before it returns from an interrupt. If you factor out
all the conditions that always have constant values, and those that
can never happen, from the central loop:

        /*
         * Write as long as TX FIFO is not full. After every write we check
         * whether RX FIFO has any new data in it (and in that case we read what
         * ever was in the RX FIFO).
         */
        while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_TNF) &&
                espi->tx < t->len) {
                ep93xx_do_write(espi, t);

                if (ep93xx_spi_wait_busy(espi, SPI_TIMEOUT)) {
                        msg->status = -ETIMEDOUT;
                        return msg->status;
                }

                while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
                        espi->rx < t->len) {
                        ep93xx_do_read(espi, t);
                }
        }

you end up with:

        while (espi->tx < t->len) {
                ep93xx_do_write(espi, t);

                while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_BSY);

                ep93xx_do_read(espi, t);
        }

This makes each interrupt routine take about 2ms to complete. I don't
know if that's unacceptably long or not.

I've coded up a version that works differently, by filling the TX FIFO
and returning from the IRQ routine - it then get interrupted again
when the TX FIFO is half empty (and the RX FIFO is half full), at
which point it empties and fills them
and waits for another interrupt.
The end of the transfer has to be handled specially because the
interrupt is held high as long as the TX FIFO is half empty or less,
so we have to busy-wait while the final four words are transmitted and
received, concluding the transfer.

The result is an increase in MMC card read or write speed from 232kB/s
to 315kB/s and a decrease in CPU usage from 100% to 55-60%, tested
with plain 1GB SD card.
A 2GB MLC card instead gets 323kB/sec in read and 319kB/sec in write (!).

SDHC cards don't work at all - they are rejected by the MMC-SPI driver
(eror -38, ENOSYS: Function not implemented), the same as happens with
the old CIrrus driver.

I've only changed the ep93xx_spi_read_write() function in your v2
interrupting driver: the new version is below. Would you see if it
works with your other SPI hardware?

I've tried also to handle transfers with word size > 8 bits but have
not been able to test these.

Cheers

    M

/**
 * ep93xx_spi_read_write() - perform next RX/TX transfer
 * @espi: ep93xx SPI controller struct
 *
 * This function transfers next bytes (or words) to/from RX/TX FIFOs. If called
 * several times, the whole transfer will be completed. Returns %0 when current
 * transfer was not yet completed otherwise length of the transfer (>%0). In
 * case of error negative errno is returned.
 *
 * Although this function is currently only used by interrupt handler it is
 * possible that in future we support polling transfers as well: hence calling
 * context can be thread or atomic.
 *
 * Both RX and TX sides have an 8-item-deep FIFO, and interrupts are caused by
 * - the transmit FIFO being half empty or less (ie room for four more words)
 * - the receive FIFO being half full or more (ie four or more words in it)
 * - receive overrun
 * This driver works by queuing the SPI transfer list and enabling interrupts
 * in the device. This immediately causes a first interrupt because the TX FIFO
 * is empty. We fill the TX FIFO and return. We are then interrupted again when
 * four words have been transmitted (and received), so we empty the RX and fill
 * the TX FIFOs until there are less than 4 words remaining to be transmitted.
 * At that point interrupts become useless because the TX IRQ remains set while
 * the last 4 words are being transmitted, and the RX IRQ won't trigger unless
 * there are 4 or more words in the RX FIFO. So at the end of the transfer we
 * simply busy-wait for the last words to be transmitted and received.
 *
 * It's tempting to use the TNF (Transmit buffer not full) status bit to know
 * when we have filled the TX FIFO but that makes for RX overruns because
 * it queues 8 words in the TC FIFO plus the word already being transmitted
 * for a total of 9, which is enough to overflow the RX FIFO.
 */
static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
{
	struct spi_message *msg;
	struct spi_transfer *t;
	unsigned long flags;
	unsigned n;	/* Number of bytes to send to the TX FIFO */

	spin_lock_irqsave(&espi->lock, flags);
	msg = espi->current_msg;
	spin_unlock_irqrestore(&espi->lock, flags);

	t = msg->state;

	/* Read all received data */
	while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)
		ep93xx_do_read(espi, t);

	n = t->len - espi->tx;	/* Total number of bytes waiting to be
				 * sent to the TX FIFO for this transfer */

	switch (n) {
	default:
		/* This is the start or middle of a multi-word transfer:
		 * fill the TX FIFO as much as it is safe to do without
		 * risking RX overruns. To do this we ensure that the RX FIFO
		 * can end up with no more than 8 words in it by calculating
		 * how many words are in the RX/TX FIFOs and the TX/RX shift
		 * registers from the difference between the number of bytes
		 * we have already sent and received.
		 */
		{ unsigned words_in_flight =
			(espi->tx - espi->rx) / (bits_per_word(espi) > 8 ? 2 : 1);
		  unsigned space = 8 - words_in_flight;
		  if (n > space) n = space;
		}

		/* space and n are always >= 1 */
		do {
			ep93xx_do_write(espi, t);
		} while (--n > 0);
		break;

	case 1:
		/* Single-word transfers are common and not worth returning and
		 * causing another interrupt for. This also handles a single
		 * final word of a longer tranfer, which again is not worth
		 * causing another interrupt for.
		 * Just transmit it and wait for the reply.
		 */
		ep93xx_do_write(espi, t);
		/* Fall through to wait for and read the received word */
	case 0:
		/* All of this transfer's data has been sent to the TX FIFO.
		 * The TX and RX IRQs are now useless to tell us when the last
		 * few words have finished, so simply wait for the last 0-4
		 * words to be transmitted and for the corresponding RX data
		 * to come back in.
		 * We empty the RX FIFO while we are waiting, which is faster
		 * than first waiting and then emptying.
		 */
		{
			unsigned ssp_status;

			do {
				ssp_status = ep93xx_spi_read_u8(espi, SSPSR);
				if (ssp_status & SSPSR_RNE)
					ep93xx_do_read(espi, t);
			} while (ssp_status & SSPSR_BSY);
		}

		/* Finish emptying the RX FIFO. Even though we emptied it while
		 * waiting on BUSY, there can still be several (up to 3) words
		 * still waiting in it.  Not sure why!
		 */
		while (ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)
			ep93xx_do_read(espi, t);
		break;
	}

	/* is transfer finished? */
	if (espi->rx == t->len) {
		msg->actual_length += t->len;
		return t->len;
	}

	return 0;
}
