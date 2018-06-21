From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 21 Jun 2018 17:11:33 +0000
Subject: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180621074641.sqqvudxebt3hd43m@pengutronix.de>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
 <1529239789-26849-3-git-send-email-aisheng.dong@nxp.com>
 <20180620194310.GA28983@rob-hp-laptop>
 <20180621074641.sqqvudxebt3hd43m@pengutronix.de>
Message-ID: <AM0PR04MB4211B39D5AFAB95FC2A91F9980760@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, June 21, 2018 3:47 PM
> To: Rob Herring <robh@kernel.org>
> Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-arm-
> kernel at lists.infradead.org; dongas86 at gmail.com; kernel at pengutronix.de;
> shawnguo at kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-
> imx <linux-imx@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
> 
> On Wed, Jun 20, 2018 at 01:43:10PM -0600, Rob Herring wrote:
> > On Sun, Jun 17, 2018 at 08:49:47PM +0800, Dong Aisheng wrote:
> > > The Messaging Unit module enables two processors within the SoC to
> > > communicate and coordinate by passing messages (e.g. data, status
> > > and control) through the MU interface.
> > >
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree at vger.kernel.org
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > > v1->v2:
> > >  * typo fixes
> > >  * remove status property
> > >  * remove imx6&7 compatible string which may be added later for
> > >    the generic mailbox binding
> > >
> > > Note: Because MU used by SCU is not implemented as a mailbox driver,
> > > Instead, they're provided in library calls to gain higher performance.
> >
> > Using a binding doesn't mean you have to use an OS's subsystem.
> >
> > What needs higher performance? What's the performance difference?
> Why
> > can't the mailbox framework be improved?
> 
> From what I see the performance is improved by polling the interrupt
> registers rather than using interrupts.
> I see no reason though why this can't be implemented with the mailbox
> framework as is.
> 

I thought you've agreed to not write generic MU(mailbox) driver for SCU.
https://www.spinics.net/lists/arm-kernel/msg650217.html
But seems it's still not quite certain...

I'd like to explain some more.

1) the interrupt mechanism is not quite suitable for SCU firmware protocol
as the transfer size would be more than 4 words and the response data size
is also undetermined (it's set by SCU firmware side during a response).
So polling mode may be the best way to handle this as MU message
handling usually is quite fast in a few microseconds.

2) It's true that Mailbox framework is well designed and powerful.
But it's not quite suitable for SCU MU as we don't need to use the most
bits of it. Mailbox seems like to be more suitable for a generic MU
mailbox driver used by various clients/servers.  But SCU MU are
quite specific to SCU protocol and can't be used by other clients
(MU 0~4 is fixed for SCU communication in MX8 HW design). 
Even we write a MU Mailbox driver for SCU MU, it's still not a general
one and can't be used by others (e.g. communication with M4).
So I'd believe the current library way is still the best approach for SCU MU
Using. But I'm also okay for another generic MU drivers for other common
communications between A core and M4 side.

3) We actually have tried the MU(Mailbox) internally, it increased a lot
complexity comparing to the current library way and got a booting time
regression issue due to extra delays introduced in handling SCU protocol
in mailbox way.

And finally a nature question to us is: 
What the benefit we can get for SCU MU using a mailbox way?

If we can't find benefits but introduce more complexities then why
we would do that way?

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7C8ec
> 827973f6e40d1fe1508d5d74b2471%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C636651640089438560&sdata=oRARdjilF4Ve2%2FnsXVhG7fmjXip
> H0HslgDMldbIGgY0%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
