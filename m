From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Feb 2014 15:54:03 +0100
Subject: Rogue low pulse on TXD created by amba-pl011.c during startup
Message-ID: <20140228155403.2bed6fe5@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following portion of the code in drivers/tty/serial/amba_pl011.c
produces a low pulse (actually a NUL character with 5 bits and maximum
baud rate) on the serial output each time the startup function is
called.
 1516)	static int pl011_startup(struct uart_port *port)
[...]
 1537)	/*
 1538)	 * Provoke TX FIFO interrupt into asserting.
 1539)	 */
 1540)	cr = UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_LBE;
 1541)	writew(cr, uap->port.membase + UART011_CR);
 1542)	writew(0, uap->port.membase + UART011_FBRD);
 1543)	writew(1, uap->port.membase + UART011_IBRD);
 1544)	writew(0, uap->port.membase + uap->lcrh_rx);
 1545)	if (uap->lcrh_tx != uap->lcrh_rx) {
 1546)		int i;
 1547)		/*
 1548)		 * Wait 10 PCLKs before writing LCRH_TX register,
 1549)		 * to get this delay write read only register 10 times
 1550)		 */
 1551)          for (i = 0; i < 10; ++i)
 1552)			writew(0xff, uap->port.membase + UART011_MIS);
 1553)		writew(0, uap->port.membase + uap->lcrh_tx);
 1554)	}
 1555)	writew(0, uap->port.membase + UART01x_DR);
** This write causes the NUL character to be sent.
 1556)	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
 1557)		barrier();

Can anyone enlighten me what this is meant to achieve?
The git history doesn't provide any clue, since this code was already
in the initial commit.
I also found no clue in the i.MX28 Reference Manual and the ARM
PrimeCell UART (PL011) ? Reference Manual (DDI0183.pdf).

The code does not work without this block of code (on an i.MX28).

Does anybody have an idea how to prevent the rogue
pulse from being sent on the TX line?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
