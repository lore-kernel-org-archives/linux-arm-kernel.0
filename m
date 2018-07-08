From: peda@axentia.se (Peter Rosin)
Date: Sun, 8 Jul 2018 13:58:01 +0200
Subject: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
In-Reply-To: <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <eb0a3e62-3efb-3862-3da5-bdf2952a146c@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-07 11:29, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> This function is needed by i2c_get_dma_safe_msg_buf() potentially.
> It is used to free DMA safe buffer when DMA operation fails.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  drivers/i2c/i2c-core-base.c | 14 ++++++++++++++
>  include/linux/i2c.h         |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 31d16ad..2b518ea 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -2288,6 +2288,20 @@ void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
>  }
>  EXPORT_SYMBOL_GPL(i2c_release_dma_safe_msg_buf);
>  
> +/**
> + * i2c_free_dma_safe_msg_buf - free DMA safe buffer
> + * @msg: the message related to DMA safe buffer
> + * @buf: the buffer obtained from i2c_get_dma_safe_msg_buf(). May be NULL.
> + */
> +void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
> +{
> +	if (!buf || buf == msg->buf)
> +		return;
> +
> +	kfree(buf);

Considering that the i2c-core-smbus.c file does the following for its
DMA safe buffers...

static void i2c_smbus_try_get_dmabuf(struct i2c_msg *msg, u8 init_val)
{
	bool is_read = msg->flags & I2C_M_RD;
	unsigned char *dma_buf;

	dma_buf = kzalloc(I2C_SMBUS_BLOCK_MAX + (is_read ? 2 : 3), GFP_KERNEL);
	if (!dma_buf)
		return;

	msg->buf = dma_buf;
	msg->flags |= I2C_M_DMA_SAFE;

	if (init_val)
		msg->buf[0] = init_val;
}

...I do not think your variant of i2c_release_dma_safe_msg_buf is
appropriate for the i2c-core-base.c file. It's simply not possible to have
central knowledge of the rules for when to free the buffer, and encoding one
set of rules is only confusing (when there are more than one set of rules).
I suggest that you make your variant driver specific.

Cheers,
Peter

> +}
> +EXPORT_SYMBOL_GPL(i2c_free_dma_safe_msg_buf);
> +
>  MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
>  MODULE_DESCRIPTION("I2C-Bus main module");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 254cd34..6d62f93 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -860,6 +860,7 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
>  
>  u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold);
>  void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
> +void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
>  
>  int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
>  /**
> 
