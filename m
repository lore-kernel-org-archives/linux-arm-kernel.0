From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 24 Jul 2018 02:31:25 +0300
Subject: [PATCH v6 5/5] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <20180722063923.30222-6-o.rempel@pengutronix.de>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-6-o.rempel@pengutronix.de>
Message-ID: <846bb908-f75e-1988-8f30-e49a537c7969@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

On 07/22/2018 09:39 AM, Oleksij Rempel wrote:
> The Mailbox controller is able to send messages (up to 4 32 bit words)
> between the endpoints.
> 
> This driver was tested using the mailbox-test driver sending messages
> between the Cortex-A7 and the Cortex-M4.
> 
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

[snip]

> +static int imx_mu_startup(struct mbox_chan *chan)
> +{
> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp = chan->con_priv;
> +	int ret;
> +
> +	cp->irq_desc = devm_kasprintf(priv->dev, GFP_KERNEL, "imx_mu_chan[%i]",
> +				      cp->idx);
> +	if (!cp->irq_desc)
> +		return -ENOMEM;
> +

Again I would suggest to move this allocation to the loop in .probe function.

[snip]

> +
> +	for (i = 0; i < IMX_MU_CHANS; i++) {
> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
> +
> +		cp->idx = i;
> +		cp->irq = irq;

^^^^ right over here.

> +		priv->mbox_chans[i].con_priv = cp;
> +	}
> +

please feel free to add my technical side review tag to the next version:

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

FWIW I find that review comments from Lucas are pretty valid, I would
recommend to incorporate them.

--
Best wishes,
Vladimir
