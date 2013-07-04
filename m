From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 20:12:16 +0100
Subject: SPI: DUAL/QUAD support
In-Reply-To: <20130704180656.GA1974@sig21.net>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704143645.GA27646@sirena.org.uk>
 <20130704180656.GA1974@sig21.net>
Message-ID: <20130704191216.GK27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 08:06:56PM +0200, Johannes Stezenbach wrote:
> On Thu, Jul 04, 2013 at 03:36:45PM +0100, Mark Brown wrote:

> > OK, so all this is about is devices that have extra data lines.  Please
> > don't invent terms like "DUAL" and "QUAD", it makes things much less
> > clear.  Just describe it as support for multiple data lines.

> Flash data sheets use the terms Dual and Quad I/O Mode,
> e.g. for MX25L25635E
> http://www.macronix.com/QuickPlace/hq/PageLibrary4825740B00298A3B.nsf/h_Index/6F878CF760C559BD482576E00022E6CC/?OpenDocument&EPN=MX25L25635E

OK, but this is not a flash specific feature but rather something at the
SPI level and even with flash are they typically written in all caps?
This really needs to be described at the SPI level for the SPI subsystem,
not in terms of the specific application.

> > Calling this "bandwidth" is really unclear - I would expect a bandwidth
> > to be expressed in bits per second or similar.  This would be much
> > clearer if it was just the number of data signals.

> "bitwidth" != "bandwidth", but maybe the name could be improved,
> how about xfer_width?  The mmc susbsysem has something similar
> and calls it bus_width.

Bus width is better but I think half the issue here is the use of
"width" and the fact that this isn't being done separately for RX and
TX, it's really not clear what's being talked about.  xfer_width sounds
to me like it's something to do with the word size so I don't think
that's a good idea.  n_mosi and n_miso perhaps?

> > > +       t[0].rx_buf = buf;
> > > +       t[0].len = len;
> > > +       t[0].bitwidth = spi->rx_bitwidth/spi->tx_bitwidth;
> > > +       spi_message_add_tail(&t[0], &m);

> > This interface won't work for bidirectional transfers with asymmetric
> > numbers of data lines - we need separate fields for rx and rx.

> I'm not aware that bidirectional transfers are supported in
> dual or quad IO mode.  I think only flash supports it and

As far as I can tell this is just because you guys are only thinking in
terms of flash chips here - I can't believe that only flash manufacturers
came up with the idea of adding extra data signals to SPI, it's not that
big a leap (and MMC obviously has some overlap here...).  If nothing
else I'd expect some FPGAs would use this, and I wouldn't be surprised
if there were DSPs that could use this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/6b0c5352/attachment.sig>
