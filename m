From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 30 Jul 2018 08:29:37 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
Message-ID: <AM0PR04MB4211FAC90C7B0BC288154273802F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Saturday, July 28, 2018 9:10 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; , Sascha Hauer
> <kernel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com>; , linux-arm-kernel at lists.infradead.org,
> linux-mediatek at lists.infradead.org, srv_heupstream <linux-arm-
> kernel at lists.infradead.org>; Devicetree List <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
> channel support
> 

[...]

> >> >
> >> > Sorry for may not clear, "Passing short message' usecase is to tell
> >> > how the HW is working on one channel mode sending up to 4 words in
> >> > one time As specified in reference manual.
> >> >
> >> > SCU does work that way, the only difference is it's using polling
> >> > mode rather than interrupt driven.  The point is the data size may
> >> > be different for each msg, so we can't simply know which data
> >> > register interrupt should be enable from static data defined in device
> tree.
> >> >
> >> And you think passing variable data through registers is a better
> >> idea than passing packets via shared-memory?
> >>
> >
> > You got me. :-)
> > I've no idea about which one is better.
> >
> Passing data directly via controller makes sense only when your protocol
> defines fixed length packets that fit into registers (usually
> FIFOs) or there is no shared memory between the processors.

Don't have to be fixed length packets. Every data packets less than 4 words
can be transferred in one time by controller perfectly well as it has 4 data registers.
No shared memory need.

> Otherwise, you write a data packet at some located in shmem, and provide
> its start and size along with the code of expected operation on it, over the
> mailbox. Please refer to "Passing frame information"
> para of page-2743 of your manual.
> That is another reason the SCU implementation is broken - it has variable
> length packets and yet use registers to pass them around.
> 

" Passing frame information" is used for long message transfer via shared memory.
But almost all the SCU data frames are less than 4 words. (only quite a few of them,
2~3, over 4 words) For these types of messages, it's obviously more efficient to transfer
them in "Passing short message' way as the MU hardware supports well.

So I believe our SCU firmware has already done the best choice in a most efficient
way (register write is obviously faster than memory copies). Thus, no shared memory
need to be used for SCU protocol case.

> 
> > The problem is SCU firmware is already there passing packets through
> > data registers, we have no way to change it.
> >
> OK. But what is SCU exactly? Part of ATF? Do you get some binary from third
> party? If the last, you shouldn't be paying hsit for such a design.
> 

The System Controller Firmware (SCFW) is a low-level system function
which runs on a dedicated Cortex-M core to provide power, clock, and
resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
(QM, QP), and i.MX8QX (QXP, DX). 

It's developed by NXP internally.

> 
> >>
> >> The hardware has 8 unidirectional channels. But your protocol (SCU
> >> implementation) assumes there is one _virtual_ channel that has 4
> >> registers and 1/0 irq --- which is not true. Instead of fixing the
> >> assumption in your protocol or emulating the virtual channel in the
> >> protocol level (user of a MU), you want to add code in the controller
> >> driver that ignores interrupts and club the 4 independent channels
> together.
> >>
> >
> > This stucks me. This is how the hardware is designed  and suggested to
> > use in hardware reference manual. And now you're telling me this is
> > wrong and we should not use the design in reference manual...
> >
> What you call "suggested to use in hardware reference manual" is just
> 1/5 examples of usecase.
> And SCU is not even doing that correctly (it uses variable length packet,
> unlike the fixed 4-words suggestion).

SCU is doing well. Please see my above reply.

> 
> A manual can suggest multiple ways of implementing a usecase. It is our job
> to chose the best one.

Well, great. That is also our orientation.
Because we thought the way " Passing short message " is the most suitable way for
SCU and is the most efficient way as the most SCU Messages are less than 4 words
and MU hardware supports transfer them well. We could not think out a reason to
not use it. That's why we choose that.

A simple objection that it uses variable length packet seems not quite convincible.
Unless we have more convincible reasons...

How do you think?

For example, what's the real benefits we can get if we drop the HW capability of
"passing Short messages" for SCU in one channel way and use separate 8 Tx/Rx channel
Instead to send them each time? What about the Performance downgrading? 
Is it valuable comparing to the complexity introduced?

Regards
Dong Aisheng
