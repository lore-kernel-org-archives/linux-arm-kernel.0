From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 17:35:57 +0100
Subject: [PATCH 2/2] pl011: factor our FIFO to TTY code
In-Reply-To: <CAOZdJXVVgd=YTn33VAB2GbfuPkGGapr0C=dN7J+KhdcJuOpKuA@mail.gmail.com>
References: <1298146644-31007-1-git-send-email-linus.walleij@stericsson.com>
 <CAOZdJXVVgd=YTn33VAB2GbfuPkGGapr0C=dN7J+KhdcJuOpKuA@mail.gmail.com>
Message-ID: <20151007163557.GN21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 11:13:33AM -0500, Timur Tabi wrote:
> On Sat, Feb 19, 2011 at 2:17 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> > +static int pl011_fifo_to_tty(struct uart_amba_port *uap)
> > +{
> > +       u16 status, ch;
> > +       unsigned int flag, max_count = 256;
> > +       int fifotaken = 0;
> > +
> > +       while (max_count--) {
> > +               status = readw(uap->port.membase + UART01x_FR);
> > +               if (status & UART01x_FR_RXFE)
> > +                       break;
> > +
> > +               /* Take chars from the FIFO and update status */
> > +               ch = readw(uap->port.membase + UART01x_DR) |
> > +                       UART_DUMMY_DR_RX;
> 
> I know this patch is four years old, but I just noticed a bug, and I
> can't figure out how no else noticed it.  Or maybe I'm imagining
> things.
> 
> #define UART_DUMMY_DR_RX        (1 << 16)
> 
> UART_DUMMY_DR_RX cannot fit into 'ch', because ch is a 16-bit integer.
> So the UART_DUMMY_DR_RX is lost.
> 
> What does UART_DUMMY_DR_RX do, anyway?  It's set in two places, but no
> one ever checks for it.

ch is supposed to cover that bit.  It is checked - inside uart_insert_char()
by comparing the status (in the higer order bits in ch) with
port->ignore_status_mask to see whether the character should be ignored.

When CREAD is clear, this should cause input to be discarded - except
in this case, because the bit is cropped by the u16, it'll always be
accepted.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
