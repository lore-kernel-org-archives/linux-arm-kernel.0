From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 26 Jun 2018 12:42:04 +0000
Subject: [PATCH V3 2/5] soc: imx: add mu library functions support
In-Reply-To: <20180626120125.bgw5tiy65uimjk6s@pengutronix.de>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
 <20180625093504.hyjbixnnmipiqopg@pengutronix.de>
 <AM0PR04MB4211D74B6DD6BCA9A00C5E80804A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180625134647.jewrmqzujpi7rfx6@pengutronix.de>
 <AM0PR04MB4211672C8EF978B578B87EEA80490@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180626120125.bgw5tiy65uimjk6s@pengutronix.de>
Message-ID: <AM0PR04MB4211E65D65E693F2CBA5854180490@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Tuesday, June 26, 2018 8:01 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions support
> 
> On Tue, Jun 26, 2018 at 08:53:55AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Monday, June 25, 2018 9:47 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio
> > > Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > > Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions
> > > support
> > >
> > > On Mon, Jun 25, 2018 at 11:59:04AM +0000, A.s. Dong wrote:
> > > > > -----Original Message-----
> > > > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > > > Sent: Monday, June 25, 2018 5:35 PM
> > > > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> > > > > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio
> > > > > Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > > > > Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions
> > > > > support
> > > > >
> > > > > On Fri, Jun 22, 2018 at 10:11:57PM +0800, Dong Aisheng wrote:
> > > > > > This is used for i.MX multi core communication.
> > > > > > e.g. A core to SCU firmware(M core) on MX8.
> > > > >
> > > > > I still believe that a generic driver for the MU should be used here.
> > > > > Handling hardware resources under the hood of the driver
> > > > > framework is a hack. Preventing the generic driver from matching
> > > > > against the SCU MU by adding some #mbox-cells = <0>; to the MU
> > > > > device node is
> > > even more a hack.
> > > > >
> > > >
> > > > That is not a hack from a HW point of view. The MU HW does not
> > > > have multi channels according to Reference Manual. Even we switch
> > > > to mailbox, we probably may still prefer mbox-cell = <0> as the
> > > > virtual
> > > channels do not fit for SCU MU.
> > >
> > > If you switch to mailbox then you'll need something for the driver
> > > to distinguish between the different transfer modes. One possibility
> > > would be to introduce channels like I suggested earlier, so one
> > > channel could simply mean "transfer in SCU mode".
> > >
> >
> > I feel that may be a little strange as device tree is used to description HW.
> > Mbox-cells = <0> is more reflecting the real HW, right?
> 
> The SCU code is Software, so once we try to bind a driver to the SCU we are
> leaving hardware description anyway. 

I'm not quite agree with this. SCU is just using MU to send messages.
We are still describing the MU in device tree from HW point of view.
SCU does not change the MU HW characteristics.

> The number of channels we have is defined by software.
> Consider the case when SCU would expect pinmux calls
> in MU tx register 0, clock control in register 1 and other calls in registers 2 and
> 3. You actually *can* see the MU as a unit with multiple channels, so why
> shouldn't we describe this in the device tree?
> 

Yes, SW does can abstract virtual channels according to HW capability.
That why I'm not against the virtual channels in Oleksij's patch.
But it's just not quite suitable for SCU MU case.

> >
> > > >
> > > > > We should really handle the MU in a driver and look for a way
> > > > > how the SCU case can coexist with other usages of the MUs.
> > > > >
> > > > > Your main argument against using the mailbox framework is that
> > > > > it can't handle polling in the way you need it and that the
> > > > > mailbox framework provides things that you do not need. I don't
> > > > > buy this argument. In the end the mailbox framework is around
> > > > > 500 lines of code, it shouldn't be that hard to add the missing
> > > > > features. From the transmit side I don't see any showstoppers,
> > > > > the mailbox frameworks could be used as ist. What is missing is
> > > > > a synchronous wait-for-new-messages and receive-message call,
> > > > > the currently existing
> > > asynchronous rx callback is indeed not suitable for the SCU.
> > > > > But as said, it should be doable to add that.
> > > > >
> > > >
> > > > Besides the mailbox framework may not suitable for SCU, another
> > > > important Reason is that even we force to switch to mailbox, it's
> > > > still can't be generic driver and it can only be used by SCU MU.
> > >
> > > You claim that the driver can't be generic. I claim the opposite though.
> > >
> >
> > The 'generic' I  mean here is a generic driver without any sense of protocol.
> > It only transfer a number of data. That means we need develop a
> > generic data transfer protocol to send only data without knowing any
> > protocol specific things.
> >
> > AFAIK SCU MU used data transfer protocol is different from M4 in
> > Oleksij Rempel's patch series. That means we need some specific hacks
> > to support both protocols. Then it's not a generic to me.
> 
> Yes, indeed. You'll need to be SCU mode aware in the driver. No doubt about
> this.
> 
> >
> > But it might be acceptable if the hack is quite small. However, I
> > can't see that up till now as M4 protocol based on virtual channel is
> > quite different from SCU MU, that means the hack will be big which may
> lose the 'generic'
> > meaning.
> >
> > > >
> > > > Let's see the mailbox doc where it also highlights it may somehow
> > > > depend on mailbox communication protocol.
> > > >
> > > > Documentation/mailbox.txt
> > > > ------------------------------------------------------------------
> > > > ----
> > > > ------------------ This document aims to help developers write
> > > > client and controller drivers for the API. But before we start,
> > > > let us note that the client (especially) and controller drivers
> > > > are likely going to be very platform specific because the remote
> > > > firmware is likely to be proprietary and implement non-standard
> protocol.
> > > > .....
> > >
> > > Read on:
> > >
> > > | So even if two platforms employ, say, PL320 controller, the client
> > > | drivers can't be shared across them. Even the PL320 driver might
> > > | need to accommodate some platform specific quirks.
> > >
> > > Here the MU would be the PL320 and the SCU mode would be the
> > > platform specific quirks.
> > >
> >
> > SCU can be platform specific, but how to make MU generic to be unware
> > of SCU transfer protocol?
> >
> > The current MU transfer protocol is already specific to SCU.
> > See:
> > typedef struct sc_rpc_msg_s {
> >         uint8_t version;
> >         uint8_t size;
> >         uint8_t svc;
> >         uint8_t func;
> >         union {
> >                 int32_t i32[(SC_RPC_MAX_MSG - 1)];
> >                 int16_t i16[(SC_RPC_MAX_MSG - 1) * 2];
> >                 int8_t i8[(SC_RPC_MAX_MSG - 1) * 4];
> >                 uint32_t u32[(SC_RPC_MAX_MSG - 1)];
> >                 uint16_t u16[(SC_RPC_MAX_MSG - 1) * 2];
> >                 uint8_t u8[(SC_RPC_MAX_MSG - 1) * 4];
> >         } DATA;
> > } sc_rpc_msg_t;
> >
> > Where MU knows the size to transfer.
> 
> The mailbox send hook takes a void *. You can interpret this pointer how you
> like, that's part of the design decision with the mailbox framework.
> There's no need to interpret this void * always in the same manner in your
> driver, nothing prevent us from casting it to some SCU message for the SCU
> case and to something different in !SCU case.

The point is that means we need handle protocol specific thing in MU driver
which should be protocol unware.
Looking at arm mhu and ti mu:
drivers/mailbox/arm_mhu.c
drivers/mailbox/ti-msgmgr.c
I've studies them carefully and none of them are protocol aware.

But I'm not strongly against it if the protocol specific bits is not much.
The problem is how do we handle them in a proper way to avoid too much
complexities added in the MU driver which should be generic.

> 
> >
> > > > ------------------------------------------------------------------
> > > > ----
> > > > ------------------
> > > >
> > > > So the question to us is: If it can't be generic driver which can
> > > > be used by others as well and it introduces much unnecessary
> > > > complexities, why do we need do that? What's real benefits we can
> have?
> > >
> > > The driver can be used by others, the additional complexity is not
> > > that much and your code may be in a more upstreamable shape.
> > >
> >
> > Okay, then let's try to see the complexity if trying to support two
> > type protocols in a 'generic' driver:
> >
> > As I said earlier, we internally have tried mailbox already, and the
> implementation is:
> > 1) One channel per MU
> > 2) Tx using the same way to send msg as sc_ipc_write() in polling mode
> > 3) Rx enables the first word interrupt and polling for the rest of them in a
> hrtimer.
> 
> And that's where the current mailbox framework lacks real polling mode.
> 

Yes, that means we need extend it to support SCU alike clients well.

> >
> > M4 is quite different in Oleksij Rempel's patch.
> > The questions to us is:
> > 1) what's generic data transfer protocol should we use?
> 
> None. As mentioned above, in SCU case cast it to whatever you need.
> 

Same as I explained above. Cast it in MU driver means we bring protocol
specific bits into generic MU driver. Especially if we want to support
more than one protocols.

> >
> > This patch is not aim to support M4 as current kernel still does not support
> M4.
> > We don't have to figure out everything in one patch, right?
> > That will make us hard to do even a simple thing.
> 
> No, and I don't expect you to implement M4 support, and in fact it is not clear
> if Oleksijs patch implements the M4 support in a way we actually need it later.
> 

That did confuse me before as I thought you wanted that way.

> >
> > Mailbox support obviously is another thing which is independent of
> > this patch series. They're not conflict thing. You obviously could
> > extend your MU driver to support SCU as well. If it's proved to better
> > than current way, we definitely could switch to it later. It's not
> > clean up old code, it's just simply switch to a new way.
> 
> Provided you don't use a mailbox driver then we'll have to prevent a mailbox
> driver from binding to the device that is used for the SCU. And yes, that's
> what I consider having to cleanup after you.
> 

That's really a neglectable thing which could be simply by passed for SCU MU nodes.

Anyway, I guess current discussing way based on assumptions is not efficient.
To avoid stopping at this point, I'm going to send the mailbox driver we've
tested internally. Then we can discuss against it instead of talking with the air.
Hope that will help us about this blocking issue.

Regards
Dong Aisheng

> Sascha
> 
> 
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7C465
> 6c47737ad474699a708d5db5c8bc3%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C636656112894065518&sdata=dLVJIZKy8YPSFSNfJX4wpMAiu2GD
> Wbonqo37U7PKGH4%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
