From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 27 Jan 2016 11:30:32 +0100
Subject: Serial ports with non connected RTS/CTS
Message-ID: <56A89C48.1040604@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

currently, at least for 8250 based serial ports using of_serial, there 
is no way of indicating that the RTS / CTS lines, although supported by 
the UART, are not actually connected on the board.

This means that userspace needs to know about this and not use the 
CRTSCTS termios flag (otherwise no data is sent).

This is currently the case for Debian stattach for example (nettools 
1.60) which unconditionally uses CRTSCTS (but the busybox version of 
slattach has a "-F" option that can be used to disable CRTSCTS).

Would it not be better to allow this situation to be described in the 
device tree?

Such an option already exists for the imx UART (""fsl,uart-has-rtscts")

of_serial already has the "auto-flow-control" DT property but, as stated 
in the documentation:
     "The  driver is allowed to detect support for the capability even 
without this  property."

In the past there was a (since reverted) property "has-hw-flow-control"
See
     06aa82e "serial: uart: add hw flow control support configuration"
     a6eec92 " Revert "serial: uart: add hw flow control support 
configuration"

However that just provided another (redundant) way of *activating* 
hardware flow control and did not allow it to be disactivated.

Would a new DT property "no-rtscts" to do this be acceptable?

I think it would have to be a negative property to avoid breaking old 
device trees.

Since there seems to have been some to and fro on this issue I thought 
it would be a good idea to discuss before writing the patch...

Regards,

Martin
