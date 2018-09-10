From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 10 Sep 2018 09:44:08 +0000
Subject: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <20180910084042.3zihiimzrvappdjj@pengutronix.de>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-3-git-send-email-aisheng.dong@nxp.com>
 <20180910084042.3zihiimzrvappdjj@pengutronix.de>
Message-ID: <AM0PR04MB42114BE452BB4305A3EBE9DF80050@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, September 10, 2018 4:41 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: Re: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
> 
> On Tue, Aug 21, 2018 at 12:08:22AM +0800, Dong Aisheng wrote:
> > The System Controller Firmware (SCFW) is a low-level system function
> > which runs on a dedicated Cortex-M core to provide power, clock, and
> > resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > (QM, QP), and i.MX8QX (QXP, DX).
> >
> > This patch adds the SC firmware service APIs used by the system.
> > It mainly consists of two parts:
> > 1) Implementation of the IPC functions using MUs (client side).
> > 2) SCU firmware services APIs implemented based on RPC calls
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > +int sc_ipc_open(sc_ipc_t *ipc, struct device *dev) {
> > +	struct sc_ipc *sc_ipc;
> > +	struct sc_chan *sc_chan;
> > +	struct mbox_client *cl;
> > +	char *chan_name;
> > +	int ret;
> > +	int i;
> > +
> > +	sc_ipc = devm_kzalloc(dev, sizeof(*sc_ipc), GFP_KERNEL);
> > +	if (!sc_ipc)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < SCU_MU_CHAN_NUM; i++) {
> > +		if (i < 4)
> > +			chan_name = kasprintf(GFP_KERNEL, "tx%d", i);
> > +		else
> > +			chan_name = kasprintf(GFP_KERNEL, "rx%d", i - 4);
> > +
> > +		if (!chan_name)
> > +			return -ENOMEM;
> > +
> > +		sc_chan = &sc_ipc->chans[i];
> > +		cl = &sc_chan->cl;
> > +		cl->dev = dev;
> > +		cl->tx_block = false;
> > +		cl->knows_txdone = true;
> > +		cl->rx_callback = sc_rx_callback;
> > +
> > +		sc_chan->sc_ipc = sc_ipc;
> > +		sc_chan->idx = i % 4;
> > +		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > +		if (IS_ERR(sc_chan->ch)) {
> > +			ret = PTR_ERR(sc_chan->ch);
> > +			if (ret != -EPROBE_DEFER)
> > +				dev_err(dev, "Failed to get mbox %d\n", ret);
> > +
> > +			return ret;
> > +		}
> > +
> > +		dev_dbg(dev, "mbox request chan %s\n", chan_name);
> > +		/* chan_name is not used anymore by framework */
> > +		kfree(chan_name);
> > +	}
> > +
> > +	sc_ipc->dev = dev;
> > +	mutex_init(&sc_ipc->lock);
> > +	init_completion(&sc_ipc->done);
> > +
> > +	*ipc = (sc_ipc_t)sc_ipc;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(sc_ipc_open);
> 
> You export a sc_ipc_open() but it's only ever used once, in your internal code.
> Every other user uses sc_ipc_get_handle() which returns the same global
> handle for every user. In fact, I think sc_ipc_open()
> *can* only be used once, because every other user would get -EBUSY when
> requesting the same mailboxes again.
> 
> Please drop all this pseudo resource management nonsense. You simply do no
> resource management. Face it, there is only one global handle that is used,
> don't try to hide it.
> 

The original purpose of this code is that there're 5 MUs can be used by the system,
that means other users can choose to not use the default SCU MU. So sc_ipc_open()
may not be used only once.
e.g.
SCU MU1 sc_ipc_open()
CLK MU1 sc_ipc_get_handle()
Power Domain MU2 sc_ipc_open()
Pinctrl MU3 sc_ipc_open()
and etc...

>From TI SCI code, it seems it also support multiple SCI phandle although the kernel currently
Only users one. But the idea behind is the same.

> I had a look at the FSL Kernel to see where this code comes from and what the
> initial intention might be and I almost fell from my chair laughing.
> 

I'm really sorry you got a bad impression on the internal code.
We do know those issues and I've already reported them to internal team
a few months ago and I would like to help clean up them later.
For upstream, I actually have already totally rewritten the code, none of them
are used except keep a few function name definition from an abstract view.

> Every scu consumer does a:
> 
> >	sc_ipc_getMuID(&mu_id);
> 
> which returs a global mu id
> 
> >	sc_ipc_open(&ipcHndl, mu_id);
> 
> mu_id is not used in this function (or correctly, used to calculate a value which
> is then unused). ipcHndl is filled with the current task pid. Hell what, how is
> the current task pid used as an identifier? Ok, read on.
> 
> >	sc_misc_set_control(ipcHndl, ...);
> 
> Following the code we end up in sc_ipc_write() / sc_ipc_read() where this
> handle, filled with some random value is not even used. So everything around
> sc_ipc_getMuID() and sc_ipc_open() is just dead code.
> It's just a complicated way to generate an arbitrary number which then ends
> up being unused. Even some init code calls sc_ipc_open() and assigns the result
> to some global variable mu_ipcHandle.  This variable is only used to pass it to
> sc_irq_enable(), but looking at
> sc_irq_enable() you see that this parameter is again unused.
> 
> If you want to get this upstream I strongly suggest that you free yourself from
> the FSL codebase.

Yes, I've already totally rewritten them before upstream.
The above code you pointed out are not in my patches.

> 
> > +/*
> > + * This type is used to declare a handle for an IPC communication
> > + * channel. Its meaning is specific to the IPC implementation.
> > + */
> > +typedef unsigned long sc_ipc_t;
> 
> sc_ipc_t is a typedef to unsigned long. Let's see how it's used:
> 
> void sc_ipc_close(sc_ipc_t ipc)
> {
> 	struct sc_ipc *sc_ipc = (struct sc_ipc *)ipc;
> 	...
> }
> 
> So sc_ipc_t really is a struct sc_ipc *. Why don't you simply use it as such?
> Forget about typdefs. Do not use them. Call this thingy "struct sc_ipc" and
> that's it. No need for casting or typedefing.
> 

Our SCU firmware is OS independent. From SC point of view definition,
sc_ipc_t implementation is OS dependant. OS can interpret them into
the structure they needed. That's the orginal purpose and where the APIs
are prototyped.

But I'm also ok if you think no need to keep it as it's already determined
for Linux OS. Just let me know and I will do it.

Thanks for the review.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C3d
> 7053028342490dd3e008d616f91982%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636721656469432903&amp;sdata=MKpRwuI7HlZNmDcvrV
> OxpkUHqtv1It%2FHKiSK031ITuM%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
