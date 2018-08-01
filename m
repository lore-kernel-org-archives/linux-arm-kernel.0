From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 1 Aug 2018 07:05:30 +0200
Subject: [PATCH v8 2/4] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY1ZusgN4UVxmUgXZS9ObGdLwFAL4XkW7F1yVb6Gq=9XPA@mail.gmail.com>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-3-o.rempel@pengutronix.de>
 <CABb+yY1ZusgN4UVxmUgXZS9ObGdLwFAL4XkW7F1yVb6Gq=9XPA@mail.gmail.com>
Message-ID: <20180801050530.nzmomvvyo5pfwclz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 09:28:09PM +0530, Jassi Brar wrote:
> On Tue, Jul 31, 2018 at 7:41 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > Each MU has four pairs of rx/tx data register with four rx/tx interrupts
> > which can also be used as a separate channel.
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/mailbox/fsl,mu.txt    | 28 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > index 90e4905dfc69..9efd3a9ade44 100644
> > --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > @@ -18,11 +18,33 @@ Messaging Unit Device Node:
> >  Required properties:
> >  -------------------
> >  - compatible : should be "fsl,<chip>-mu", the supported chips include
> > -               imx8qxp, imx8qm.
> > +               imx6sx, imx7s, imx8qxp, imx8qm.
> > +               The "fsl,imx6sx-mu" compatible is seen as generic and should
> > +               be included together with SoC specific compatible.
> >  - reg :                Should contain the registers location and length
> >  - interrupts : Interrupt number. The interrupt specifier format depends
> >                 on the interrupt controller parent.
> > -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> > +- #mbox-cells:  Must be 2.
> >
> This seems like modifying the bindings. But since nothing exists yet,
> maybe we should merge patch 1 and 2 ?

For some weeks I already asked to squash this patches.. it was not
ACKed. We can try again... @Rob, @Aisheng, should I merge this two
patches?

> 
> > +                         <&phandle type channel>
> > +                           phandle   : Label name of controller
> > +                           type      : Channel type
> > +                           channel   : Channel number
> > +
> > +               This MU support 4 type of unidirectional channels, each type
> > +               has 4 channels. A total of 16 channels. Following types are
> > +               supported:
> > +               0 - TX channel with 32bit transmit register and IRQ transmit
> > +               acknowledgment support.
> > +               1 - RX channel with 32bit receive register and IRQ support
> > +               2 - TX doorbell channel. Without own register and no ACK support.
> > +               3 - RX doorbell channel.
> >
> Thanks. This is great.
> 
> > +               The doorbell channels should be used with shared memory and protocol
> > +               level acknowledgment if needed.
> > +
> I would avoid this. People might get notions that they have to use
> shmem with doorbell -- a trivial protocol might mean doing some fixed
> action (like reset) whenever the doorbell rings.

Ok.

> 
> > +Optional properties:
> > +-------------------
> > +- clocks :     phandle to the input clock.
> > +- fsl,mu-side-b : Should be set for side B MU.
> >
> Nit: can we call this 'fsl,no-init' ?

No. It is HW description and not functionality which is present in
current Linux driver.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/07207792/attachment.sig>
