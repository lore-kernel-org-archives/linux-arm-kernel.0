From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 12 Jan 2012 14:39:00 +0000
Subject: tty/serial: Need clarification on Support for 4+M Baudrate
In-Reply-To: <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A630D@EXDCVYMBSTM005.EQ1STM.local>
References: <20120111121901.GA4034@bnru05>
 <20120111123025.244a9cf5@pyramind.ukuu.org.uk>
 <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
 <20120112114913.21809bed@pyramind.ukuu.org.uk>
 <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A630D@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <20120112143900.27b92668@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Jan 2012 15:20:46 +0100
Rajanikanth H V <rajanikanth.hv@stericsson.com> wrote:

> Alan,
> 
> FYI: I am not using application, rather I have a Bluetooth driver invoking
> encode_baud_rate(...), please find log below.
> 
> I made sure that c_ispeed = c_ospeed = 4.05M Baud, however I see 
> tty_termios_encode_baud_rate(...) is normalizing to 4.0
> 
> 
> manual trace log below:
> ======================================================================================
> 
> 4.05M Arbitrary Baud Setting Sequence:
> [    9.664703] alloc_set_baud_rate_cmd Setting arbitrary baudrate using BOTHER baudrate:89 c_cflag:020000016262
> [    9.774658] XXXXXX_hci_uart_set_baudrate c_cflag:020000016262 baud:4050000

4050000 seems a bit odd - you want cflag&CBAUD == BOTHER so I'd expect
the low bits to end rather different things to 6262 ?

So something like

	struct ktermios new = *tty->termios;
	new.c_cflag &= ~(CBAUD|CIBAUD);
	new.c_cflag |= BOTHER;
	new.c_ispeed = 4050000;
	new.c_ospeed = 4050000;
	tty_set_termios(tty, &new);	/* Can sleep */

	/* Returned new will now hold actual values selected */

should do the trick providing the low level driver supports the rate.

Alan
