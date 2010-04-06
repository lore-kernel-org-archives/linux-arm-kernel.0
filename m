From: martinwguy@gmail.com (Martin Guy)
Date: Tue, 6 Apr 2010 13:50:44 +0100
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100406054418.GA27465@gw.healthdatacare.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
Message-ID: <s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> On Thu, Apr 01, 2010 at 01:15:20AM +0100, Martin Guy wrote:
>  > I have another question: like the Cirrus driver, this takes 100% CPU
>  > doing busy wait for the current transfer to complete.
>
>  I tried to find out whether the driver did something wrong to get
>  into busylooping but couldn't find anything. In case of MMC/SD
>  cards, through mmc_spi, transfer sizes are >= 512 bytes at a time
>  and FIFO size is only 8 bytes (or words) so the CPU is expected to
>  be pretty busy serving interrupts from the SSP.

Right. that explains it.
The board I'm testing it with just has a single mmc/sd card on the ssp port.

The docs say "separate transmit and receive FIFO memory buffers, 16
bits wide, 8 locations deep".
Watching vmstat output with this driver, it gets 226 kB/sec reading
/dev/mmcblk0 at 100% system cpu usage with 2354 interrupts and 2724
context switches per second. I don't see how that relates to 8 bytes
or 8 halfwords per interrupt; it suggests 100 bytes transferred per
interrupt once you remove the 100/sec of clock tick irq.
Writing instead gets 228kB/sec incurring 1916 (read: 1815) irqs and
934 context switches.
Similarly, checking /proc/interrupts, writing 10MB to the raw device
incurs 83221 ep93xx-spi interrupts: one per 125 bytes transferred. Is
it maybe busy-waiting filling the output FIFO as fast as it is
emptying?

Here's the code I'm talking about:

static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
{
...
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
...

and ep93xx_spi_wait_busy() reads a device register in an busy loop
with a timeout:

static int ep93xx_spi_wait_busy(const struct ep93xx_spi *espi,
                                unsigned long msecs)
{
        unsigned long timeout = jiffies + msecs_to_jiffies(msecs);

        while (time_before(jiffies, timeout)) {
                if ((ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_BSY) == 0)
                        return 0;
                cpu_relax();
        }

        return -ETIMEDOUT;
}

The manual says that the BSY status bit means
"SSP is currently transmitting and / or receiving a frame
or the transmit FIFO is non-empty."
so this would make the code
- output one byte/halfword
- wait busily until the FIFO is empty of that one datum
- maybe read one received word/byte
- loop

This seems bizarre compared to what the hardware suggests:
We only have one interrupt, which is triggered when
- the TX buffer is less than half empty (ie there is room for 4 or more words)
- the RX buffer is more than half full (ie there are four or more
words to read from it)
- RX overrun
and there are status bits to tell us whether the TX and RX buffers are
full, empty or half-full (the half-full bits triggering the
interrupts).

My understanding ATM is that this version enables interrupts to start
a transfer, immediately gets interrupted because the transmit buffer
is less than half empty, and if it is supposed to be reading from the
card, tramsmits a 0 byte/halfword for every byte/halfword it is
supposed to be receiving.

If it's supposed to be sending, it pokes one byte/halfword into the
write FIFO, waits for that to have been completely transmitted and for
the FIFO to be empty, then checks if it should read anything, then
writes another byte/halfword etc. and so on.

This seems completely at odds with what the hardware suggests, which would be
WRITE: fill the TX buffer, then wait for half-empty IRQ.
READ: react to half-full IRQ by emptying the RX buffer.
with some hackery because if you receive a final 1, 2 or 3
byte/halfwords, you don't get an RX interrupt.

I've tried removing the busy-wait from the read-write loop and the
kernel hangs forever as soon as it looks at the SSP device. Worse, my
serial console is dead so I can't be more expicit.

Am I missing something here, or is the current strategy forced by
undocumented brokenness of the hardware?

Lastly, what is the meaning of conditional operator(s) in
        return t->bits_per_word ?: msg->spi->bits_per_word;
It compiles, but it's the first time I've seen this construct in 27
years of C programming. What is the "normal" syntax for this?

    M
