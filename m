From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 7 Feb 2017 18:09:04 +0800
Subject: [PATCH v4 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <1486351569-4814-3-git-send-email-baoyou.xie@linaro.org>
References: <1486351569-4814-1-git-send-email-baoyou.xie@linaro.org>
 <1486351569-4814-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <16935e86-cdd7-ad21-d72a-4183a0d01934@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?02?06? 11:26, Baoyou Xie wrote:
> +}
> +
> +static irqreturn_t zx2967_i2c_isr(int irq, void *dev_id)
> +{
> +	u32 status;
> +	struct zx2967_i2c_info *zx_i2c = (struct zx2967_i2c_info *)dev_id;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&zx_i2c->lock, flags);
> +
> +	status = zx2967_i2c_readl(zx_i2c, REG_STAT) & I2C_INT_MASK;
> +	zx2967_i2c_isr_clr(zx_i2c);
> +
> +	if (status & I2C_ERROR_MASK) {
> +		spin_unlock_irqrestore(&zx_i2c->lock, flags);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (status & I2C_TRANS_DONE)
> +		complete(&zx_i2c->complete);
> +
> +	spin_unlock_irqrestore(&zx_i2c->lock, flags);

The spin lock appears only once here, in ISR. I am not sure what you 
want to protect.
> +
> +	return IRQ_HANDLED;
> +}
> +


I am fine with all other parts.

Jun
