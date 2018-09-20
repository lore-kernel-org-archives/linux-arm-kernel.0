From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 20 Sep 2018 02:27:00 +0000
Subject: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
In-Reply-To: <20180919194100.GQ4097@pengutronix.de>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
 <20180919194100.GQ4097@pengutronix.de>
Message-ID: <AM0PR04MB42118370CE61B3A5E86DFFE980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sasha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, September 20, 2018 3:41 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: Re: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
> 
> Hi Dong,
> 
> Looks mostly ok for me now. Some small things inside.
> 

Great, thanks for the keeping review.

> On Wed, Sep 19, 2018 at 11:04:05AM +0800, Dong Aisheng wrote:
> > The System Controller Firmware (SCFW) is a low-level system function
> > which runs on a dedicated Cortex-M core to provide power, clock, and
> > resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > (QM, QP), and i.MX8QX (QXP, DX).
> >
> > This patch implements the SCU firmware IPC function and the common
> > message sending API sc_call_rpc.
> >
> > +int sc_ipc_get_handle(struct sc_ipc *ipc) {
> > +	if (!scu_ipc_handle)
> > +		return -EPROBE_DEFER;
> > +
> > +	ipc = scu_ipc_handle;
> 
> You are modifying a local pointer here instead of returning it.
> 

My bad mistake.
It should be:
int sc_ipc_get_handle(struct sc_ipc **ipc)
{
        if (!scu_ipc_handle)
                return -EPROBE_DEFER;

        *ipc = scu_ipc_handle;
        return 0;
}

> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(sc_ipc_get_handle);
> 
> Could you give the exported functions a better namespace like imx_scu_*?
> 

Good idea.
Should we change all the rest as well?

> > +int sc_ipc_write(struct sc_ipc *sc_ipc, void *msg) {
> 
> Should be static.
> 

Got it.

> > +
> > +		dev_dbg(dev, "request mbox chan %s\n", chan_name);
> > +		/* chan_name is not used anymore by framework */
> > +		kfree(chan_name);
> > +	}
> > +
> > +	sc_ipc->dev = dev;
> > +	mutex_init(&sc_ipc->lock);
> > +	init_completion(&sc_ipc->done);
> > +
> > +	scu_ipc_handle = sc_ipc;
> > +
> > +	pr_info("NXP i.MX SCU Initialized\n");
> 
> dev_info

Got it

> 
> > +/*
> > + * This is an function to send an RPC message over an IPC channel.
> > + * It is called by client-side SCFW API function shims.
> > + *
> > + * @param[in]     ipc         IPC handle
> > + * @param[in,out] msg         handle to a message
> > + * @param[in]     no_resp     response flag
> > + *
> > + * If no_resp is false then this function waits for a response
> > + * and returns the result in msg.
> > + */
> > +int sc_call_rpc(struct sc_ipc *ipc, void *msg, bool no_resp);
> 
> better name it get_resp or something like that to avoid this double negation.
> 

Good suggestion. Will change.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Cf7
> 4fa9302c8045bf766608d61e67d575%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636729828671923075&amp;sdata=kBp9hhxmYCBP6fyegi%
> 2FFtTRG74aPijZuVwd1NY9o1cs%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
