From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 21 Aug 2014 22:04:31 +0400
Subject: [PATCH] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
In-Reply-To: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
References: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <53F634AF.1010303@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/21/2014 09:50 PM, Addy Ke wrote:

> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one transaction, so the size of data to be write/read to/from
> TXDATAx/RXDATAx must be less than or equal 32 bytes at a time.

> Test on pinky board, elan receive 158 bytes data.

> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>   drivers/i2c/busses/i2c-rk3x.c | 3 +++
>   1 file changed, 3 insertions(+)

> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 69e1185..dc0aa64 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -323,6 +323,9 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
>   	/* ack interrupt */
>   	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
>
> +	/* Can only handle a maximum of 32 bytes at a time */
> +	len = (len > 32) ? 32 : len;

    Why not min(len, 32)? Or even:

	if (len > 32)
		len = 32;

WBR, Sergei
