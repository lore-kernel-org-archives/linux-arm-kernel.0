From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 26 Jun 2018 08:53:55 +0000
Subject: [PATCH V3 2/5] soc: imx: add mu library functions support
In-Reply-To: <20180625134647.jewrmqzujpi7rfx6@pengutronix.de>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
 <20180625093504.hyjbixnnmipiqopg@pengutronix.de>
 <AM0PR04MB4211D74B6DD6BCA9A00C5E80804A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180625134647.jewrmqzujpi7rfx6@pengutronix.de>
Message-ID: <AM0PR04MB4211672C8EF978B578B87EEA80490@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, June 25, 2018 9:47 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions support
> 
> On Mon, Jun 25, 2018 at 11:59:04AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Monday, June 25, 2018 5:35 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio
> > > Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > > Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions
> > > support
> > >
> > > On Fri, Jun 22, 2018 at 10:11:57PM +0800, Dong Aisheng wrote:
> > > > This is used for i.MX multi core communication.
> > > > e.g. A core to SCU firmware(M core) on MX8.
> > >
> > > I still believe that a generic driver for the MU should be used here.
> > > Handling hardware resources under the hood of the driver framework
> > > is a hack. Preventing the generic driver from matching against the
> > > SCU MU by adding some #mbox-cells = <0>; to the MU device node is
> even more a hack.
> > >
> >
> > That is not a hack from a HW point of view. The MU HW does not have
> > multi channels according to Reference Manual. Even we switch to
> > mailbox, we probably may still prefer mbox-cell = <0> as the virtual
> channels do not fit for SCU MU.
> 
> If you switch to mailbox then you'll need something for the driver to
> distinguish between the different transfer modes. One possibility would be
> to introduce channels like I suggested earlier, so one channel could simply
> mean "transfer in SCU mode".
> 

I feel that may be a little strange as device tree is used to description HW.
Mbox-cells = <0> is more reflecting the real HW, right?

> >
> > > We should really handle the MU in a driver and look for a way how
> > > the SCU case can coexist with other usages of the MUs.
> > >
> > > Your main argument against using the mailbox framework is that it
> > > can't handle polling in the way you need it and that the mailbox
> > > framework provides things that you do not need. I don't buy this
> > > argument. In the end the mailbox framework is around 500 lines of
> > > code, it shouldn't be that hard to add the missing features. From
> > > the transmit side I don't see any showstoppers, the mailbox
> > > frameworks could be used as ist. What is missing is a synchronous
> > > wait-for-new-messages and receive-message call, the currently existing
> asynchronous rx callback is indeed not suitable for the SCU.
> > > But as said, it should be doable to add that.
> > >
> >
> > Besides the mailbox framework may not suitable for SCU, another
> > important Reason is that even we force to switch to mailbox, it's
> > still can't be generic driver and it can only be used by SCU MU.
> 
> You claim that the driver can't be generic. I claim the opposite though.
> 

The 'generic' I  mean here is a generic driver without any sense of protocol.
It only transfer a number of data. That means we need develop a generic
data transfer protocol to send only data without knowing any protocol
specific things.

AFAIK SCU MU used data transfer protocol is different from M4 in Oleksij
Rempel's patch series. That means we need some specific hacks to support
both protocols. Then it's not a generic to me. 

But it might be acceptable if the hack is quite small. However, I can't see
that up till now as M4 protocol based on virtual channel is quite different
from SCU MU, that means the hack will be big which may lose the 'generic'
meaning.

> >
> > Let's see the mailbox doc where it also highlights it may somehow
> > depend on mailbox communication protocol.
> >
> > Documentation/mailbox.txt
> > ----------------------------------------------------------------------
> > ------------------ This document aims to help developers write client
> > and controller drivers for the API. But before we start, let us note
> > that the client (especially) and controller drivers are likely going
> > to be very platform specific because the remote firmware is likely to
> > be proprietary and implement non-standard protocol.
> > .....
> 
> Read on:
> 
> | So even if two platforms employ, say, PL320 controller, the client
> | drivers can't be shared across them. Even the PL320 driver might need
> | to accommodate some platform specific quirks.
> 
> Here the MU would be the PL320 and the SCU mode would be the platform
> specific quirks.
> 

SCU can be platform specific, but how to make MU generic to be unware of SCU
transfer protocol?

The current MU transfer protocol is already specific to SCU.
See:
typedef struct sc_rpc_msg_s {
        uint8_t version;
        uint8_t size; 
        uint8_t svc;
        uint8_t func;
        union {
                int32_t i32[(SC_RPC_MAX_MSG - 1)];
                int16_t i16[(SC_RPC_MAX_MSG - 1) * 2];
                int8_t i8[(SC_RPC_MAX_MSG - 1) * 4];
                uint32_t u32[(SC_RPC_MAX_MSG - 1)];
                uint16_t u16[(SC_RPC_MAX_MSG - 1) * 2];
                uint8_t u8[(SC_RPC_MAX_MSG - 1) * 4];
        } DATA;
} sc_rpc_msg_t;

Where MU knows the size to transfer.

> > ----------------------------------------------------------------------
> > ------------------
> >
> > So the question to us is: If it can't be generic driver which can be
> > used by others as well and it introduces much unnecessary
> > complexities, why do we need do that? What's real benefits we can have?
> 
> The driver can be used by others, the additional complexity is not that much
> and your code may be in a more upstreamable shape.
> 

Okay, then let's try to see the complexity if trying to support two type protocols
in a 'generic' driver:

As I said earlier, we internally have tried mailbox already, and the implementation is:
1) One channel per MU
2) Tx using the same way to send msg as sc_ipc_write() in polling mode
3) Rx enables the first word interrupt and polling for the rest of them in a hrtimer.

M4 is quite different in Oleksij Rempel's patch.
The questions to us is:
1) what's generic data transfer protocol should we use?
In Oleksij's patch, MU is unware of the data size and only send one word each time.
For data size, we probably can handle in client driver, but that means the client can
only send one word per time which loses the performance a lot. If we want the MU
driver to support send multi word data, MU must know how many words to send.
then a new data transfer protocol support needs to be added for SCU alike clients.
And we still need to support new polling way to handle multi words transfer.
BE NOTED that, SCU can transfer over 4 words, receiving is the same.
This is a big complexity comparing to Oleksij's patch.

To support this type protocol, one reference may be Ti:
include/linux/soc/ti/ti-msgmgr.h
struct ti_msgmgr_message {
        size_t len;
        u8 *buf;
};  
But we still need a simple hack for SCU specific as SCU size is the second u8 type.
If (!is_scu) 
   Buf = msg->buf;
   Len = Msg->len
Else
   Buf = msg_scu->buf;
   Len = msg_scu->size;

2) how to handle Rx in a generic way?
The same issue as above, for SCU alike clients, receiving by one word a time
Is low effiency. We need a high speed polling way as we did in library way now.
That means we need implement an active polling way in 'generic' MU for SCU alike
clients where current mailbox framework seems still not support well.
That's another totally brand new and complicated bits comparing to
Oleksij's patch.

All those things obviously are not small as you assumed!

They are much more complicated than the simple interrupt driven way
in Oleksij's patch. Just looks like to re-implement another new MU driver
specific to SCU alike clients, but do we really have another SCU alike clients?
And we need force to merge those much bigger bits into a generic MU driver
for M4 which actually won't be used by M4 just in order to be a mailbox alike driver
and may sacrifice the performance due to interrupt latency and etc.

It's really hard to believe it's a worth thing to do, especially at this stage because
that may blocks us at least a couple of month for MX8 upstreaming and waiting that
do be done first before anything else can keep going on.

IMHO unless we can find another real requirement for SCU alike protocols client,
Otherwise, it's really not worth to implement those bits into generic MU drivers
at this point. Or we fully change to TI alike protocol as above and don't support
virtual channels? That's at least more like SCU protocol.

> We are interested in a MU driver that is working for the generic M4 case and
> we are not interested in cleaning up after you when the adhoc MU access
> code is merged and in the way of a proper driver.
> 

This patch is not aim to support M4 as current kernel still does not support M4.
We don't have to figure out everything in one patch, right?
That will make us hard to do even a simple thing.

Mailbox support obviously is another thing which is independent of this patch
series. They're not conflict thing. You obviously could extend your MU driver
to support SCU as well. If it's proved to better than current way, we definitely
could switch to it later. It's not clean up old code, it's just simply switch to a
new way.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7C39f
> 8ac2353c44259e29108d5daa21a48%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636655312115361407&sdata=LwI83IgradQL2AYSnQMg64vxTqVV9
> TTJlWgpRN1VxdI%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
