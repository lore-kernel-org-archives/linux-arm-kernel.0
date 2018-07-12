From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Jul 2018 09:01:29 +0200
Subject: [RFC PATCH v6 2/2] mailbox: imx-mailbox: add scu protocol support
In-Reply-To: <1531326759-20556-3-git-send-email-aisheng.dong@nxp.com>
References: <1531326759-20556-1-git-send-email-aisheng.dong@nxp.com>
 <1531326759-20556-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180712070129.tyetqm2yesouiatf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 12:32:39AM +0800, Dong Aisheng wrote:
> Add SCU protocol support in the generic mailbox driver.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/mailbox/Kconfig       |   6 +-
>  drivers/mailbox/imx-mailbox.c | 252 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 223 insertions(+), 35 deletions(-)
> 
> +static bool imx_mu_scu_peek_data(struct mbox_chan *chan)
> +{
> +	struct imx_mu_priv *priv = chan->con_priv;
> +	u8 *raw_data;
> +	int i, size;
> +	int ret;
> +
> +	ret = imx_mu_scu_receive_msg(chan, 0, priv->msg);
> +	if (ret)
> +		return false;
> +
> +	raw_data = (u8 *)priv->msg;
> +	size = raw_data[1];
> +
> +	dev_dbg(chan->mbox->dev, "receive data: hdr 0x%x size %d\n",
> +		*priv->msg, size);
> +
> +	for (i = 1; i < size; i++) {
> +		ret = imx_mu_scu_receive_msg(chan, i % 4, priv->msg + i);
> +		if (ret)
> +			return false;
> +	}
> +
> +	mbox_chan_received_data(chan, (void *)priv->msg);
> +
> +	return true;
> +}

Receiving data now works by calling mbox_client_peek_data(). I think
your plan is not to use rx_callback as triggered by mbox_chan_received_data,
but instead exploiting the fact that you have put the receive data into
the same buffer that you previously used to send a message. That way the
client knows where to find the answer.

While that should work I don't think this is very clean. That is the
point where I mentioned I think that the mailbox framework would need a
way to receive messages synchronously.

Jassi, this is for you probably. Do you have an idea how synchronous
receive could be implemented? We'll need some mbox_client_receive_data
function.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
