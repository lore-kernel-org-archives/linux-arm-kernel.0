From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 10 Dec 2015 13:44:20 +0100
Subject: can: flexcan: Ancient Freescale Reference FlexCAN Driver and bug
 fixes so it works.
In-Reply-To: <56696582.7020503@optusnet.com.au>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <56696582.7020503@optusnet.com.au>
Message-ID: <566973A4.5000703@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2015 12:44 PM, Tom Evans wrote:
> I've just had to delve back into the deep murky past and try to get 
> Freescale's Kernel 2.6.35 FlexCAN driver working. That's because the 
> only code base that supports Freescale's Video Hardware is that one and 
> we need working video.

2.6.x I feel your pain. Another option would be to port the flexcan
driver to that old kernel. But I'm getting off topic here :)

> I'm suggesting this code as an "historical reference" that might be 
> useful for anyone looking for simple/simplistic ways to handle a FlexCAN 
> port. It isn't like the driver actually works fully. It can't have ever 
> been tested very much. Which is why I've had to fix it.
> 
> It has the Driver, Register handling and Message Buffer handling split 
> into three separate source files, which is a useful simplification.

YMMV :)

> It can't be configured with "canconfig", but exposes a huge number of 
> variables in the sysfs which is actually quite powerful and extendable.
> 
> Freescale's "2.6.35_maintain" kernel consists of 2.6.35 plus about 1200 
> Freescale patches which basically replace all the hardware drivers.
> 
> The source for this driver in this tree (until someone renames it to NXP):
> 
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_2.6.35_maintain
> 
> The Driver is in the expected place:
> 
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/net/can/flexcan?h=imx_2.6.35_maintain
> 
> 1 - It defaults to 32 receive and 32 transmit MBs, but that can be changed.
> 
> 2 - It can't receive in order, but you'd only need to sort on the 
> timestamps to fix that (or use the FIFO).

In order reception is crucial.

> 3 - It can't transmit in order either (unless you drop it to one 
> transmit MB), but a simple change to the Transmit MB assignment would 
> fix that.

Same here.

> 4 - It supports FIFO mode, but it doesn't work at all. The FIFO hardware 
> gets so badly screwed by the driver that it has to be power-cycled to 
> get it working again.
> 
> 5 - Transmit doesn't work either. If you push it it'll start sending ONE 
> Message per SECOND. That's an easy fix by changing the code to actually 
> unblock the netif queue instead of what it does.
> 
> 6 - The sysfs variable that reserves receive message buffers is named to 
> reserve transmit buffers, it messes up if the DLC is over 8 (because it 
> doesn't call get_can_dlc()), the Dump routines don't work properly, 
> off-by-one bug, comparison-reversal bug and so on.
> 
> 7 - The only good thing about it is that it doesn't use NAPI, so when 
> fixed it doesn't drop messages when you try to use MMC/eMMC/ESDHC.
> 
> FIFO bug documented and fixed here:
> 
> https://community.freescale.com/thread/381075
> 
> Transmit bug documented and fixed here (and the other ones listed), also 
> MMC/eMMC problem:
> 
> https://community.freescale.com/message/595897
> 
> Patches to fix all of it on the end of this thread:
> 
> https://community.freescale.com/thread/303271

If there's interest in working with this prehistoric kernel, why isn't
there anyone that picks up all the patches and add them to a git repo.
fsl doesn't seem to care either, maybe unless you're using their newest
product :(

just my 2?,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151210/e8f00de9/attachment-0001.sig>
