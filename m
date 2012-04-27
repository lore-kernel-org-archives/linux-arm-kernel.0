From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Apr 2012 16:30:31 +0100
Subject: [PATCH 1/2] serial/imx: add DMA support
In-Reply-To: <CAMiH66FoEYEqudAOx7Y8GpgjfT-gX2qOi0BjG0-X8xH8u24kSw@mail.gmail.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <1335436632-29499-2-git-send-email-b32955@freescale.com>
 <20120426111116.GF24211@n2100.arm.linux.org.uk>
 <4F9A4417.7080107@freescale.com>
 <20120427082245.GJ24211@n2100.arm.linux.org.uk>
 <4F9A6AEE.30005@freescale.com>
 <20120427095003.GK24211@n2100.arm.linux.org.uk>
 <CAMiH66FoEYEqudAOx7Y8GpgjfT-gX2qOi0BjG0-X8xH8u24kSw@mail.gmail.com>
Message-ID: <20120427153031.GA27792@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:18:15AM -0400, Huang Shijie wrote:
> On Fri, Apr 27, 2012 at 5:50 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 27, 2012 at 05:46:22PM +0800, Huang Shijie wrote:
> >>>>> 1. How do you deal with transmitting the high-priority XON/XOFF
> >>>>> ? ? ?characters (port->x_char) which occur with s/w flow control and
> >>>>> ? ? ?the tty buffers fill up?
> >>>>> 2. How do you deal with flow control in general? ?IOW, what happens
> >>>>> ? ? ?when the remote end deasserts your CTS with h/w flow control enabled.
> >> If the remote end deasserts my CTS, it means the remote will not send
> >> any data.
> >>
> >> My DMA for RX will expire in the following steps:
> >> [1] the UART only waits for 32 bytes time long
> >> [2] the UART triggers an IDLE Condition Detect DMA.
> >> [3] the dma_rx_callback() will release the DMA for Rx.
> >
> > Err, hang on. ?I think you're totally confused about hardware flow
> > control. ?Certainly you're not using the correct terms for what you're
> > describing.
> >
> > The CTS input normally controls the transmitter. ?In many hardware
> > assisted hardware flow control setups, the deassertion of CTS merely
> > prevents the transmitter starting a new character.
> >
> > This shouldn't have any effect on the receiver of the same UART at all.
> >
> >>>>> ? ? ?How does your end deal with sending RTS according to flow control
> >>>>> ? ? ?conditions?
> >>>>>
> >> If a CTS is received after we sent out a RTS, it will follow the steps:
> >> ?imx_int() --> imx_rtsint() --> uart_handle_cts_change() -->start_tx()
> >>
> >> The start_tx() will create an TX DMA operation, and send out the data.
> >
> > The generation of RTS (connected to the remote ends CTS signal) is
> > supposed to control whether the remote end sends you characters. ?RTS
> http://en.wikipedia.org/wiki/Flow_control#Hardware_flow_control
> 
> >From the wiki, the generation of RTS (assert by the  "master end") is
> used to send data
> from the master to slave(the remote), not control the remote end sends
> me characters.

Well, there's a lot of confusion over RTS.  Most implementations of it
are as per this paragraph on the above page:

 A non-standard symmetric alternative, commonly called "RTS/CTS handshaking,"
 was developed by various equipment manufacturers. In this scheme, CTS is no
 longer a response to RTS; instead, CTS indicates permission from the DCE
 for the DTE to send data to the DCE, and RTS indicates permission from
 the DTE for the DCE to send data to the DTE. RTS and CTS are controlled
 by the DTE and DCE respectively, each independent of the other. This was
 eventually codified in version RS-232-E (actually TIA-232-E by that time)
 by defining a new signal, "RTR (Ready to Receive)," which is CCITT V.24
 circuit 133. TIA-232-E and the corresponding international standards were
 updated to show that circuit 133, when implemented, shares the same pin
 as RTS (Request to Send), and that when 133 is in use, RTS is assumed by
 the DCE to be ON at all times

This is what is actually used by all NULL modem cables, serial consoles,
and many modems can be (sensibly) configured to support it.  Many
modems can be configured via AT commands to respond as per the above
paragraph too.

And this is the hardware flow control scheme implemented by the Linux
Kernel for CRTSCTS, plus the hardware assisted hardware flow control
provided by industry standard UARTs such as the 1675x and later UARTs.
