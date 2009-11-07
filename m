From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 7 Nov 2009 12:33:03 +0100
Subject: [PATCH] [ARM] serial/pxa: work around Errata #75
In-Reply-To: <771cded00911070145k4a44ac03ne4359a1fe34c5339@mail.gmail.com>
References: <1257245235-14783-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091106204046.GA8952@pengutronix.de>
	<771cded00911070145k4a44ac03ne4359a1fe34c5339@mail.gmail.com>
Message-ID: <20091107113303.GA6961@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > ? ? ? ? ? ? ? ?up->mcr &= ~UART_MCR_AFE;
> >
> > - ? ? ? serial_out(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
> > + ? ? ? serial_out(up, UART_LCR, cval | UART_LCR_DLAB); /* set DLAB */
> > ? ? ? ?serial_out(up, UART_DLL, quot & 0xff); ? ? ? ? ?/* LS of divisor */
> > +
> > + ? ? ? /*
> > + ? ? ? ?* work around Errata #75 according to Intel(R) PXA27x Processor Family
> > + ? ? ? ?* Specification Update (Nov 2005)
> > + ? ? ? ?*/
> > + ? ? ? dll = serial_in(up, UART_DLL);
> > + ? ? ? WARN_ON(dll != (quot & 0xff));
> > +
> Would you mind to use a loop at here? In order to make sure register
> is updated as expected.
Even if the thing described in the Errata happens UART_DLL is updated.
It only speaks about the 2nd write.  So actually only

+	(void)serial_in(up, UART_DLL);

alone would help, too.

So no, I don't think a loop is better here.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
