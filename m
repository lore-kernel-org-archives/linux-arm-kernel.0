From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 24 Jan 2012 00:58:57 -0700 (MST)
Subject: omap-serial RX DMA polling?
In-Reply-To: <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
 <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
 <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
 <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
 <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com>
 <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jan 2012, Govindraj wrote:

> On Tue, Jan 24, 2012 at 1:18 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Mon, 23 Jan 2012, Govindraj wrote:
> >> On Mon, Jan 23, 2012 at 4:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > The point is that if you want tty_insert_flip_string() to be called after
> > every character is received, there seems little point in using RX DMA.
> > It should be less efficient than PIO. ?And the current way that it is used
> > is pointless from a power management point of view.
> 
> Yes, Its between power and performance, current way gives a better
> response for most devices

That seems rather unlikely.  And I don't agree that there is a balance to 
be struck in this case.  Compared to a correctly-working RX PIO path, the 
RX DMA in the current driver is likely to be much worse in energy 
consumption, and to be equal at best in receive latency.

In a correctly-working RX PIO path, the driver is going to receive an 
interrupt the moment the data is ready to be transferred from the FIFO.  
The driver doesn't have to wait for a polling timer to fire and execute.  
Nor does the ISR have to compete with a 1 microsecond polling timer for 
the CPU.

And I doubt that an accurate comparison could have been made between the 
PIO and DMA RX paths.  In the current driver, the PIO RX FIFO threshold 
was set to 16 bytes, while the DMA RX FIFO threshold in the DMA path was 
set to 1 byte.  So I'm hardly surprised that the RX DMA path looked good 
under those circumstances.  The current driver is sufficiently broken that 
any benchmarks based on it are suspect.  And in many cases, the way that 
the driver works around its problems is by effectively disabling system 
power management.

> (specially while downloading the firmware for external chip 
> initialization and other use cases)

Downloading firmware to an external chip uses the transmit path, not the 
receive path.  So that is an orthogonal case.

In terms of transmit, it's hardly surprising that the TX DMA path would 
outperform the driver's current TX PIO path.  For one thing, the FIFO 
handling in the current TX PIO path is broken.  The driver doesn't even 
use 75% of the TX FIFO.  Also, the transmission of a large block of data 
is not sensitive to MPU wakeup latency the same way that RX DMA is.  A 
large block of data can be queued to be transmitted, and the MPU doesn't 
need to wake up again until the SDMA has finished handing off that data to 
the UART FIFO.  At that point the kernel has plenty of time to prepare the 
next buffer.


- Paul
