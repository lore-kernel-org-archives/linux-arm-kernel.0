From: js@sig21.net (Johannes Stezenbach)
Date: Thu, 4 Jul 2013 20:06:56 +0200
Subject: SPI: DUAL/QUAD support
In-Reply-To: <20130704143645.GA27646@sirena.org.uk>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704143645.GA27646@sirena.org.uk>
Message-ID: <20130704180656.GA1974@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 03:36:45PM +0100, Mark Brown wrote:
> On Thu, Jul 04, 2013 at 07:36:48PM +0800, yuhang wang wrote:
> > +Description
> > +----------------------
> > +DUAL/QUAD means spi can transfer in 2bits/4bits at the same time.
> > +These spi controllers provide 8 data lines(4-tx and 4-rx). User can
> > +choose tranfer mode(SINGLE/DUAL/QUAD) by setting the certain register.
> > +Though SPI is a serial interface, some spi controllers can support
> > +transmitting and receiving in DUAL and QUAD modes aimed to improve
> > +the performance. Also as spi slave lots of flashes do support this attribute,
> > +such as serial-norflash in spansion company.
> 
> OK, so all this is about is devices that have extra data lines.  Please
> don't invent terms like "DUAL" and "QUAD", it makes things much less
> clear.  Just describe it as support for multiple data lines.

Flash data sheets use the terms Dual and Quad I/O Mode,
e.g. for MX25L25635E
http://www.macronix.com/QuickPlace/hq/PageLibrary4825740B00298A3B.nsf/h_Index/6F878CF760C559BD482576E00022E6CC/?OpenDocument&EPN=MX25L25635E

> > +struct spi_transfer {
> > ++       u8     bitwidth;
> > ++#define        SPI_BITWIDTH_SINGLE     0x01; /* 1bit transfer */
> > ++#define        SPI_BITWIDTH_DUAL       0x02; /* 2bits transfer */
> > ++#define        SPI_BITWIDTH_QUAD       0x03; /* 4bits transfer */
> 
> Calling this "bandwidth" is really unclear - I would expect a bandwidth
> to be expressed in bits per second or similar.  This would be much
> clearer if it was just the number of data signals.

"bitwidth" != "bandwidth", but maybe the name could be improved,
how about xfer_width?  The mmc susbsysem has something similar
and calls it bus_width.

> > +       t[0].rx_buf = buf;
> > +       t[0].len = len;
> > +       t[0].bitwidth = spi->rx_bitwidth/spi->tx_bitwidth;
> > +       spi_message_add_tail(&t[0], &m);
> 
> This interface won't work for bidirectional transfers with asymmetric
> numbers of data lines - we need separate fields for rx and rx.

I'm not aware that bidirectional transfers are supported in
dual or quad IO mode.  I think only flash supports it and
uses all available IO lines as either input (flash write
command) or output (flash read command).  I.e. for MX25L25635E flash
it means at least the command, but usually also the address,
are transferred in single IO mode, only then do the flash
and controller switch to parallel IO for the data transfer.


Johannes
