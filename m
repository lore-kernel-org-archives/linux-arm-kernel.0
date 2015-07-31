From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 31 Jul 2015 13:00:46 +0200
Subject: [PATCH] i2c: mediatek: fix transfer error handling
In-Reply-To: <1438054685-25214-1-git-send-email-eddie.huang@mediatek.com>
References: <1438054685-25214-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150731110045.GJ1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 11:38:05AM +0800, Eddie Huang wrote:
> From: Liguo Zhang <liguo.zhang@mediatek.com>
> 
> Reset i2c dma engine in hw init function.
> When occur i2c ack error, mtk_i2c_irq may is twice,
> first is the ack error interrupt, then the complete interrupt,
> so i2c->irq_stat need keep the two interrupt value, and only
> call complete() for the complete interrupt.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Looks to me this patch needs to be split up into one patch per issue?
And doesn't it kill the auto_restart functionality? Sascha?

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 9920eef..57d11b7 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -59,6 +59,7 @@
>  #define I2C_DMA_START_EN		0x0001
>  #define I2C_DMA_INT_FLAG_NONE		0x0000
>  #define I2C_DMA_CLR_FLAG		0x0000
> +#define I2C_DMA_HARD_RST		0x0002
>  
>  #define I2C_DEFAULT_SPEED		100000	/* hz */
>  #define MAX_FS_MODE_SPEED		400000
> @@ -81,6 +82,7 @@ enum DMA_REGS_OFFSET {
>  	OFFSET_INT_FLAG = 0x0,
>  	OFFSET_INT_EN = 0x04,
>  	OFFSET_EN = 0x08,
> +	OFFSET_RST = 0x0c,
>  	OFFSET_CON = 0x18,
>  	OFFSET_TX_MEM_ADDR = 0x1c,
>  	OFFSET_RX_MEM_ADDR = 0x20,
> @@ -262,6 +264,10 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
>  	writew(control_reg, i2c->base + OFFSET_CONTROL);
>  	writew(I2C_DELAY_LEN, i2c->base + OFFSET_DELAY_LEN);
> +
> +	writel(I2C_DMA_HARD_RST, i2c->pdmabase + OFFSET_RST);
> +	udelay(50);
> +	writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_RST);
>  }
>  
>  /*
> @@ -550,16 +556,20 @@ err_exit:
>  static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
>  {
>  	struct mtk_i2c *i2c = dev_id;
> -	u16 restart_flag = 0;
> +	u16 intr_stat = 0;
>  
> -	if (i2c->dev_comp->auto_restart)
> -		restart_flag = I2C_RS_TRANSFER;
> +	intr_stat = readw(i2c->base + OFFSET_INTR_STAT);
> +	writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
>  
> -	i2c->irq_stat = readw(i2c->base + OFFSET_INTR_STAT);
> -	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR
> -		| I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
> +	/*
> +	 * when occurs i2c ack error, mtk_i2c_irq is called twice,
> +	 * first is the ack error interrupt, then the complete interrupt,
> +	 * i2c->irq_stat need keep the two interrupt value.
> +	 */
> +	i2c->irq_stat |= intr_stat;
>  
> -	complete(&i2c->msg_complete);
> +	if (i2c->irq_stat & I2C_TRANSAC_COMP)
> +		complete(&i2c->msg_complete);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -729,3 +739,4 @@ module_platform_driver(mtk_i2c_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MediaTek I2C Bus Driver");
>  MODULE_AUTHOR("Xudong Chen <xudong.chen@mediatek.com>");
> +MODULE_AUTHOR("Liguo Zhang <liguo.zhang@mediatek.com>");
> -- 
> 1.7.9.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/3e2b03bf/attachment-0001.sig>
