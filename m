From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 24 Jul 2018 06:38:53 +0200
Subject: [PATCH v6 5/5] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <846bb908-f75e-1988-8f30-e49a537c7969@mleia.com>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-6-o.rempel@pengutronix.de>
 <846bb908-f75e-1988-8f30-e49a537c7969@mleia.com>
Message-ID: <20270a57-6784-327a-e0c1-cb01c8eb5496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24.07.2018 01:31, Vladimir Zapolskiy wrote:
> Hi Oleksij,
> 
> On 07/22/2018 09:39 AM, Oleksij Rempel wrote:
>> The Mailbox controller is able to send messages (up to 4 32 bit words)
>> between the endpoints.
>>
>> This driver was tested using the mailbox-test driver sending messages
>> between the Cortex-A7 and the Cortex-M4.
>>
>> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [snip]
> 
>> +static int imx_mu_startup(struct mbox_chan *chan)
>> +{
>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>> +	int ret;
>> +
>> +	cp->irq_desc = devm_kasprintf(priv->dev, GFP_KERNEL, "imx_mu_chan[%i]",
>> +				      cp->idx);
>> +	if (!cp->irq_desc)
>> +		return -ENOMEM;
>> +
> 
> Again I would suggest to move this allocation to the loop in .probe function.

Why? In my case I use 2 channels. Why should I allocate 4 descriptors
for using only 2 of them?

The SCU driver will use only one channel...

> [snip]
> 
>> +
>> +	for (i = 0; i < IMX_MU_CHANS; i++) {
>> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
>> +
>> +		cp->idx = i;
>> +		cp->irq = irq;
> 
> ^^^^ right over here.
> 
>> +		priv->mbox_chans[i].con_priv = cp;
>> +	}
>> +
> 
> please feel free to add my technical side review tag to the next version:
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> FWIW I find that review comments from Lucas are pretty valid, I would
> recommend to incorporate them.

Ok

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/e1b3ccac/attachment.sig>
