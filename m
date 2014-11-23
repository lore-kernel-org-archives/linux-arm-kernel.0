From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 23 Nov 2014 19:23:02 +0300
Subject: [PATCH] Add support for SCCB devices into PXA27x I2C controller
In-Reply-To: <54711397.9060601@tul.cz>
References: <54711397.9060601@tul.cz>
Message-ID: <547209E6.9010905@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/23/2014 1:52 AM, Petr Cvek wrote:

> Add support for SCCB devices into PXA27x I2C controller.

> Fix generated START but no STOP for message without I2C_M_NOSTART flag. Add
> support for I2C_M_IGNORE_NAK flag.

> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>   drivers/i2c/busses/i2c-pxa.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)

> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..adad044 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -885,7 +885,14 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32
> isr)
>           return; /* ignore */
>       }
>
> -    if (isr & ISR_BED) {
> +    /*

    Your patch has tabs replaces by spaces; probably your email agent's work. :-)

> +     * Ignore NAK when flag I2C_M_IGNORE_NAK is present,
> +     * this enables use of SCCB devices
> +     */
> +    if ((isr & ISR_BED) &&
> +        (!((i2c->msg->flags & I2C_M_IGNORE_NAK) &&
> +            (isr & ISR_ACKNAK)))) {
> +

   This empty line is not needed.

[...]

WBR, Sergei
