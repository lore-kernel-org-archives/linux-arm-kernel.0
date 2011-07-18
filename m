From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2011 11:03:23 +0100
Subject: seria port communication on linux with rts signal
In-Reply-To: <loom.20110718T113615-870@post.gmane.org>
References: <loom.20110718T113615-870@post.gmane.org>
Message-ID: <20110718100323.GR23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 09:44:13AM +0000, Ravi wrote:
> Dear All,
> 
> I want to interface a printer on RS232 port of my arm board.the printer has
> RX,TX and CTS signals from printer. This pin will turn to logic low indicating
> printer is ready to receive data. If Printer is not ready to print then the
> signal will change to Logic High.

Your description is confusing.

RS232 is not logic levels.  RS232 is positive and negative voltage
signalling.  A logic 0 coming out of the serial port is converted to
a positive voltage, a logic 1 is converted to a negative voltage.

The RX and TX logic signals into/outof the RS232 driver are positive
logic (a '1' bit is logic 1) and on the RS232 connector that's a
negative voltage.

The CTS logic signal will be inverted (so /CTS) and its active state
will be logic 0, meaning 'clear to send'.  On the RS232 connector,
this will be a positive voltage.

Assuming that the above is what you meant, this is standard signalling,
and your UART should already be able to cope with this in hard flow
control mode - it will send characters when /CTS is logic 0, and hold
off sending characters (which can still be queued in the kernel) when
/CTS is logic 1.

If you don't know how to control the flow control method, you need to
read up on stty, termios, and specifically the CRTSCTS flag.
