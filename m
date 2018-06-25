From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 25 Jun 2018 11:59:04 +0000
Subject: [PATCH V3 2/5] soc: imx: add mu library functions support
In-Reply-To: <20180625093504.hyjbixnnmipiqopg@pengutronix.de>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
 <20180625093504.hyjbixnnmipiqopg@pengutronix.de>
Message-ID: <AM0PR04MB4211D74B6DD6BCA9A00C5E80804A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, June 25, 2018 5:35 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V3 2/5] soc: imx: add mu library functions support
> 
> On Fri, Jun 22, 2018 at 10:11:57PM +0800, Dong Aisheng wrote:
> > This is used for i.MX multi core communication.
> > e.g. A core to SCU firmware(M core) on MX8.
> 
> I still believe that a generic driver for the MU should be used here.
> Handling hardware resources under the hood of the driver framework is a
> hack. Preventing the generic driver from matching against the SCU MU by
> adding some #mbox-cells = <0>; to the MU device node is even more a hack.
> 

That is not a hack from a HW point of view. The MU HW does not have multi
channels according to Reference Manual. Even we switch to mailbox, we probably
may still prefer mbox-cell = <0> as the virtual channels do not fit for SCU MU.

> We should really handle the MU in a driver and look for a way how the SCU
> case can coexist with other usages of the MUs.
> 
> Your main argument against using the mailbox framework is that it can't
> handle polling in the way you need it and that the mailbox framework
> provides things that you do not need. I don't buy this argument. In the end
> the mailbox framework is around 500 lines of code, it shouldn't be that hard
> to add the missing features. From the transmit side I don't see any
> showstoppers, the mailbox frameworks could be used as ist. What is missing
> is a synchronous wait-for-new-messages and receive-message call, the
> currently existing asynchronous rx callback is indeed not suitable for the SCU.
> But as said, it should be doable to add that.
> 

Besides the mailbox framework may not suitable for SCU, another important
Reason is that even we force to switch to mailbox, it's still can't be generic driver
and it can only be used by SCU MU. 

Let's see the mailbox doc where it also highlights it may somehow depend on mailbox
communication protocol.

Documentation/mailbox.txt
----------------------------------------------------------------------------------------
This document aims to help developers write client and controller
drivers for the API. But before we start, let us note that the
client (especially) and controller drivers are likely going to be
very platform specific because the remote firmware is likely to be
proprietary and implement non-standard protocol.
.....
----------------------------------------------------------------------------------------

So the question to us is: If it can't be generic driver which can be
used by others as well and it introduces much unnecessary complexities,
why do we need do that? What's real benefits we can have?

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7Cfe5
> 2cb3aecd3461fab3d08d5da7eefc6%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C636655161075403401&sdata=bRnnlrq82OAlxoli5IHAtXuwieLGJM
> 4raDRvaV8y5gs%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
