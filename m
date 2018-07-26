From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 26 Jul 2018 11:51:15 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
Message-ID: <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Thursday, July 26, 2018 5:50 PM
> To: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; , Sascha Hauer
> <kernel@pengutronix.de>; , linux-arm-kernel at lists.infradead.org, linux-
> mediatek at lists.infradead.org, srv_heupstream <linux-arm-
> kernel at lists.infradead.org>; Devicetree List <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
> channel support
> 
> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel <o.rempel@pengutronix.de>
> wrote:
> 
> > Each MU has four pairs of rx/tx data register with four rx/tx
> > interrupts which can also be used as a separate channel.
> >
> So the hardware actually supports 4 channels.
> 
> > -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> > +- #mbox-cells:  Must be:
> > +               0 - for single channel mode. i.MX8* SCU protocol specific.
> > +               1 - for multichannel (generic) mode.
> > +
> No, please.
> DT bindings should reflect the real hardware, and not the software mode we
> want the driver to work in.
> Please define mbox-cells=1  and have the i.MX8* platform always ask for
> channel-0.

The reality is that MU hardware does not define channels in reference manual.
However, it does have four separate data tx/rx register which can be used
as 'virtual' channels which is supported by this current driver.

See below HW description from the reference manual:
For messaging, the MU has four, 32-bit write-only transmit registers and four, 32-bit
read-only receive registers on the Processor B and Processor A-sides. These registers are
used for sending messages to each other.

Passing short messages
Transmit register(s) can be used to pass short messages
from one to four words in length. For example, when a four-word message is desired,
only one of the registers needs to have its corresponding interrupt enable bit set at the
receiver side; the message?s first three words are written to the registers whose
interrupt is masked, and the fourth word is written to the other register (which
triggers an interrupt at the receiver side).

The reference manual is at here: (Chapter 42 Messaging Unit (MU)
https://www.nxp.com/docs/en/reference-manual/IMX6ULRM.pdf

And SCU firmware does use MU in above way specified by reference manual.
Even from HW point of view, it's still one channel only mailbox.
That's why we change the mbox-cells to 0 accordingly to avoid confusing
the multi channels users supported in this driver.

As per Sasha's request, we're going to support both protocol (SCU and generic M4)
in one mailbox driver, that means we need deal with this two case property.

If we use mbox-cells 1 case for SCU, then the using would be like:
mboxes = <&mailbox 0> which is mixed with the normal multi channel
users. And we also must state clearly in binding doc that for mbox-cells
 1 case for SCU, the cell value must be 0 which is also confusing with
Multi channel users.

How do you suggest for such case?

Regards
Dong Aisheng
