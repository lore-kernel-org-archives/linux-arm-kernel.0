From: martinwguy@gmail.com (Martin Guy)
Date: Mon, 19 Apr 2010 20:16:51 +0100
Subject: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
Message-ID: <y2q56d259a01004191216o48763eafy6401779ddae0f1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/10, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >> > +       /* read all received data */
>  >> > +       while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
>  >> > +               espi->rx < t->len) {
>  >> > +               ep93xx_do_read(espi, t);
>  >> > +               espi->fifo_level--;
>  >> > +       }
>  >>
>  >> Another busywait loop.  Could end up burning an awful lot of cycles
>  >> here.  A state machine might be more suitable for this driver so that
>  >> processing can be punted to deferred work when the FIFO gets either
>  >> empty or full.
>  >
>  > FIFO size is max 8 frames so there should be 8 iterations when the
>  > FIFO is full. So is it enought to to add check that we only read
>  > max 8 frames from the FIFO?
>
>  If you do it right, FIFO size shouldn't matter.  The driver should
>  easily be able to read however many are available and defer until more
>  is ready.

Sorry, I completely missed the point at the end of the last post.

This is not a busywait loop. It takes bytes out of the RX FIFO until
it is empty, which is all useful work. There is also no way to tell
just from our internal variables how many bytes are in the RX FIFO as
far as I know, so the only way is to check the Receiver-Not-Empty
status bit (which is what this code does).

However, the
>  >> > +               espi->rx < t->len) {
is redundant, since it will always be true when the first condition is
true, though the compiler cannot see optimise it out.

If you're afraid that a caller might pass the driver a receive buffer
shorter than than the transmit buffer, it would be better to check
that once when the transfer is requested, not once per byte received!

The same goes for the other checks for conditions that can only ever
be true or only ever false that I mentioned in my remarks on earlier
patches, and other optimizations. We are at the byte-per-byte level of
a device driver for a slow CPU, where efficiency is at a premium.

     M
