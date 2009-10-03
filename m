From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Sat, 3 Oct 2009 14:18:36 +0200
Subject: [RFC] AT91 cpufreq support
In-Reply-To: <4AC38735.9020703@eukrea.com>
References: <20090826193324.GB7084@pc-ras4041.res.insa>
	<4AC377CD.5020809@atmel.com> <4AC38735.9020703@eukrea.com>
Message-ID: <20091003121836.GA3102@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2009 18:28 +0200, Eric B?nard wrote :
> Nicolas Ferre wrote :
> >Anyway, as I see that there is a notifier for serial driver, I wonder if
> >we can keep serial console connexion during frequency switching ? I
> >assume that we will have to change the baud rate configuration of the
> >terminal emulator but do you have a clue to give us (I tried without
> >success) ?

> once called after the frequency change the notifier function in the
> serial driver updates uartclk and calls atmel_set_termios which
> should update the baudrate generator to the new master clock so you
> shouldn't need to change the baudrate.

Unless the clock is too low to reliably generate the baudrate you're asking for.
In particular in asynchronous mode and depending on the value of OVER in US_MR,
you might run into trouble trying to get a 115200 baudrate out of a 12MHz clock.
Limiting the lowest frequency to 24MHz might help there.

> To be clean, the serial port may need to be turned off before the
> frequency change in order to prevent garbage chars to be sent on the
> serial port as some USB serial adapters hang when receiving such
> garbage which may explain your problem.

That might happen, but I don't think it's the problem here - the at91sam9263-ek
doesn't use a usb-serial converter, does it ?

Cheers,
-- 
Albin Tonnerre
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091003/5a81b874/attachment.sig>
