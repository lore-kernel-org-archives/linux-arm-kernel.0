From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 2 Aug 2018 11:47:03 +0200
Subject: [PATCH v9 4/4] mailbox: Add support for i.MX messaging unit
In-Reply-To: <4d6931be-8caa-5168-d980-40dbe949386c@mentor.com>
References: <20180802072325.22991-1-o.rempel@pengutronix.de>
 <20180802072325.22991-5-o.rempel@pengutronix.de>
 <4d6931be-8caa-5168-d980-40dbe949386c@mentor.com>
Message-ID: <df93c03d-a982-2aa4-f3eb-11caa4817dab@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

thank you for review.

Jassi, Dong, any other comments? If no, i'll send tomorrow updated version.

On 02.08.2018 09:54, Vladimir Zapolskiy wrote:
> Hi Oleksij,
> 
> two more nitpickings fro my side.
> 
> On 08/02/2018 10:23 AM, Oleksij Rempel wrote:
>> The i.MX Messaging Unit is a two side block which allows applications
>> implement communication over this sides.
>>
>> The MU includes the following features:
>> - Messaging control by interrupts or by polling
>> - Four general-purpose interrupt requests reflected to the other side
>> - Three general-purpose flags reflected to the other side
>> - Four receive registers with maskable interrupt
>> - Four transmit registers with maskable interrupt
>>
>> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
>> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [snip]
> 
>> +static irqreturn_t imx_mu_isr(int irq, void *p)
>> +{
>> +	struct mbox_chan *chan = p;
>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>> +	u32 val, ctrl, dat;
>> +
>> +	ctrl = imx_mu_read(priv, IMX_MU_xCR);
>> +	val = imx_mu_read(priv, IMX_MU_xSR);
>> +
>> +	switch (cp->type) {
>> +	case IMX_MU_TYPE_TX:
>> +		val &= IMX_MU_xSR_TEn(cp->idx) &
>> +			(ctrl & IMX_MU_xCR_TIEn(cp->idx));
>> +		break;
>> +	case IMX_MU_TYPE_RX:
>> +		val &= IMX_MU_xSR_RFn(cp->idx) &
>> +			(ctrl & IMX_MU_xCR_RIEn(cp->idx));
>> +		break;
>> +	case IMX_MU_TYPE_RXDB:
>> +		val &= IMX_MU_xSR_GIPn(cp->idx) &
>> +			(ctrl & IMX_MU_xCR_GIEn(cp->idx));
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (!val) {
>> +		return IRQ_NONE;
>> +	} else if (val == IMX_MU_xSR_TEn(cp->idx)) {
> 
> Please drop the 'else' branch above.
> 
> Here you can either just start from a new 'if', or all together drop 'if (!val)'
> and return IRQ_NONE at the end of the if-else construction.
> 
>> +		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
>> +		mbox_chan_txdone(chan, 0);
>> +	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
>> +		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
>> +		mbox_chan_received_data(chan, (void *)&dat);
>> +	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
>> +		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), IMX_MU_xSR);
>> +		mbox_chan_received_data(chan, NULL);
>> +	} else {
>> +		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> [snip]
> 
>> +	for (i = 0; i < IMX_MU_CHANS; i++) {
>> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
>> +
>> +		cp->idx = i % 4;
>> +		cp->type = (i - cp->idx) >> 2;
> 
> cp->type = i >> 2;
> 
>> +		cp->chan = &priv->mbox_chans[i];
>> +		priv->mbox_chans[i].con_priv = cp;
>> +		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
>> +			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
>> +	}
>> +
>> +	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
>> +
>> +	spin_lock_init(&priv->xcr_lock);
>> +
>> +	priv->mbox.dev = dev;
>> +	priv->mbox.ops = &imx_mu_ops;
>> +	priv->mbox.chans = priv->mbox_chans;
>> +	priv->mbox.num_chans = IMX_MU_CHANS;
>> +	priv->mbox.of_xlate = imx_mu_xlate;
>> +	priv->mbox.txdone_irq = true;
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	imx_mu_init_generic(priv);
>> +
>> +	return mbox_controller_register(&priv->mbox);
>> +}
> 
> --
> Best wishes,
> Vladimir
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180802/60e6ef56/attachment.sig>
