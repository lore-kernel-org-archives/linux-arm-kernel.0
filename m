From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 23 Nov 2014 09:31:12 +0100
Subject: [PATCH] Add support for SCCB devices into PXA27x I2C controller
In-Reply-To: <54711397.9060601@tul.cz>
References: <54711397.9060601@tul.cz>
Message-ID: <20141123083112.GA1932@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 22, 2014 at 11:52:07PM +0100, Petr Cvek wrote:
> Add support for SCCB devices into PXA27x I2C controller.
> 
> Fix generated START but no STOP for message without I2C_M_NOSTART flag. Add
> support for I2C_M_IGNORE_NAK flag.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

I can't apply the patch. What is this based on? Can you rebase it to
i2c/for-next or the latest rc or at least the latest stable?

> ---
>  drivers/i2c/busses/i2c-pxa.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..adad044 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -885,7 +885,14 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c,
> u32 isr)
>          return; /* ignore */
>      }
> 
> -    if (isr & ISR_BED) {
> +    /*
> +     * Ignore NAK when flag I2C_M_IGNORE_NAK is present,
> +     * this enables use of SCCB devices
> +     */

I'd think this comment is not needed since I2C_M_IGNORE_NAK is
self-explaining.

> +    if ((isr & ISR_BED) &&
> +        (!((i2c->msg->flags & I2C_M_IGNORE_NAK) &&
> +            (isr & ISR_ACKNAK)))) {
> +
>          int ret = BUS_ERROR;
> 
>          /*
> @@ -919,12 +926,15 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c,
> u32 isr)
>          icr |= ICR_ALDIE | ICR_TB;
> 
>          /*
> -         * If this is the last byte of the last message, send
> -         * a STOP.
> +         * If this is the last byte of the last message or last byte
> +         * or any message without I2C_M_NOSTART, send a STOP.
>           */
> -        if (i2c->msg_ptr == i2c->msg->len &&
> -            i2c->msg_idx == i2c->msg_num - 1)
> -            icr |= ICR_STOP;
> +        if (((i2c->msg_ptr == i2c->msg->len) &&
> +            (!(i2c->msg->flags & I2C_M_NOSTART))) ||
> +            ((i2c->msg_ptr == i2c->msg->len) &&
> +            (i2c->msg_idx == i2c->msg_num - 1)))

You could factor out the length check. And you should check for
I2C_M_STOP, no?

> +                icr |= ICR_STOP;
> +
>      } else if (i2c->msg_idx < i2c->msg_num - 1) {
>          /*
>           * Next segment of the message.
> -- 
> 1.7.12.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141123/5b4b7190/attachment.sig>
