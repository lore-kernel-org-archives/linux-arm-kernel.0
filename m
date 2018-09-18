From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 18 Sep 2018 08:22:40 +0200
Subject: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <AM0PR04MB4211DE42F39592DF40E91C1080040@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-3-git-send-email-aisheng.dong@nxp.com>
 <20180910084042.3zihiimzrvappdjj@pengutronix.de>
 <AM0PR04MB42114BE452BB4305A3EBE9DF80050@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180910121152.qyuuwxqesznzac7t@pengutronix.de>
 <AM0PR04MB4211DE42F39592DF40E91C1080040@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180918062240.GJ4097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 10:38:52AM +0000, A.s. Dong wrote:
> Hi Sascha,
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Monday, September 10, 2018 8:12 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> > <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > shawnguo at kernel.org
> > Subject: Re: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
> > 
> > On Mon, Sep 10, 2018 at 09:44:08AM +0000, A.s. Dong wrote:
> > > > -----Original Message-----
> > > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > > Sent: Monday, September 10, 2018 4:41 PM
> > > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi
> > > > Brar <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > > shawnguo at kernel.org
> > > > Subject: Re: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
> > > >
> > > > On Tue, Aug 21, 2018 at 12:08:22AM +0800, Dong Aisheng wrote:
> > > > > The System Controller Firmware (SCFW) is a low-level system
> > > > > function which runs on a dedicated Cortex-M core to provide power,
> > > > > clock, and resource management. It exists on some i.MX8
> > > > > processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > > >
> > > > > This patch adds the SC firmware service APIs used by the system.
> > > > > It mainly consists of two parts:
> > > > > 1) Implementation of the IPC functions using MUs (client side).
> > > > > 2) SCU firmware services APIs implemented based on RPC calls
> > > > >
> > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > ---
> > > > > +int sc_ipc_open(sc_ipc_t *ipc, struct device *dev) {
> > > > > +	struct sc_ipc *sc_ipc;
> > > > > +	struct sc_chan *sc_chan;
> > > > > +	struct mbox_client *cl;
> > > > > +	char *chan_name;
> > > > > +	int ret;
> > > > > +	int i;
> > > > > +
> > > > > +	sc_ipc = devm_kzalloc(dev, sizeof(*sc_ipc), GFP_KERNEL);
> > > > > +	if (!sc_ipc)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	for (i = 0; i < SCU_MU_CHAN_NUM; i++) {
> > > > > +		if (i < 4)
> > > > > +			chan_name = kasprintf(GFP_KERNEL, "tx%d", i);
> > > > > +		else
> > > > > +			chan_name = kasprintf(GFP_KERNEL, "rx%d", i - 4);
> > > > > +
> > > > > +		if (!chan_name)
> > > > > +			return -ENOMEM;
> > > > > +
> > > > > +		sc_chan = &sc_ipc->chans[i];
> > > > > +		cl = &sc_chan->cl;
> > > > > +		cl->dev = dev;
> > > > > +		cl->tx_block = false;
> > > > > +		cl->knows_txdone = true;
> > > > > +		cl->rx_callback = sc_rx_callback;
> > > > > +
> > > > > +		sc_chan->sc_ipc = sc_ipc;
> > > > > +		sc_chan->idx = i % 4;
> > > > > +		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > > > > +		if (IS_ERR(sc_chan->ch)) {
> > > > > +			ret = PTR_ERR(sc_chan->ch);
> > > > > +			if (ret != -EPROBE_DEFER)
> > > > > +				dev_err(dev, "Failed to get mbox %d\n", ret);
> > > > > +
> > > > > +			return ret;
> > > > > +		}
> > > > > +
> > > > > +		dev_dbg(dev, "mbox request chan %s\n", chan_name);
> > > > > +		/* chan_name is not used anymore by framework */
> > > > > +		kfree(chan_name);
> > > > > +	}
> > > > > +
> > > > > +	sc_ipc->dev = dev;
> > > > > +	mutex_init(&sc_ipc->lock);
> > > > > +	init_completion(&sc_ipc->done);
> > > > > +
> > > > > +	*ipc = (sc_ipc_t)sc_ipc;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(sc_ipc_open);
> > > >
> > > > You export a sc_ipc_open() but it's only ever used once, in your internal
> > code.
> > > > Every other user uses sc_ipc_get_handle() which returns the same
> > > > global handle for every user. In fact, I think sc_ipc_open()
> > > > *can* only be used once, because every other user would get -EBUSY
> > > > when requesting the same mailboxes again.
> > > >
> > > > Please drop all this pseudo resource management nonsense. You simply
> > > > do no resource management. Face it, there is only one global handle
> > > > that is used, don't try to hide it.
> > > >
> > >
> > > The original purpose of this code is that there're 5 MUs can be used
> > > by the system, that means other users can choose to not use the
> > > default SCU MU. So sc_ipc_open() may not be used only once.
> > > e.g.
> > > SCU MU1 sc_ipc_open()
> > > CLK MU1 sc_ipc_get_handle()
> > > Power Domain MU2 sc_ipc_open()
> > > Pinctrl MU3 sc_ipc_open()
> > > and etc...
> > 
> > Your code started by busy polling the MU units until it would send an answer.
> > The communication is completely synchronous and on the SCU side we have a
> > single core cortex M4 processor. Why should we use another SCU channel? I
> > bet the SCU side services the MUs round robin, so changing the MU won't
> > change much.
> 
> I carefully went through our SCU side code, SCU messages are completely handled
> asynchronously by interrupt driven and it does not have to wait for one SCU Message
> to be completed handled before being able to handle the next one.
> 
> The pseudo-code is like:
> Handle_mu_irq()
> {
> 	For (mu = 0; mu < NUM_MU; mu++) {
> 		If (mu_pending()) {
> 			Read(mu); // if available
> 			Handle(mu); //if rx done
> 			Write(mu);
> 		}
> 	}
> 	...
> }
> 
> That means Read and Write process for all MUs channels can be processed sequentially
> within one IRQ, Don't have to wait one of them to be fully completed first.
> 
> For example, the follow could be:
> MU IRQ #0 -> Read MU0 word 0-1 -> Read MU1 word 0-2 -> Read MU2 word 0 -> Exit.
> MU IRQ #1 -> Read MU0 word 2 -> Read MU1 word 3 -> Handle MU1 -> Write MU1
> 		 -> Read MU2 word 1 -> Exit.
> MU IRQ #2 -> Read MU0 word 3 -> Handle MU0 -> Write MU0 -> Read MU2 word 2
> 		 -> Handle MU2 -> Write MU2 -> Exit.
> (Assume MU0 msg size 4, MU1 msg size 4, MU2 msg size 3)
> 
> But if we only support one SCU MU in kernel, then all SCU messages must be handled
> one by one. So it seems like using multiple SCU MUs in kernel are still better than
> using a single one. Am I understand correct?

There's still only one CPU core in the SCU. Why should it be faster when
it does two things at the same time?

Honestly, start simple. Drop the stuff you don't need currently and add
it when you actually can argument *why* you need it and that it improves
something. And when we are there we can discuss how we want to do this
and how proper resource management can be done.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
