From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 27 Sep 2013 12:14:21 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <21061.22576.404020.384558@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
 <524455FD.7070808@pengutronix.de>
 <20130926155422.GQ12758@n2100.arm.linux.org.uk> <52445FBE.4060503@ti.com>
 <21061.20097.221946.197751@ipc1.ka-ro> <5245535F.6020804@pengutronix.de>
 <21061.22576.404020.384558@ipc1.ka-ro>
Message-ID: <52455A7D.6030403@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 12:04 PM, Lothar Wa?mann wrote:

>> They layout of the flexcan varies in the different imx chips. I'm
>> comparing the datasheets at the moment. As Russell pointed out the area
>> staring at offset 0x80 is by the reception FIFO engine.
>>
> The layout is correct when the Rx FIFO is disabled!
> 
> removing 'FLEXCAN_MCR_FEN' from the MCR setting makes the driver work
> as expected (just without receive fifo).
> 
> For the use case with the FIFO enabled, the layout has to be changed
> obviously.

Can you just remove the loop completely? I think it's not needed. It
was in the original driver, when I picked it up.

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e1ac75d..57ee3df 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -778,17 +778,6 @@ static int flexcan_chip_start(struct net_device *dev)
        netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
        flexcan_write(reg_ctrl, &regs->ctrl);

-       for (i = 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
-               flexcan_write(0, &regs->cantxfg[i].can_ctrl);
-               flexcan_write(0, &regs->cantxfg[i].can_id);
-               flexcan_write(0, &regs->cantxfg[i].data[0]);
-               flexcan_write(0, &regs->cantxfg[i].data[1]);
-
-               /* put MB into rx queue */
-               flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
-                       &regs->cantxfg[i].can_ctrl);
-       }
-
        /* acceptance mask/acceptance code (accept everything) */
        flexcan_write(0x0, &regs->rxgmask);
        flexcan_write(0x0, &regs->rx14mask);

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/0383f13f/attachment.sig>
