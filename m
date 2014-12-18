From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Dec 2014 10:12:33 +0100
Subject: [PATCH 1/2] tty: serial: 8250_mtk: Add earlycon
In-Reply-To: <CABuKBe+dki5ab8PexMhq36AJFCBk_dBifV86F8FKsF_es1cmJA@mail.gmail.com>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
 <1418891601-53769-2-git-send-email-eddie.huang@mediatek.com>
 <CABuKBe+dki5ab8PexMhq36AJFCBk_dBifV86F8FKsF_es1cmJA@mail.gmail.com>
Message-ID: <1822504.xkcBG8sz41@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 December 2014 09:48:31 Matthias Brugger wrote:
> > +static void __init mtk8250_serial_putc(struct uart_port *port, int c)
> > +{
> > +       while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) !=
> > +               BOTH_EMPTY)
> > +               ;
> 
> Please delete newline before the semicolon.
> 

No, that newline is best kept in there for clarity. An even better way
to write this would be using cpu_relax():

	while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) != BOTH_EMPTY)
		cpu_relax();

which the kernel convention for doing busy-loops.

	Arnd
