From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 27 Jul 2018 04:02:56 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
Message-ID: <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Thursday, July 26, 2018 11:44 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Shawn Guo
> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; , Sascha Hauer
> <kernel@pengutronix.de>; , linux-arm-kernel at lists.infradead.org, linux-
> mediatek at lists.infradead.org, srv_heupstream <linux-arm-
> kernel at lists.infradead.org>; Devicetree List <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
> channel support
> 
> On Thu, Jul 26, 2018 at 5:21 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> >>
> >> > Each MU has four pairs of rx/tx data register with four rx/tx
> >> > interrupts which can also be used as a separate channel.
> >> >
> >> So the hardware actually supports 4 channels.
> >>
> >> > -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> >> > +- #mbox-cells:  Must be:
> >> > +               0 - for single channel mode. i.MX8* SCU protocol specific.
> >> > +               1 - for multichannel (generic) mode.
> >> > +
> >> No, please.
> >> DT bindings should reflect the real hardware, and not the software
> >> mode we want the driver to work in.
> >> Please define mbox-cells=1  and have the i.MX8* platform always ask
> >> for channel-0.
> >
> > The reality is that MU hardware does not define channels in reference
> manual.
> > However, it does have four separate data tx/rx register which can be
> > used as 'virtual' channels which is supported by this current driver.
> >
> > See below HW description from the reference manual:
> > For messaging, the MU has four, 32-bit write-only transmit registers
> > and four, 32-bit read-only receive registers on the Processor B and
> > Processor A-sides. These registers are used for sending messages to each
> other.
> >
> For a while please forget the protocol(user) level usage, and consider only
> what your h/w is.
> 
> MU has 4 pairs of TX_Reg + TX_IRQ, and 4 pairs of RX_Reg + RX_IRQ.
> (MU also has 4 "doorbell" type channels that it calls GP, but those are not
> managed here, so lets not worry atm).
> 
> By definition, a mailbox channel is simply a signal, optionally with data
> attached. So, MU has 4 TX and 4 RX channels.
> 
> The MU driver should populate 8 unidirectional (4 Tx and 4 RX) channels and
> set each tx/rx operation to trigger the corresponding interrupt. This is not my
> whim, this is how the controller is!
> 

This looks like reasonable to me, theoretically. 
Just not sure whether it's necessary to support it because we probably will never use
like that in reality, then it might become meaningless complicity introduced
and error prone.

And AFAIK ARM MHU is doing the same way as MU which looks like also unidirectional channel.
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0515b/CHDGBGIF.html
drivers/mailbox/arm_mhu.c

Sascha & Oleksij,
Any idea about this?

> The SCU is poorly implemented as it ignores 3 irqs and club all 4 register
> together (there are many other cons of this approach but lets not get into
> that).
> Personally, I would push-back on such a bad design. But if you claim you have
> no choice but to support SCU as such, the work around could be simpler than
> defining a new "scu mode" altogether.
> 

This is one of the recommended ways designed in HW reference manual and it
allows to send frame information up to 4 words without using shared memory.
SCU just follows it, so it's hard to believe it's a bad design.

> #mbox-cells:  Must be 3.
>                       First cell is 1 for TX and 0 for RX channel
>                       Second cell is index of the channel [0,1,2 or 3]
>                       Third cell is 1 if the channel triggers an IRQ,
> 0 if not. That is ACR.RIE/TIE bits are set or not.
> 
> Normal clients would always request a channel with irqs enabled.
> The SCU client would request all 8 channels -- TX/RX[0,1,2] with irqs disabled,
> TX/RX[3] with irqs enabled. And SCU will read/write 4 word data over 4 rx/tx
> channels, instead of the virtually concocted one.
> 

It may work If SCU protocol data length is fixed to 4 words. However, it's length
is flexible for different SVC service. That means this binding won't work for SCU.
And it will introduce much complexities during the implementation.

Instead, we're using polling mode for both TX/RX and the data size is stored in
the msg header and sending msgs using all 4 data tx/rx registers as a channel fifo.

> 
> > short messages
> > Transmit register(s) can be used to pass short messages from one to
> > four words in length. For example, when a four-word message is
> > desired, only one of the registers needs to have its corresponding
> > interrupt enable bit set at the receiver side; the message?s first
> > three words are written to the registers whose interrupt is masked,
> > and the fourth word is written to the other register (which triggers an
> interrupt at the receiver side).
> >
> > The reference manual is at here: (Chapter 42 Messaging Unit (MU)
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> ww
> > .nxp.com%2Fdocs%2Fen%2Freference-
> manual%2FIMX6ULRM.pdf&amp;data=02%7C0
> >
> 1%7Caisheng.dong%40nxp.com%7Cef349d7c9caf46c4260008d5f30e9ef5%7C6
> 86ea1
> >
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636682166494860332&amp;sdat
> a=54rE
> >
> iDm%2BGD6EY8NE64ck1LXVGoUCtWYrHXPoWqcujUo%3D&amp;reserved=0
> >
> > And SCU firmware does use MU in above way specified by reference
> manual.
> > Even from HW point of view, it's still one channel only mailbox.
> >
> Please realise that any manual is written by a mere mortal afterall.
> How the controller works is set in stone, but how the controller can be
> used ... is just someones suggestion.
> 
> The approach I suggest above, conforms to the api and prevents a provider
> dancing to the tunes of a user.

First of all, really appreciate for your suggestions. 
It may be hard to find a common binding with the same mbox-cells.
It looks like we just need a property is distinguish how the Mailbox is used
In one channel or multi channel mode.

Directly checking mbox-cells seems the most easy way and it is already Acked
by Rob. Can't this way be Okay to you?

Regards
Dong Aisheng
