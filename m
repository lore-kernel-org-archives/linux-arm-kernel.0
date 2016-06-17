From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 17 Jun 2016 10:48:54 +0200
Subject: [RFC] Fix D_CAN corrupted bytes by using 32 bit register r/w
In-Reply-To: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <dd1178ed-64e7-a117-82e7-4787b59e98c6@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 06:10 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Corrupted bytes in CAN transmission on the Altera CycloneV seem
> to be an issue because the D_CAN registers are 32 bits [1].
> Changing to a 32 bit write fixes the problem and this patch
> includes one method of fixing the problem by selecting 32 bit
> writes for D_CAN or 16 bit writes for C_CAN.
> 
> Another option would be to remove the D_CAN if test and always use
> the priv->read_reg32() and priv->write_reg32() for both C_CAN and
> D_CAN. The C_CAN read_reg32() function performs two 16 bit writes.
> The code is cleaner without the D_CAN if branch but it adds additional
> overhead for C_CAN (2nd 16 bit write may not be needed in many cases).

Better save the overhead, as an additional register access may seems to
be quite expensive on some platforms.

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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/550a4c14/attachment.sig>
