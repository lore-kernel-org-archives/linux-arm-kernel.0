From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 12 May 2014 17:47:29 +0200
Subject: [PATCHv3] C_CAN: Add 32-bit accesses
In-Reply-To: <20140506135702.GA9879@amd.pavel.ucw.cz>
References: <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
 <20140506135702.GA9879@amd.pavel.ucw.cz>
Message-ID: <5370ED11.4000002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 03:57 PM, Pavel Machek wrote:
> Add helpers for 32-bit accesses and replace open-coded 32-bit access
> with calls to helpers. Minimum changes are done to the pci case, as I
> don't have access to that hardware.

I'll ask David Miller to merge net/master into net-next/master so that I
can apply this patch.

For now, I've applied the patch to can-next testing-c_can
(git://gitorious.org/linux-can/linux-can-next.git testing-c_can)

Can you make other patches based on that tree, please.

> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -63,6 +63,23 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
>  	writew(val, priv->base + 2 * priv->regs[index]);
>  }
>  
> +static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
> +{
> +	u32 val;
> +
> +	val = priv->read_reg(priv, index);
> +	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
> +
> +	return val;
> +}
> +
> +static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
> +		u32 val)
> +{
> +	priv->write_reg(priv, index + 1, val>>16);

spaces around >>, I'll fix this while applying.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/f8f4bdc9/attachment-0001.sig>
