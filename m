From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jan 2012 09:00:21 +0000
Subject: omap-serial RX DMA polling?
In-Reply-To: <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
 <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
 <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
 <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
 <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com>
 <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com>
 <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com>
Message-ID: <20120124090021.GQ16726@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 12:58:57AM -0700, Paul Walmsley wrote:
> On Tue, 24 Jan 2012, Govindraj wrote:
> 
> > On Tue, Jan 24, 2012 at 1:18 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > > On Mon, 23 Jan 2012, Govindraj wrote:
> > >> On Mon, Jan 23, 2012 at 4:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > >
> > > The point is that if you want tty_insert_flip_string() to be called after
> > > every character is received, there seems little point in using RX DMA.
> > > It should be less efficient than PIO. ?And the current way that it is used
> > > is pointless from a power management point of view.
> > 
> > Yes, Its between power and performance, current way gives a better
> > response for most devices
> 
> That seems rather unlikely.  And I don't agree that there is a balance to 
> be struck in this case.  Compared to a correctly-working RX PIO path, the 
> RX DMA in the current driver is likely to be much worse in energy 
> consumption, and to be equal at best in receive latency.
> 
> In a correctly-working RX PIO path, the driver is going to receive an 
> interrupt the moment the data is ready to be transferred from the FIFO.  

That's hellishly inefficient.  In a correctly working RX PIO path with
FIFO, this is how most hardware is designed to work:

- The UART receives a character.  It places it into its FIFO, and it starts
  a timer based on the bit rate.
- If another character is being received, this will be received and placed
  into the FIFO.  The timer is restarted.  This continues until the FIFO
  hits the watermark level which raises the receive interrupt.
- If no character is received, the timer eventually expires and a
  receive timeout interrupt is raised instead.

Generally, what you want for transmit is to wait for the TX FIFO to
drain to maybe half full, and then reload it until it is completely
full.

For the RX FIFO, you want to set the watermark such that you get a
decent number of bytes in there before the receive interrupt is
raised, but not soo many that an overrun is likely.

One of the point of having FIFOs is that they batch up the transmit and
receive activity to make it more efficient at servicing the UART.

Setting the FIFO levels to one character virtually negates the point
of having FIFOs - there is no point setting the TX FIFO to raise an
interrupt when there's one character space left.  As has already been
reported, this just puts the interrupt rate up, and means you waste a
lot more CPU (or bus) time servicing the transmit path.

As for RX DMA vs RX PIO, that depends on the UART (I don't know how
OMAPs UARTs behave.)  To sanely use RX DMA, you need the UART to raise
the RX timeout interrupt after characters have been offloaded by the
RX DMA.  Lets saying that RX FIFO is 32 bytes deep, and it's set to
raise the RX DMA request at 16 bytes full.  If you program the DMA
controller to burst 16 bytes off the RX FIFO, you'll empty it and
it'll never raise the RX timeout interrupt.  So you'll need to know
how many characters you're expecting.

If on the other hand you burst 8 bytes off the RX FIFO, you'll leave
8 bytes in the FIFO.  If the UART works properly, it will raise an
RX timeout interrupt after N bit periods where the RX line is inactive.

What that means is that during a burst of RX activity, your DMA takes
the strain of receiving characters, and you process those characters
when either the RX buffer becomes full or when there's a pause in
reception.  This gives good efficiency during bursts while maintaining
interactivity - to the same levels as that expected by RX PIO using
the FIFO.
