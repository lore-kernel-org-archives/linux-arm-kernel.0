From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 12 Jul 2018 07:31:43 +0000
Subject: [RFC PATCH v6 2/2] mailbox: imx-mailbox: add scu protocol support
In-Reply-To: <20180712070129.tyetqm2yesouiatf@pengutronix.de>
References: <1531326759-20556-1-git-send-email-aisheng.dong@nxp.com>
 <1531326759-20556-3-git-send-email-aisheng.dong@nxp.com>
 <20180712070129.tyetqm2yesouiatf@pengutronix.de>
Message-ID: <AM0PR04MB4211199413188F417F3AF2B280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, July 12, 2018 3:01 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> jassisinghbrar at gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: Re: [RFC PATCH v6 2/2] mailbox: imx-mailbox: add scu protocol
> support
> 
> On Thu, Jul 12, 2018 at 12:32:39AM +0800, Dong Aisheng wrote:
> > Add SCU protocol support in the generic mailbox driver.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/mailbox/Kconfig       |   6 +-
> >  drivers/mailbox/imx-mailbox.c | 252
> > ++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 223 insertions(+), 35 deletions(-)
> >
> > +static bool imx_mu_scu_peek_data(struct mbox_chan *chan) {
> > +	struct imx_mu_priv *priv = chan->con_priv;
> > +	u8 *raw_data;
> > +	int i, size;
> > +	int ret;
> > +
> > +	ret = imx_mu_scu_receive_msg(chan, 0, priv->msg);
> > +	if (ret)
> > +		return false;
> > +
> > +	raw_data = (u8 *)priv->msg;
> > +	size = raw_data[1];
> > +
> > +	dev_dbg(chan->mbox->dev, "receive data: hdr 0x%x size %d\n",
> > +		*priv->msg, size);
> > +
> > +	for (i = 1; i < size; i++) {
> > +		ret = imx_mu_scu_receive_msg(chan, i % 4, priv->msg + i);
> > +		if (ret)
> > +			return false;
> > +	}
> > +
> > +	mbox_chan_received_data(chan, (void *)priv->msg);
> > +
> > +	return true;
> > +}
> 
> Receiving data now works by calling mbox_client_peek_data(). I think your
> plan is not to use rx_callback as triggered by mbox_chan_received_data, but
> instead exploiting the fact that you have put the receive data into the same
> buffer that you previously used to send a message. That way the client
> knows where to find the answer.

Yes, exactly.

I just quickly sent out mu part for your review, ipc is still not cleaned up.
The test seemed ok.

The implementation is like:
int sc_call_rpc(sc_ipc_t ipc, sc_rpc_msg_t *msg, bool no_resp)
{
        struct sc_ipc *sc_ipc = (struct sc_ipc *)ipc;
        int ret;

        if (WARN_ON(!sc_ipc || !msg))
                return -EINVAL;

        /* Check size */
        if (msg->size > SC_RPC_MAX_MSG)
                return -EINVAL;

        dev_dbg(sc_ipc->cl.dev, "RPC SVC %u FUNC %u SIZE %u\n", RPC_SVC(msg),
                RPC_FUNC(msg), RPC_SIZE(msg));

        mutex_lock(&sc_ipc->lock);

        ret = mbox_send_message(sc_ipc->chan, msg);
        if (ret < 0) {
                dev_err(sc_ipc->cl.dev, "sc send msg failed: %d\n", ret);
                goto out;
        }

        if (!no_resp) {
                ret = mbox_client_peek_data(sc_ipc->chan);
                if (!ret)
                        return -ETIMEDOUT;
                else
                        ret = 0;
        }

        mbox_client_txdone(sc_ipc->chan, ret);

out:
        mutex_unlock(&sc_ipc->lock);

        dev_dbg(sc_ipc->cl.dev, "RPC SVC done\n");

        return ret;
}

> 
> While that should work I don't think this is very clean. That is the point where
> I mentioned I think that the mailbox framework would need a way to receive
> messages synchronously.
> 
> Jassi, this is for you probably. Do you have an idea how synchronous receive
> could be implemented? We'll need some mbox_client_receive_data
> function.
> 

Jassi seemed to believe .peek_data() works

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7
> Cfe3ebeb68c31461b8a9108d5e7c54ca8%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636669756934531262&amp;sdata=dRnijYEto0dFpSN0a2wne
> a%2BoodKIBxskVLg8%2BztKDPM%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
