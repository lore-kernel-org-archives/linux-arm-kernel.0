From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 11 Sep 2018 10:38:52 +0000
Subject: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <20180910121152.qyuuwxqesznzac7t@pengutronix.de>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-3-git-send-email-aisheng.dong@nxp.com>
 <20180910084042.3zihiimzrvappdjj@pengutronix.de>
 <AM0PR04MB42114BE452BB4305A3EBE9DF80050@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180910121152.qyuuwxqesznzac7t@pengutronix.de>
Message-ID: <AM0PR04MB4211DE42F39592DF40E91C1080040@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, September 10, 2018 8:12 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: Re: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
> 
> On Mon, Sep 10, 2018 at 09:44:08AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Monday, September 10, 2018 4:41 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi
> > > Brar <jassisinghbrar@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > shawnguo at kernel.org
> > > Subject: Re: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
> > >
> > > On Tue, Aug 21, 2018 at 12:08:22AM +0800, Dong Aisheng wrote:
> > > > The System Controller Firmware (SCFW) is a low-level system
> > > > function which runs on a dedicated Cortex-M core to provide power,
> > > > clock, and resource management. It exists on some i.MX8
> > > > processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > >
> > > > This patch adds the SC firmware service APIs used by the system.
> > > > It mainly consists of two parts:
> > > > 1) Implementation of the IPC functions using MUs (client side).
> > > > 2) SCU firmware services APIs implemented based on RPC calls
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > > +int sc_ipc_open(sc_ipc_t *ipc, struct device *dev) {
> > > > +	struct sc_ipc *sc_ipc;
> > > > +	struct sc_chan *sc_chan;
> > > > +	struct mbox_client *cl;
> > > > +	char *chan_name;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	sc_ipc = devm_kzalloc(dev, sizeof(*sc_ipc), GFP_KERNEL);
> > > > +	if (!sc_ipc)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	for (i = 0; i < SCU_MU_CHAN_NUM; i++) {
> > > > +		if (i < 4)
> > > > +			chan_name = kasprintf(GFP_KERNEL, "tx%d", i);
> > > > +		else
> > > > +			chan_name = kasprintf(GFP_KERNEL, "rx%d", i - 4);
> > > > +
> > > > +		if (!chan_name)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		sc_chan = &sc_ipc->chans[i];
> > > > +		cl = &sc_chan->cl;
> > > > +		cl->dev = dev;
> > > > +		cl->tx_block = false;
> > > > +		cl->knows_txdone = true;
> > > > +		cl->rx_callback = sc_rx_callback;
> > > > +
> > > > +		sc_chan->sc_ipc = sc_ipc;
> > > > +		sc_chan->idx = i % 4;
> > > > +		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > > > +		if (IS_ERR(sc_chan->ch)) {
> > > > +			ret = PTR_ERR(sc_chan->ch);
> > > > +			if (ret != -EPROBE_DEFER)
> > > > +				dev_err(dev, "Failed to get mbox %d\n", ret);
> > > > +
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		dev_dbg(dev, "mbox request chan %s\n", chan_name);
> > > > +		/* chan_name is not used anymore by framework */
> > > > +		kfree(chan_name);
> > > > +	}
> > > > +
> > > > +	sc_ipc->dev = dev;
> > > > +	mutex_init(&sc_ipc->lock);
> > > > +	init_completion(&sc_ipc->done);
> > > > +
> > > > +	*ipc = (sc_ipc_t)sc_ipc;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(sc_ipc_open);
> > >
> > > You export a sc_ipc_open() but it's only ever used once, in your internal
> code.
> > > Every other user uses sc_ipc_get_handle() which returns the same
> > > global handle for every user. In fact, I think sc_ipc_open()
> > > *can* only be used once, because every other user would get -EBUSY
> > > when requesting the same mailboxes again.
> > >
> > > Please drop all this pseudo resource management nonsense. You simply
> > > do no resource management. Face it, there is only one global handle
> > > that is used, don't try to hide it.
> > >
> >
> > The original purpose of this code is that there're 5 MUs can be used
> > by the system, that means other users can choose to not use the
> > default SCU MU. So sc_ipc_open() may not be used only once.
> > e.g.
> > SCU MU1 sc_ipc_open()
> > CLK MU1 sc_ipc_get_handle()
> > Power Domain MU2 sc_ipc_open()
> > Pinctrl MU3 sc_ipc_open()
> > and etc...
> 
> Your code started by busy polling the MU units until it would send an answer.
> The communication is completely synchronous and on the SCU side we have a
> single core cortex M4 processor. Why should we use another SCU channel? I
> bet the SCU side services the MUs round robin, so changing the MU won't
> change much.

I carefully went through our SCU side code, SCU messages are completely handled
asynchronously by interrupt driven and it does not have to wait for one SCU Message
to be completed handled before being able to handle the next one.

The pseudo-code is like:
Handle_mu_irq()
{
	For (mu = 0; mu < NUM_MU; mu++) {
		If (mu_pending()) {
			Read(mu); // if available
			Handle(mu); //if rx done
			Write(mu);
		}
	}
	...
}

That means Read and Write process for all MUs channels can be processed sequentially
within one IRQ, Don't have to wait one of them to be fully completed first.

For example, the follow could be:
MU IRQ #0 -> Read MU0 word 0-1 -> Read MU1 word 0-2 -> Read MU2 word 0 -> Exit.
MU IRQ #1 -> Read MU0 word 2 -> Read MU1 word 3 -> Handle MU1 -> Write MU1
		 -> Read MU2 word 1 -> Exit.
MU IRQ #2 -> Read MU0 word 3 -> Handle MU0 -> Write MU0 -> Read MU2 word 2
		 -> Handle MU2 -> Write MU2 -> Exit.
(Assume MU0 msg size 4, MU1 msg size 4, MU2 msg size 3)

But if we only support one SCU MU in kernel, then all SCU messages must be handled
one by one. So it seems like using multiple SCU MUs in kernel are still better than
using a single one. Am I understand correct?

Furthermore, If I understand correct, even SCU msg are processed one by one in SCU side.
Using multiple channels in kernel side still can improve the performance a bit in theory
Because it saves the MU lock contention time. Just like the Async request feature supported
By MMC subsystem(saving MMC command prepare time asynchronously). And multiple
MU channels actually are better because they're individual instances than mmc controller.

> 
> > Our SCU firmware is OS independent. From SC point of view definition,
> > sc_ipc_t implementation is OS dependant. OS can interpret them into
> > the structure they needed. That's the orginal purpose and where the
> > APIs are prototyped.
> 
> Nobody is interested in the SCU side here. I'd really like to have a peek, but it's
> totally irrelevant for the Kernel code.
> 

Okay, got your point. I would remove it.
I'd also wish it opensource some day in the future...

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C07
> e353ec055a48ca0eee08d61716992d%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636721783169922469&amp;sdata=o2rN%2FE3UtksWsVRC
> 37wgre5bwqlWu51ZQVgDOUDkG2U%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
