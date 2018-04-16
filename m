From: stefan@agner.ch (Stefan Agner)
Date: Mon, 16 Apr 2018 11:14:32 +0200
Subject: serial: imx: half-duplex RS485 operation with RTS active low
Message-ID: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Using upstream I noticed that RS-485 does not work in the default
configuration for our platforms (Toradex Apalis/Colibri). Closer
debugging shows that it is related to "serial: imx: default to half
duplex rs485".

We use the i.MX UART in DTE mode and control the RS-485 transceiver
using the RTS signal in low-active mode.

	uart-has-rtscts;
	fsl,dte-mode;
	linux,rs485-enabled-at-boot-time;
	rs485-rts-active-low;

Using this setting leads to the RTS signal not getting asserted (the
oscilloscope only shows a very short fluke before the start bit is
sent).

However, using

	uart-has-rtscts;
	fsl,dte-mode;
	linux,rs485-enabled-at-boot-time;
	rs485-rts-active-low;
	rs485-rx-during-tx;

Asserts the RTS signal low active just fine...

Is this a known problem? Any idea where that could come from? It looks
as if the receiver part is actually enabling RTS...?

Also, isn't enabling RX even in half-duplex mode quite common in order
to detect collisions?

--
Stefan
