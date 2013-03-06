From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Mar 2013 13:25:16 +0100
Subject: [PATCH v6 1/3] serial: sh-sci: Add OF support
In-Reply-To: <9335181.JoypQftkI4@avalon>
References: <1362569437-11133-1-git-send-email-hechtb+renesas@gmail.com>
 <9335181.JoypQftkI4@avalon>
Message-ID: <2479902.R2JaqaE7dT@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013 13:10:55 Laurent Pinchart wrote:
> On Wednesday 06 March 2013 12:30:35 Bastian Hecht wrote:
> > We add the capabilty to probe Renesas SCI devices using Device Tree setup.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > Reviewed-by: Paul Mundt <lethal@linux-sh.org>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v6:
> > putting it all together: I posted v5 as an incremental patch - here
> > the full version based on Simon Horman's tree topic/intc-of.
> > 
> > I will post another incremental version as well.
> > 
> > - rename sci at xxxxxxxx to serial at xxxxxxxx
> > - stick to scbrr-algorithm
> > 
> >  .../bindings/tty/serial/renesas,sci-serial.txt     |   47 +++++++
> >  drivers/tty/serial/sh-sci.c                        |  146 ++++++++++++++-
> >  include/linux/serial_sci.h                         |    4 +
> >  3 files changed, 193 insertions(+), 4 deletions(-)
> >  create mode 100644
> > 
> > Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> > b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt new
> > file mode 100644
> > index 0000000..d80039e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> > @@ -0,0 +1,47 @@
> > +* Renesas SH-Mobile Serial Communication Interface
> > +
> > +Required properties:
> > +- compatible : Should be "renesas,sci-<port type>-uart", where <port
> > type>
> > is +  "sci", "scif", "irda", "scifa", "scifb"
> > +  or for legacy devices
> > +  "sh2_scif_fifodata", "sh3_scif", "sh4_scif", "sh4_scif_no_scsptr",
> > +  "sh4_scif_fifodata", "sh7705_scif".
> > +- reg : Address and length of the register set for the device
> > +- interrupts : Should contain the following IRQs in this order:
> > +	ERI: receive-error interrupt
> > +	RXI: receive-FIFO-data-full interrupt
> > +	TXI: transmit-FIFO-data-empty interrupt
> > +	BRI: break reception interrupt
> > +- interrupt-names: The IRQ names "eri", "rxi", "txi" and "bri".
> > +- cell-index : The device id.
> > +- renesas,scscr : Should contain a bitfield used by the Serial Control
> > Register.
> > +  b7 = SCSCR_TIE
> > +  b6 = SCSCR_RIE
> > +  b5 = SCSCR_TE
> > +  b4 = SCSCR_RE
> > +  b3 = SCSCR_REIE
> > +  b2 = SCSCR_TOIE
> > +  b1 = SCSCR_CKE1
> > +  b0 = SCSCR_CKE0
> 
> What is that for exactly ?
> 
> > +- renesas,scbrr-algorithm : Choose an algorithm ID for the baud rate
> > generator.
> > +  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
> > +  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
> > +  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
> > +  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
> > +  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
> 
> Isn't it a property specific to our implementation of the driver instead of
> a hardware property ? How is one supposed to select the right algorithm ?

I realize I haven't expressed myself very clearly here. What I mean is that 
expressing how the baud rate generator works internally using an algorithm ID 
is pretty specific to the Linux driver.

I assume that, for a given serial port on a given SoC, the algorithm that 
matches the baud rate generator hardware implementation needs to be selected. 
Can't this information be inferred from the compatible string and port number 
?

-- 
Regards,

Laurent Pinchart
