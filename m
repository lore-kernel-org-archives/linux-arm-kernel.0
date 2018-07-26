From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 21:14:05 +0530
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 5:21 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:

>>
>> > Each MU has four pairs of rx/tx data register with four rx/tx
>> > interrupts which can also be used as a separate channel.
>> >
>> So the hardware actually supports 4 channels.
>>
>> > -- #mbox-cells:  Must be 0. Number of cells in a mailbox
>> > +- #mbox-cells:  Must be:
>> > +               0 - for single channel mode. i.MX8* SCU protocol specific.
>> > +               1 - for multichannel (generic) mode.
>> > +
>> No, please.
>> DT bindings should reflect the real hardware, and not the software mode we
>> want the driver to work in.
>> Please define mbox-cells=1  and have the i.MX8* platform always ask for
>> channel-0.
>
> The reality is that MU hardware does not define channels in reference manual.
> However, it does have four separate data tx/rx register which can be used
> as 'virtual' channels which is supported by this current driver.
>
> See below HW description from the reference manual:
> For messaging, the MU has four, 32-bit write-only transmit registers and four, 32-bit
> read-only receive registers on the Processor B and Processor A-sides. These registers are
> used for sending messages to each other.
>
For a while please forget the protocol(user) level usage, and consider
only what your h/w is.

MU has 4 pairs of TX_Reg + TX_IRQ, and 4 pairs of RX_Reg + RX_IRQ.
(MU also has 4 "doorbell" type channels that it calls GP, but those
are not managed here, so lets not worry atm).

By definition, a mailbox channel is simply a signal, optionally with
data attached. So, MU has 4 TX and 4 RX channels.

The MU driver should populate 8 unidirectional (4 Tx and 4 RX)
channels and set each tx/rx operation to trigger the corresponding
interrupt. This is not my whim, this is how the controller is!

The SCU is poorly implemented as it ignores 3 irqs and club all 4
register together (there are many other cons of this approach but lets
not get into that).
Personally, I would push-back on such a bad design. But if you claim
you have no choice but to support SCU as such, the work around could
be simpler than defining a new "scu mode" altogether.

#mbox-cells:  Must be 3.
                      First cell is 1 for TX and 0 for RX channel
                      Second cell is index of the channel [0,1,2 or 3]
                      Third cell is 1 if the channel triggers an IRQ,
0 if not. That is ACR.RIE/TIE bits are set or not.

Normal clients would always request a channel with irqs enabled.
The SCU client would request all 8 channels -- TX/RX[0,1,2] with irqs
disabled, TX/RX[3] with irqs enabled. And SCU will read/write 4 word
data over 4 rx/tx channels, instead of the virtually concocted one.


> short messages
> Transmit register(s) can be used to pass short messages
> from one to four words in length. For example, when a four-word message is desired,
> only one of the registers needs to have its corresponding interrupt enable bit set at the
> receiver side; the message?s first three words are written to the registers whose
> interrupt is masked, and the fourth word is written to the other register (which
> triggers an interrupt at the receiver side).
>
> The reference manual is at here: (Chapter 42 Messaging Unit (MU)
> https://www.nxp.com/docs/en/reference-manual/IMX6ULRM.pdf
>
> And SCU firmware does use MU in above way specified by reference manual.
> Even from HW point of view, it's still one channel only mailbox.
>
Please realise that any manual is written by a mere mortal afterall.
How the controller works is set in stone, but how the controller can
be used ... is just someones suggestion.

The approach I suggest above, conforms to the api and prevents a
provider dancing to the tunes of a user.
