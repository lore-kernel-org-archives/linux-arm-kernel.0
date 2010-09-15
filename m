From: olivier.barthel@gmail.com (Olivier Barthel)
Date: Wed, 15 Sep 2010 17:38:58 +0200
Subject: i.mx25 :trouble with serial flow hardware
Message-ID: <AANLkTikb56gj78izBMhG2kL-mFOis9L0zk_kCYN5Gk6H@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
The serial number No 2 of i.MX25 is connected to the serial port of a
PC with a cable which only includes TXD, RXD, CTS, RTS signals. The
hardware flow control is activated on i.MX25 serial port, I changed
manually RTS on the PC.
Each time the PC's RTS signal goes from off to on , the PC receives a
burst of 4096 characters  (0x00 ) sent by i.MX25 serial port.

I think the problem is in the function imx_transmit_buffer of file
imx.c when this function is called by imx_start_tx called by
uart_handle_cts_change. It consumes a character in the ring buffer
(tail=tail+1) before testing whether the buffer is empty (tail=head?)
or not. In the next loop, the function detects 4095 items in the
circular buffer.
By moving the test before reading of ring buffer, the problem is
apparently corrected.
I am working on a kernel provided by Karo for triton-tx25 module. It's
 based on commit c8a4fb472c5101ec52f94b1e1277b8fde4b823cf of branch
mxc-master in git://git.pengutronix.de/git/imx/linux-2.6.git.  This
function has not been changed since this commit.
Regards,
Olivier
