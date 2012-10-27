From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 27 Oct 2012 18:55:53 +0000 (UTC)
Subject: [PATCH v2 7/7] i2c: omap: implement handling for 'transferred'
 bytes
In-Reply-To: <1351167915-15079-8-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-8-git-send-email-balbi@ti.com>
Message-ID: <alpine.DEB.2.00.1210271852330.18535@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 25 Oct 2012, Felipe Balbi wrote:

> this is important in cases where client driver
> wants to know how many bytes were actually
> transferred.
> 
> There is one trick here: if transfer is completed,
> meaning I2C_CNT reaches zero, then ARDY will be
> asserted to let SW know that it can program a
> new transfer.
> 
> When ARDY is asserted, I2C_CNT is reset to the
> original value (msg->len), which means that
> for a successful message, msg->transferred = msg->len
> and we don't need to spend time with a register
> read.
> 
> In case of NACK condition, however, I2C_CNT will
> remain with the end value which is the amount of
> data transferred until NACK condition found on the
> bus inclusive. In this situation, msg->transferred
> needs to be initialized with:
> 
> msg->len - read(I2C_CNT) - 1;
> 
> This patch implements exactly that handling.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 699fa12..d268e92 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -588,6 +588,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>  		goto out;
>  	}
>  
> +	msg->transferred = msg->len;
> +	wmb();

If this barrier is being used to ensure that the compiler doesn't move 
this store past the point at which the I2C interrupt handler can be 
entered, then please consider the same comments as on the other 
patch that adds a barrier:

http://marc.info/?l=linux-omap&m=135129247524136&w=2

http://marc.info/?l=linux-omap&m=135135357305794&w=2


- Paul
