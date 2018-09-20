From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 20 Sep 2018 06:41:15 +0000
Subject: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
In-Reply-To: <20180920063358.GS4097@pengutronix.de>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
 <20180919194100.GQ4097@pengutronix.de>
 <AM0PR04MB42118370CE61B3A5E86DFFE980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180920063358.GS4097@pengutronix.de>
Message-ID: <AM0PR04MB4211FB690E079766D364E94F80130@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, September 20, 2018 2:34 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: Re: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
> 
> On Thu, Sep 20, 2018 at 02:27:00AM +0000, A.s. Dong wrote:
> > Hi Sasha,
> >
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Thursday, September 20, 2018 3:41 AM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi
> > > Brar <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > shawnguo at kernel.org
> > > Subject: Re: [PATCH V6 2/3] firmware: imx: add SCU firmware driver
> > > support
> > >
> > > Hi Dong,
> > >
> > > Looks mostly ok for me now. Some small things inside.
> > >
> >
> > Great, thanks for the keeping review.
> >
> > > On Wed, Sep 19, 2018 at 11:04:05AM +0800, Dong Aisheng wrote:
> > > > The System Controller Firmware (SCFW) is a low-level system
> > > > function which runs on a dedicated Cortex-M core to provide power,
> > > > clock, and resource management. It exists on some i.MX8
> > > > processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > >
> > > > This patch implements the SCU firmware IPC function and the common
> > > > message sending API sc_call_rpc.
> > > >
> > > > +int sc_ipc_get_handle(struct sc_ipc *ipc) {
> > > > +	if (!scu_ipc_handle)
> > > > +		return -EPROBE_DEFER;
> > > > +
> > > > +	ipc = scu_ipc_handle;
> > >
> > > You are modifying a local pointer here instead of returning it.
> > >
> >
> > My bad mistake.
> > It should be:
> > int sc_ipc_get_handle(struct sc_ipc **ipc) {
> >         if (!scu_ipc_handle)
> >                 return -EPROBE_DEFER;
> >
> >         *ipc = scu_ipc_handle;
> >         return 0;
> > }
> >
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(sc_ipc_get_handle);
> > >
> > > Could you give the exported functions a better namespace like imx_scu_*?
> > >
> >
> > Good idea.
> > Should we change all the rest as well?
> 
> You mean enums and such? Yes, that would be good.

I mean other functions and struct names. All prefixed by imx_scu.
Enums still not changed.
e.g.
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 25e7bfe..46185a8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -3,7 +3,7 @@
  * Copyright 2018 NXP
  *  Author: Dong Aisheng <aisheng.dong@nxp.com>
  *
- * Implementation of the IPC functions using MUs (client side).
+ * Implementation of the SCU IPC functions using MUs (client side).
  *
  */
 
@@ -23,17 +23,17 @@
 #define SCU_MU_CHAN_NUM                8
 #define MAX_RX_TIMEOUT         (msecs_to_jiffies(30))
 
-struct sc_chan {
-       struct sc_ipc *sc_ipc;
+struct imx_scu_chan {
+       struct imx_scu_ipc *sc_ipc;
 
        struct mbox_client cl;
        struct mbox_chan *ch;
        int idx;
 };
 
-struct sc_ipc {
+struct imx_scu_ipc {
        /* SCU uses 4 Tx and 4 Rx channels */
-       struct sc_chan chans[SCU_MU_CHAN_NUM];
+       struct imx_scu_chan chans[SCU_MU_CHAN_NUM];
        struct device *dev;
        struct mutex lock;
        struct completion done;
@@ -44,25 +44,25 @@ struct sc_ipc {
        u8 count;
 };
 
-static struct sc_ipc *scu_ipc_handle;
+static struct imx_scu_ipc *imx_scu_ipc_handle;
...

Regards
Dong Aisheng

> 
> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C7a
> cdea46056b4793dac008d61ec30e04%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636730220455595791&amp;sdata=xoD9zOJ%2BZyQebWC
> NV0zdiPkR0hFRPovWaYwxYSe8uWw%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
