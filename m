From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 6 Apr 2010 21:18:39 +0300
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
Message-ID: <20100406181839.GA2685@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 06, 2010 at 01:50:44PM +0100, Martin Guy wrote:
> On 4/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> > On Thu, Apr 01, 2010 at 01:15:20AM +0100, Martin Guy wrote:
> >  > I have another question: like the Cirrus driver, this takes 100% CPU
> >  > doing busy wait for the current transfer to complete.
> >
> >  I tried to find out whether the driver did something wrong to get
> >  into busylooping but couldn't find anything. In case of MMC/SD
> >  cards, through mmc_spi, transfer sizes are >= 512 bytes at a time
> >  and FIFO size is only 8 bytes (or words) so the CPU is expected to
> >  be pretty busy serving interrupts from the SSP.
> 
> Right. that explains it.
> The board I'm testing it with just has a single mmc/sd card on the ssp port.
> 
> The docs say "separate transmit and receive FIFO memory buffers, 16
> bits wide, 8 locations deep".
> Watching vmstat output with this driver, it gets 226 kB/sec reading
> /dev/mmcblk0 at 100% system cpu usage with 2354 interrupts and 2724
> context switches per second. I don't see how that relates to 8 bytes
> or 8 halfwords per interrupt; it suggests 100 bytes transferred per
> interrupt once you remove the 100/sec of clock tick irq.
> Writing instead gets 228kB/sec incurring 1916 (read: 1815) irqs and
> 934 context switches.
> Similarly, checking /proc/interrupts, writing 10MB to the raw device
> incurs 83221 ep93xx-spi interrupts: one per 125 bytes transferred. Is
> it maybe busy-waiting filling the output FIFO as fast as it is
> emptying?

If you check the sizes of the transfers for the MMC case it is something like:

[ 1796.080000] ep93xx-spi ep93xx-spi: setup: mode 0, cpsr 2, scr 0, dss 7
[ 1796.080000] ep93xx-spi ep93xx-spi: setup: cr0 0x7
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_process_transfer: transferring 512 bytes
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_interrupt: handling interrupt
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_read_write: tx=512, rx=512
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_process_transfer: transferring 2 bytes
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_interrupt: handling interrupt
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_read_write: tx=2, rx=2
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_process_transfer: transferring 1 bytes
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_interrupt: handling interrupt
[ 1796.080000] ep93xx-spi ep93xx-spi: ep93xx_spi_read_write: tx=1, rx=1

So size of the transfer varies, depending on what kind of message
is passed from mmc_spi to the driver. From the above, we can see
that ep93xx_spi_read_write() transfers 512 bytes before passing control
back to the calling interrupt handler.

I got the same results with polling enabled (this is with v3 which is not yet
posted).

> 
> Here's the code I'm talking about:
> 
> static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
> {
> ...
>         /*
>          * Write as long as TX FIFO is not full. After every write we check
>          * whether RX FIFO has any new data in it (and in that case we read what
>          * ever was in the RX FIFO).
>          */
>         while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_TNF) &&
>                 espi->tx < t->len) {
>                 ep93xx_do_write(espi, t);
> 
>                 if (ep93xx_spi_wait_busy(espi, SPI_TIMEOUT)) {
>                         msg->status = -ETIMEDOUT;
>                         return msg->status;
>                 }
> 
>                 while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
>                         espi->rx < t->len) {
>                         ep93xx_do_read(espi, t);
>                 }
>         }
> ...
> 
> and ep93xx_spi_wait_busy() reads a device register in an busy loop
> with a timeout:
> 
> static int ep93xx_spi_wait_busy(const struct ep93xx_spi *espi,
>                                 unsigned long msecs)
> {
>         unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
> 
>         while (time_before(jiffies, timeout)) {
>                 if ((ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_BSY) == 0)
>                         return 0;
>                 cpu_relax();
>         }
> 
>         return -ETIMEDOUT;
> }
> 
> The manual says that the BSY status bit means
> "SSP is currently transmitting and / or receiving a frame
> or the transmit FIFO is non-empty."

I think that when the controller is enabled (SSE is set), it is
transmitting/receiving once there is data (TX). It even enables the
SPI output clock only when TX data is put into TX FIFO (I checked
this with oscilloscope).

I added debug print to this function (ep93xx_spi_wait_busy()) and
it loops only once. If I don't wait while the bit is cleared, the
controller hangs.

> so this would make the code
> - output one byte/halfword
> - wait busily until the FIFO is empty of that one datum
> - maybe read one received word/byte
> - loop
> 
> This seems bizarre compared to what the hardware suggests:
> We only have one interrupt, which is triggered when
> - the TX buffer is less than half empty (ie there is room for 4 or more words)
> - the RX buffer is more than half full (ie there are four or more
> words to read from it)
> - RX overrun
> and there are status bits to tell us whether the TX and RX buffers are
> full, empty or half-full (the half-full bits triggering the
> interrupts).
> 
> My understanding ATM is that this version enables interrupts to start
> a transfer, immediately gets interrupted because the transmit buffer
> is less than half empty, and if it is supposed to be reading from the
> card, tramsmits a 0 byte/halfword for every byte/halfword it is
> supposed to be receiving.
> 
> If it's supposed to be sending, it pokes one byte/halfword into the
> write FIFO, waits for that to have been completely transmitted and for
> the FIFO to be empty, then checks if it should read anything, then
> writes another byte/halfword etc. and so on.
> 
> This seems completely at odds with what the hardware suggests, which would be
> WRITE: fill the TX buffer, then wait for half-empty IRQ.
> READ: react to half-full IRQ by emptying the RX buffer.
> with some hackery because if you receive a final 1, 2 or 3
> byte/halfwords, you don't get an RX interrupt.

Since SPI is full-duplex, I think that it is enough to just perform
another transfer once we get RX/TX interrupt. This also makes the
driver simpler (yet not the most efficient).

At least if you see my comments above, the driver seems to do the
right thing (for example it transmitted one spi_transfer at a time
without busy looping).

> I've tried removing the busy-wait from the read-write loop and the
> kernel hangs forever as soon as it looks at the SSP device. Worse, my
> serial console is dead so I can't be more expicit.

Yup, I noticed same thing. Once BSY bit is cleared, RX FIFO can be
read without hangs (or something like that).

> Am I missing something here, or is the current strategy forced by
> undocumented brokenness of the hardware?

I'm not sure.

For me, current strategy seems clear:
	1. Fetch next message
		1.1 Enable the SPI controller
		1.2 Assert chip-select
		1.3 Fetch next transfer
			1.3.1 Enable interrupts (if not polling)
			1.3.2 Perform the transfer
				write/read to/from the FIFO
			1.3.2 Disable interrupts (if not polling)
			... (for all spi_transfers)
		1.4 De-assert chip-select
		1.5 Disable the SPI controller
		1.6 call msg->complete
		...

It isn't the most optimized but my purpose was to get it working first. Since I only
have one ep9302 board and 2 SPI devices, it limits my testing a bit. Thanks to you
I've got very valuable input related to the driver :)

If you have time, I suggest that add some printk()s to the
ep93xx_spi_wait_busy() and see whether it busy loops in your device
(or does some other weird things).

> Lastly, what is the meaning of conditional operator(s) in
>         return t->bits_per_word ?: msg->spi->bits_per_word;
> It compiles, but it's the first time I've seen this construct in 27
> years of C programming. What is the "normal" syntax for this?

It is an GCC extension:

http://gcc.gnu.org/onlinedocs/gcc-4.4.3/gcc/Conditionals.html#Conditionals

I've been using it once I saw it somewhere in the kernel source.

Thanks again,
MW
