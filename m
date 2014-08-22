From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 22 Aug 2014 09:16:41 -0700
Subject: [PATCH v3] i2c: rk3x: fix bug that cause transfer fails in
 master receive mode
In-Reply-To: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
References: <1408657107-8715-1-git-send-email-addy.ke@rock-chips.com>
 <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140822161641.GA12900@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Addy,

On Fri, Aug 22, 2014 at 09:13:11AM +0800, Addy Ke wrote:
> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
> must be less than or equal 32 bytes at a time.
> 
> Tested on rk3288-pinky board, elan receive 158 bytes data.
> 
> Acked-by: Max Schwarz <max.schwarz@online.de>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v2:
> - Use cleaner syntax as suggested by Sergei.
> - Update commit message as suggested by Wolfram.
> 
> Changes in v3:
> - fix typo: maste --> master and double spaces after 'len'
> 
>  drivers/i2c/busses/i2c-rk3x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 69e1185..806724a 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -323,6 +323,10 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
>  	/* ack interrupt */
>  	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
>  
> +	/* Can only handle a maximum of 32 bytes at a time */
> +	if (unlikely(len > 32))
> +		len = 32;

I do not think we should be using unlikely here (and in another spot in the
driver): unlikely should be used only if the condition happens extremely
infrequently in all of the systems. Here, if a box happens to have a device
that uses transfers larger than 32 bytes we'd be hitting unlikely branch pretty
often.

Thanks.

-- 
Dmitry
