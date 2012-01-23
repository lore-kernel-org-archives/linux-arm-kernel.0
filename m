From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 23 Jan 2012 03:47:23 -0700 (MST)
Subject: omap-serial RX DMA polling?
In-Reply-To: <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
 <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jan 2012, Govindraj wrote:

> On Mon, Jan 23, 2012 at 6:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > while trying to track down some of the serial-related PM issues in
> > v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 microsecond
> > polling timer when DMA is enabled (uart_dma.rx_timer) (!) ?This seems
> > quite broken from both the DMA and PM points of view.
> 
> Poll rate is used for doing tty_insert_flip_string for pushing data to 
> user space to keep faster response to any client device over uart, some 
> Bt chips expect faster response when data on uart arrives and packet 
> should be pushed out immediately.

Hmm.  Let's say that the BT transceiver uses the fastest transmission rate 
supported by the OMAP UARTs -- 3,686,400 bits per second, according to 
Table 17-1 in the 34xx TRM vZR.  So the RX poll timer would go off about 
~2.7 times per input character[1].  That seems like overkill...

For minimum receive latency, how about calling tty_insert_flip_string() 
from the RX DMA callback, and using a smaller transfer count?  Or even 
better, use PIO for the receive path and set the RX FIFO threshold to 1?

No poll timer should be needed in either case.


- Paul

1. At 10 line bits per character (start + byte + stop), each character 
should take about 2.7 microseconds to transfer (the reciprocal of (3 686 
400 line bits per second / 10 line bits per character / 1 000 000 
microseconds per second)).
