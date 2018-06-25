From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Jun 2018 11:35:04 +0200
Subject: [PATCH V3 2/5] soc: imx: add mu library functions support
In-Reply-To: <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180625093504.hyjbixnnmipiqopg@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 10:11:57PM +0800, Dong Aisheng wrote:
> This is used for i.MX multi core communication.
> e.g. A core to SCU firmware(M core) on MX8.

I still believe that a generic driver for the MU should be used here.
Handling hardware resources under the hood of the driver framework is a
hack. Preventing the generic driver from matching against the SCU MU by
adding some #mbox-cells = <0>; to the MU device node is even more a
hack.

We should really handle the MU in a driver and look for a way how the
SCU case can coexist with other usages of the MUs.

Your main argument against using the mailbox framework is that it can't
handle polling in the way you need it and that the mailbox framework
provides things that you do not need. I don't buy this argument. In the
end the mailbox framework is around 500 lines of code, it shouldn't be
that hard to add the missing features. From the transmit side I don't
see any showstoppers, the mailbox frameworks could be used as ist. What
is missing is a synchronous wait-for-new-messages and receive-message
call, the currently existing asynchronous rx callback is indeed not
suitable for the SCU. But as said, it should be doable to add that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
