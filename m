From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Jun 2018 15:46:47 +0200
Subject: [PATCH V3 2/5] soc: imx: add mu library functions support
In-Reply-To: <AM0PR04MB4211D74B6DD6BCA9A00C5E80804A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
 <20180625093504.hyjbixnnmipiqopg@pengutronix.de>
 <AM0PR04MB4211D74B6DD6BCA9A00C5E80804A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180625134647.jewrmqzujpi7rfx6@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 11:59:04AM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Monday, June 25, 2018 5:35 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions support
> > 
> > On Fri, Jun 22, 2018 at 10:11:57PM +0800, Dong Aisheng wrote:
> > > This is used for i.MX multi core communication.
> > > e.g. A core to SCU firmware(M core) on MX8.
> > 
> > I still believe that a generic driver for the MU should be used here.
> > Handling hardware resources under the hood of the driver framework is a
> > hack. Preventing the generic driver from matching against the SCU MU by
> > adding some #mbox-cells = <0>; to the MU device node is even more a hack.
> > 
> 
> That is not a hack from a HW point of view. The MU HW does not have multi
> channels according to Reference Manual. Even we switch to mailbox, we probably
> may still prefer mbox-cell = <0> as the virtual channels do not fit for SCU MU.

If you switch to mailbox then you'll need something for the driver to
distinguish between the different transfer modes. One possibility would
be to introduce channels like I suggested earlier, so one channel could
simply mean "transfer in SCU mode".

> 
> > We should really handle the MU in a driver and look for a way how the SCU
> > case can coexist with other usages of the MUs.
> > 
> > Your main argument against using the mailbox framework is that it can't
> > handle polling in the way you need it and that the mailbox framework
> > provides things that you do not need. I don't buy this argument. In the end
> > the mailbox framework is around 500 lines of code, it shouldn't be that hard
> > to add the missing features. From the transmit side I don't see any
> > showstoppers, the mailbox frameworks could be used as ist. What is missing
> > is a synchronous wait-for-new-messages and receive-message call, the
> > currently existing asynchronous rx callback is indeed not suitable for the SCU.
> > But as said, it should be doable to add that.
> > 
> 
> Besides the mailbox framework may not suitable for SCU, another important
> Reason is that even we force to switch to mailbox, it's still can't be generic driver
> and it can only be used by SCU MU.

You claim that the driver can't be generic. I claim the opposite though.

> 
> Let's see the mailbox doc where it also highlights it may somehow depend on mailbox
> communication protocol.
> 
> Documentation/mailbox.txt
> ----------------------------------------------------------------------------------------
> This document aims to help developers write client and controller
> drivers for the API. But before we start, let us note that the
> client (especially) and controller drivers are likely going to be
> very platform specific because the remote firmware is likely to be
> proprietary and implement non-standard protocol.
> .....

Read on:

| So even if two platforms employ, say, PL320 controller, the client drivers
| can't be shared across them. Even the PL320 driver might need to accommodate
| some platform specific quirks.

Here the MU would be the PL320 and the SCU mode would be the platform
specific quirks.

> ----------------------------------------------------------------------------------------
> 
> So the question to us is: If it can't be generic driver which can be
> used by others as well and it introduces much unnecessary complexities,
> why do we need do that? What's real benefits we can have?

The driver can be used by others, the additional complexity is not that
much and your code may be in a more upstreamable shape.

We are interested in a MU driver that is working for the generic M4
case and we are not interested in cleaning up after you when the adhoc
MU access code is merged and in the way of a proper driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
