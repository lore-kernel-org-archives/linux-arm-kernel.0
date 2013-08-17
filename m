From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 17 Aug 2013 21:59:10 +0200
Subject: [PATCH RESEND] can: mcp251x: Replace power callbacks with
 regulator API
In-Reply-To: <20130817083014.a01144051b158c34ec7dd9d9@mail.ru>
References: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
 <52049C44.6030902@pengutronix.de> <520EDDA8.6050309@gmail.com>
 <20130817083014.a01144051b158c34ec7dd9d9@mail.ru>
Message-ID: <520FD60E.4040709@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 06:30 AM, Alexander Shiyan wrote:
[...]
>> Since DT conversion isn't finished, I still accept the board files.
>> But this patch should be split into two parts. One is for pxa, and the
>> other one is for net.
> 
> Patch cannot be splitted because this can create hole which break git-bisect.
> 
> In any case, I want to create a v2 with a more detailed description, and I
> have a supplementary question for the CAN subsystem maintainers.
> "Transciever power" is not used by any of the boards, can we remove it
> completely? This will greatly simplify driver.

Do you mean the former transceiver_enable() callback?

>  struct mcp251x_platform_data {
>  	unsigned long oscillator_frequency;
>  	unsigned long irq_flags;
> -	int (*board_specific_setup)(struct spi_device *spi);
> -	int (*transceiver_enable)(int enable);
> -	int (*power_enable) (int enable);
>  };

Having a switchable transceiver is a quite common thing. So I'd like
that you keep it. The flexcan driver was just converted from a callback
to a regulator too. It already has device tree bindings and I'd like to
use these bindings as a standard for new drivers. From flexcan's dt
bindings:

> - xceiver-supply: Regulator that powers the CAN transceiver

which translates into:

> priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");

Can you please use "xceiver" instead of "transceiver", so that future DT
binding will fit the scheme.

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130817/bb6c21aa/attachment-0001.sig>
